% gibbs.m
function v2 = gibbs(r1, r2, r3)
    r2d = 180 / pi;
    mu = 398600.442;
    r1n = norm(r1);
    r2n = norm(r2);
    r3n = norm(r3);

    % step 1
    r2cr3 = cross(r2, r3);
    geps = (dot(r1, r2cr3)) / (r1n * norm(r2cr3));
    if geps < 0.349
        fprintf('Coplanar enough with eps of %g\n', geps)
    else
        fprintf('Not coplanar enough with eps of %g\n', geps)
        return
    end

    % step 2
    theta12 = acos(dot(r1, r2) / r1n / r2n);
    theta23 = acos(dot(r2, r3) / r2n / r3n);
    if theta12 > 1/r2d && theta23 > 1/r2d
        fprintf('ang sep good: t12 = %g and t23 = %g\n', theta12*r2d, theta23*r2d);
    else
        fprintf('ang sep too small: t12 = %g and t23 = %g\n', theta12*r2d, theta23*r2d);
        return
    end

    % step 3
    D = cross(r2, r3) + cross(r3, r1) + cross(r1, r2)
    N = r1n*cross(r2, r3) + r2n*cross(r3, r1) + r3n*cross(r1, r2)
    S = (r2n-r3n)*r1 + (r3n-r1n)*r2 + (r1n-r2n)*r3
%     disp('D N S');
%     disp(D);
%     disp(N);
%     disp(S);

    % step 4
    smnd = sqrt(mu / (norm(N)*norm(D)));
    v2 = smnd * cross(D, r2) / r2n + smnd * S;
end
