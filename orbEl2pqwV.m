% orbEl2pqwV.m
function v = orbEl2pqwV(orbEl)
    mu = 398600.442;
    orbEl.nu = orbEl.nu * pi/180;
    coeff = sqrt(mu / orbEl.a / (1 - orbEl.e ^ 2));
    v = coeff * [-sin(orbEl.nu), orbEl.e + cos(orbEl.nu), 0];
end

