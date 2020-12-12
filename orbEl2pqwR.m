% orbEl2pqwR.m
function r = orbEl2pqwR(a, e, nu)
    nu = nu * pi/180;
    R = a * (1 - e ^ 2) / (1 + e * cos(nu));
    r = R * [cos(nu), sin(nu), 0];
end

