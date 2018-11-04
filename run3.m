n = 4096;


y=[];

for ch=1:2,
    y1=zeros(n,1);
    for alpha=linspace(0,1,100)*2*pi,
        x = linspace(-4,4,n)';
        q = x*[0, cos(alpha), sin(alpha)];
        q(3) = q(3)*((ch-1)*2-1);
        D = ss(q);
%        D = D - mean(D);
%        D = exp(D/32);
        D(isnan(D))=0;
        D=D.^3;
        D = [0; D(end/2+1:end-1);0; D(2:end/2)];
%        D = D(end:-1:1);
        D=D.*exp(1i*pi*4*rand(size(D)));
%        D = D*1i;
        D = [D; conj(D(end:-1:1))];
        d = ifft(D);
%        d = dct(D);
        nn = size(d,1);
        %d = d .* hanning(nn);
        d = [d(end/2+1:end); d(1:end/2)];
        d(1:end/2) = d(1:end/2) + y1(end-nn/2+1:end,:);
        y1 = y1(1:end-nn/2);
        y1 = [y1;d];
    end
    nn=size(y1,1);
    y=[y y1];
end

y=real(y);
y=y/repmat(max(max(abs(y))), 1, size(y,2));
p = audioplayer(y, 48000);
play(p);

