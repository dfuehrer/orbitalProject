%dRJ2dr.m

% rv has is x, vx, y, vy, z, vz because im lazy
function dRdr = dRJ2dr(rv)
    J2 = .001826267;
    mu = 398600.442;
    RE = 6378.137;

    r2 = rv(1)^2 + rv(3)^2 + rv(5)^2;
    thjrr = 1.5 * J2 * (RE^2 / r2);
    fzbr  = 5 * rv(5)^2 / r2;
    xydRdr = thjrr * (fzbr - 1);
    dRdr = [xydRdr;
            xydRdr;
            thjrr * (fzbr - 3)];
end
