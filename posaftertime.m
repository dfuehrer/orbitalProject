function [M_MIR, M_SS, M_B] = posaftertime(dt)
mu = 398600.4;
%Space Shuttle Orbital Elements
a0_SS = 6563.3698; %km
M0_SS = deg2rad(0); %rad
%epoch of Dec. 24, 1998 at 0:00:00 UT, Julian date 2,448,980.500
%MIR Space Station Orbital Elements
a0_MIR = 6727.7061; %km
M0_MIR = deg2rad(242.4909); %rad
t0_MIR = (3*60+40)*60+53.615;
%Buran orbital elements
a0_B = 364+6378;
M0_B = deg2rad(232.52);
t0_B = 22235;
%epoch of Dec. 24, 1998 at 3:40:53.615 UT
T_SS = 2*pi*sqrt((a0_SS^3)/mu);
T_MIR = 2*pi*sqrt((a0_MIR^3)/mu);
T_B = 2*pi*sqrt((a0_B^3)/mu);
k = @(T,t0) floor((dt-t0)/T);

M_SS = mod(sqrt(mu/(a0_SS^3))*(dt) - 2*pi*k(T_SS,0)+M0_SS, 2*pi);
M_MIR = mod(sqrt(mu/(a0_MIR^3))*(dt-t0_MIR) - 2*pi*k(T_MIR,t0_MIR)+M0_MIR, 2*pi);
M_B = mod(sqrt(mu/(a0_B^3))*(dt-t0_B) - 2*pi*k(T_B,t0_B)+M0_B, 2*pi);




M_SS = rad2deg(M_SS);
M_MIR = rad2deg(M_MIR);
M_B = rad2deg(M_B);
end