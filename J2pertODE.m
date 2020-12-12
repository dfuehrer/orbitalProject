%J2pertODE.m
function rdot = J2pertODE(t, rv)
    J2 = .001826267;
    mu = 398600.442;
    RE = 6378.137;

    r2 = rv(1).^2 + rv(3).^2 + rv(5).^2;
    mbrth = mu ./ r2^(1.5);
    thjrr = 1.5 * J2 .* (RE^2 ./ r2);
    fzbr  = 5 * rv(5).^2 ./ r2;
    xything = 1 - thjrr .* (fzbr - 1);
    rdot = [rv(2);
            -mbrth .* rv(1) .* xything;
            rv(4);
            -mbrth .* rv(3) .* xything;
            rv(6);
            -mbrth .* rv(5) .* (1 - thjrr .* (fzbr - 3))];
end
