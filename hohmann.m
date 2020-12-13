%hohmann.m
function [dv, dt] = hohmann(r1, r2)
    a = (r1 + r2) / 2;
    dv(1) = halfEllipse(r1, a);
    [dv(2), dt] = halfEllipse(r2, a);
end
