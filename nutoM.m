function [M_SS,M_MIR] = nutoM(nu_SS,nu_MIR)

nu_SS = deg2rad(nu_SS);
nu_MIR = deg2rad(nu_MIR);
e_SS = .004806;
e_MIR = .0007444;

E_SS = 2*atan(sqrt((1-e_SS)/(1+e_SS))*tan(nu_SS/2));
M_SS = E_SS-e_SS*sin(E_SS);

E_MIR = 2*atan(sqrt((1-e_MIR)/(1+e_MIR))*tan(nu_MIR/2));
M_MIR = E_MIR-e_MIR*sin(E_MIR);

M_MIR = rad2deg(M_MIR);
M_SS = rad2deg(M_SS);

end