%calcAz.m
function A = calcAz(i, phi)
    A = asind(cosd(i) / cosd(phi));
end
