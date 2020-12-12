% orbEl2pqwV.m
function v = orbEl2pqwV(a, e, nu)
    mu = 398600.442;
    nu = nu * pi/180;
    coeff = sqrt(mu / a / (1 - e ^ 2));
    v = coeff * [-sin(nu), e + cos(nu), 0];
end

