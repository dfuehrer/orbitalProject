% orbElT2ijk.m
% deltat in seconds
% orbEl should have deltat and M0
function [r, v] = orbElT2ijk(orbEl)
    mu = 398600.442;
    r2d = 180/pi;
    orbEl.M = orbEl.M0 / r2d + sqrt(mu/a^3) * orbEl.deltat;
    orbEl.nu = Me2nu(orbEl.M, orbEl.e) * r2d;
    %[r, v] = orbEl2ijk(a, e, nu, i, OMEGA, omega);
    [r, v] = orbEl2ijk(orbEl);
end

