function y = whang(T, f0, bpm, minrad, maxrad)
    global ss;
    fs = 48000;
    t = (0:1/fs:T).';
    t = t(1:end-1);
    n = length(t);
    bps = bpm / 60;
    nbeat = bps * T;
    rad = linspace(0, nbeat, n)';
    rad = rad-floor(rad);
    rad = 1-rad;
    rad = rad * maxrad + minrad;
    %rad = maxrad*(cos(2*pi*bps*t).^2+minrad).^0.1;
    path = [zeros(n,1), rad.*cos(2*pi*t*f0), rad.*sin(2*pi*t*f0)];
    %path = [zeros(n,1), ones(n,1), ones(n,1)];
    skip=100;
    for i=1:skip:n,
        path(i:i+skip-1, :) = path(i:i+skip-1, :) * rotz(i/n*360) * rotx(i/n*360*5);
    end
    path = path + repmat([0.1 0 0], n, 1);
    y = [ss(path) ss(path*diag([1,1,-1]))];
end
