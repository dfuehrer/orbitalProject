% laplace_gauss.m
function v2 = laplace_gass(lst, ra, dec, t, lat)

    r2d = 180 / pi;
    RE = 6378.137;
    mu = 398600.442;
    lst = lst / r2d;
    ra = ra / r2d;
    dec = dec / r2d;
    lat = lat / r2d;
    % 1
    R1 = RE * [cos(lat)*cos(lst(1)), cos(lat)*sin(lst(1)), sin(lat)]
    R2 = RE * [cos(lat)*cos(lst(2)), cos(lat)*sin(lst(2)), sin(lat)]
    R3 = RE * [cos(lat)*cos(lst(3)), cos(lat)*sin(lst(3)), sin(lat)]

    % 2
    rho1h = [cos(dec(1))*cos(ra(1)), cos(dec(1))*sin(ra(1)), sin(dec(1))]
    rho2h = [cos(dec(2))*cos(ra(2)), cos(dec(2))*sin(ra(2)), sin(dec(2))]
    rho3h = [cos(dec(3))*cos(ra(3)), cos(dec(3))*sin(ra(3)), sin(dec(3))]

    % 3
    tau1 = t(1) - t(2)
    tau3 = t(3) - t(2)
    tau  = tau3 - tau1

    %4
    p1 = cross(rho2h, rho3h)
    p2 = cross(rho1h, rho3h)
    p3 = cross(rho1h, rho2h)

    % 5
    D0  = dot(rho1h, p1)
    D11 = dot(R1, p1)
    D21 = dot(R2, p1)
    D31 = dot(R3, p1)
    D12 = dot(R1, p2)
    D22 = dot(R2, p2)
    D32 = dot(R3, p2)
    D13 = dot(R1, p3)
    D23 = dot(R2, p3)
    D33 = dot(R3, p3)

    %6
    A = (-D12 * tau3 / tau + D22 + D32 * tau1 / tau) / D0
    B = (D12 * (tau3 ^ 2 - tau ^ 2) * tau3 / tau + D32 * (tau ^ 2 - tau1 ^ 2) * tau1 / tau) / 6 / D0
    E = dot(R2, p2)
    R2sq = dot(R2, R2)
    a = -(A^2 + 2*A*E + R2sq)
    b = -2*mu*B*(A + E)
    c = -mu*B^2
    
    % 7
    tol = 1e-10;
    xnext = @(x) x - (x.^8 + a.*x.^6 + b.*x.^3 + c) ./ (8*x.^7 + 6*a.*x.^5 + 3*b.*x.^2);
    xlast = 2*norm(R2);
    x = xnext(xlast);
    while abs(x - xlast) > tol
        xlast = x;
        x = xnext(x);
    end
    if x < 0
        disp('i dont knwo what to do');
        rs = 0:100:20000;
        plot(rs, xnext(rs));
        return
    end
    r2 = x


    % 8
    rho1 = ((6*(D31*tau1/tau3 + D21*tau/tau3)*r2^3 + mu*D31*(tau^2 - tau1^2)*tau1/tau3) / (6*r2^3 + mu*(tau^2-tau3^2)) - D11) / D0
    rho2 = A + mu*B / r2^3
    rho3 = ((6*(D13*tau3/tau1 + D23*tau/tau1)*r2^3 + mu*D13*(tau^2 - tau3^2)*tau3/tau1) / (6*r2^3 + mu*(tau^2-tau1^2)) - D33) / D0

    % 9
    r2n = r2;
    r1 = R1 + rho1 * rho1h
    r2 = R2 + rho2 * rho2h
    r3 = R3 + rho3 * rho3h

    % 10
    f1 = 1 - .5*mu/r2n^3 * tau1^2
    f3 = 1 - .5*mu/r2n^3 * tau3^2
    g1 = tau1 - 1/6*mu/r2n^3 * tau1^3
    g3 = tau3 - 1/6*mu/r2n^3 * tau3^3

    % 11
    v2 = (-f3*r1 + f1*r3) / (f1*g3 - f3*g1);

end
