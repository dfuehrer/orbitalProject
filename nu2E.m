% nu2E.m
function E = nu2E(nu, e)
    E = 2 * atan(sqrt((1-e) / (1+e)) * tan(nu/2));
end
