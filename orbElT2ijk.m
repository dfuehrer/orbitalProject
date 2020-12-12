% orbElT2ijk.m
% deltat in seconds
function [r, v] = orbElT2ijk(a, e, i, OMEGA, omega, M0, deltat)
    mu = 398600.442;
    r2d = 180/pi;
    M = M0 / r2d + sqrt(mu/a^3) * deltat;
    nu = Me2nu(M, e) * r2d;
    [r, v] = orbEl2ijk(a, e, nu, i, OMEGA, omega);
end

