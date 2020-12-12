% pqw2ijk.m
function vectIJK = pqw2ijk(vect, i, OMEGA, omega)
    O = OMEGA * pi/180;
    o = omega * pi/180;
    i = i * pi/180;
    dcm = [cos(O)*cos(o) - sin(O)*sin(o)*cos(i), -cos(O)*sin(o) - sin(O)*cos(o)*cos(i),  sin(O)*sin(i)
           sin(O)*cos(o) + cos(O)*sin(o)*cos(i), -sin(O)*sin(o) + cos(O)*cos(o)*cos(i), -cos(O)*sin(i)
                                  sin(o)*sin(i),                         cos(o)*sin(i),         cos(i)];
    vectIJK = dcm * vect';
end
