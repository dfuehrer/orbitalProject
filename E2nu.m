% E2nu.m
function nu = E2nu(E, e)
    nu = 2 * atan(sqrt((1+e) / (1-e)) * tan(E/2));
end
