%J2pertODE.m
function rdot = J2pertODE(t, rv)
    J2 = .001826267;
    mu = 398600.442;
    RE = 6378.137;

    r2 = rv(1)^2 + r(3)^2 + r(5)^2;
    mbrth = mu / r2^(1.5)
    dRdr = dRJ2dr(rv);
    rdot = [rv(2);
            -mbrth * rv(1) * (1 - dRdr(1));
            rv(4);
            -mbrth * rv(3) * (1 - dRdr(2));
            rv(6);
            -mbrth * rv(5) * (1 - dRdr(3))];
end
