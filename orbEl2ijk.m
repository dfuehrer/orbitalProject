% orbEl2ijk.m
function [r, v] = orbEl2ijk(a, e, nu, i, OMEGA, omega)
    r = orbEl2pqwR(a, e, nu);
    v = orbEl2pqwV(a, e, nu);
    r = pqw2ijk(r, i, OMEGA, omega);
    v = pqw2ijk(v, i, OMEGA, omega);
end

