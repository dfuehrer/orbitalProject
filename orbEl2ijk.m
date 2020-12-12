% orbEl2ijk.m
function [r, v] = orbEl2ijk(orbEl)
    r = orbEl2pqwR(orbEl);
    v = orbEl2pqwV(orbEl);
    r = pqw2ijk(r, orbEl);
    v = pqw2ijk(v, orbEl);
end

