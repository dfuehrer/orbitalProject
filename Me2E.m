% Me2E.m
function E = Me2E(Me, e)
    Enext = @(Ei) Ei - (Ei - e*sin(Ei) - Me) / (1 - e*cos(Ei));
    tol = 10e-12;
    Elast = Me + e * sin(Me);
    E = Enext(Elast);
    while abs(E - Elast) > tol
        Elast = E;
        E = Enext(E);
    end
end
