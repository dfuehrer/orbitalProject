%orbEl2deltaV.m
function dv = orbEl2deltaV(el1, el2)
    v1 = orbEl2pqwV(el1);
    v2 = orbEl2pqwV(el2);
    dv = abs(norm(v2 - v1));
end
