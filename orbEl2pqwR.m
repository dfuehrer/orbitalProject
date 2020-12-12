% orbEl2pqwR.m
function r = orbEl2pqwR(orbEl)
    orbEl.nu = orbEl.nu * pi/180;
    R = a * (1 - orbEl.e ^ 2) / (1 + orbEl.e * cos(orbEl.nu));
    r = R * [cos(orbEl.nu), sin(orbEl.nu), 0];
end

