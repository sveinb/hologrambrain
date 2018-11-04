T = 1;
f0 = 50;
fs = 48000;
t = (0:1/fs:T).';
t = t(1:end-1);
dt = 1/fs;
n = length(t);
r0 = 0.3;


m = 5;
path = zeros(n, 3*m);

q = r0 * randn(m, 3);
v = r0*f0*2*pi*randn(m, 3);

%q = 0.5*[1 0 0;-1 0 0];
%v = [0 1 0;0 -1 0]*f0*2*pi;
G = f0^2*32*pi;

clf

for i=1:n,
%    plot(q(:,1),q(:,2), 'o');
%    axis([-1 1 -1 1]);
%    hold on
%    pause(0.1);

    x = q(:,1);
    y = q(:,2);
    z = q(:,3);
    dx = repmat(x, 1, m) - repmat(x', m, 1);
    dy = repmat(y, 1, m) - repmat(y', m, 1);
    dz = repmat(z, 1, m) - repmat(z', m, 1);
    d2 = dx.^2+dy.^2+dz.^2;
    mind2 = 0.01;
    d2(d2 < mind2) = mind2;
    Fx = dx ./ sqrt(d2) ./ d2;
    Fy = dy ./ sqrt(d2) ./ d2;
    Fz = dz ./ sqrt(d2) ./ d2;
    Fx(isnan(Fx)) = 0;
    Fy(isnan(Fy)) = 0;
    Fz(isnan(Fz)) = 0;
    Fx = sum(Fx')';
    Fy = sum(Fy')';
    Fz = sum(Fz')';
    v = v - G * [Fx Fy Fz]*dt ./ m;
    q = q + v*dt;
    d = sqrt(sum(q.^2, 2));
    maxdist = 10;
    q(d > maxdist, :) = randn(sum(d > maxdist), 3) * r0;
    v(d > maxdist, :) = r0*f0*2*pi*randn(sum(d > maxdist), 3);
    path(i, :) = reshape(q, 1, 3*m);
end

clf
for i=1:m,
    p = [path(:, 3*(i-1)+1), path(:, 3*(i-1)+2), path(:, 3*(i-1)+3)];
    plot(p(:,1), p(:,2));
    axis([-1 1 -1 1]);
    hold on
y = [ss(p) ss(p*diag([1,1,-1]))];
y = y - repmat(mean(y), n, 1);
y = y / max(max(abs(y)));
p = audioplayer(y, 48000);
play(p);
end


