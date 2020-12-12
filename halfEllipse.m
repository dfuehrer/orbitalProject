%halfEllipse.m
function [dv, dt] = halfEllipse(r, a)
    mu = 398600.442;
    dt = pi .* sqrt(a.^3 ./ mu);
    vc = sqrt(mu ./ r);
    ve = sqrt(mu .* (2 ./ r - 1 / a));
    dv = abs(ve - vc);
end
