% ijkT2orbEl.m
function [a, e, M0, i, OMEGA, omega] = ijkT2orbEl(rv, vv, deltat)
    mu = 398600.442;
    [a, e, nu, i, OMEGA, omega] = ijk2orbEl(rv, vv);
    r2d = 180 / pi;
    Me = nu2Me(nu / r2d, e);
    M0 = (Me - sqrt(mu / a ^ 3) * deltat) * r2d;
end

