% ijk2orbEl.m
function [a, e, nu, i, OMEGA, omega] = ijk2orbEl(rv, vv)
    mu = 398600.442;
    r = norm(rv);
    v = norm(vv);
    energy = v^2 / 2 - mu / r;
    a = -mu / 2 / energy;
    ev = ((v^2 - mu / r) * rv - dot(rv, vv) * vv) / mu;
    e = norm(ev);
    hv = cross(rv, vv);
    h = norm(hv);
    r2d = 180 / pi;
    i = acos(hv(3) / h) * r2d;
    n = [-hv(2), hv(1), 0];
    OMEGA = mod((atan2(n(2), n(1)) + pi*2), (pi * 2)) * r2d;
    omega = mod((atan2(dot(ev, cross(hv, n )), h * dot(ev, n )) + pi*2), (pi * 2)) * r2d;
    nu    = mod((atan2(dot(rv, cross(hv, ev)), h * dot(rv, ev)) + pi*2), (pi * 2)) * r2d;
end

