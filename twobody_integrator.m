function twobody_integrator

% Set up the time vector
t0 = 0;   % initial time
tf = 4*3600;      % Period in s
dt = 1;         % 20-second intervals
time = [t0:dt:tf]; % Time vector
mu=4902.801;  % Earth gravitational parameter

% Initial position components (km) and velocity components (km/s)
r0 = [2137.708157, 0, 0];
v0 = [0, 1.710764699, 0];
ICs = [r0, v0];

% Setting up ODE45
tolerance = 1e-13;
options = odeset('RelTol',tolerance,'AbsTol',tolerance);

% Integrate with a simple 2-body integrator
[time, RV] = ode45(@dR_2body, time, ICs, options);

% Record the components of Position and Velocity
x  = RV(:,1);
y  = RV(:,2);
z  = RV(:,3);
vx = RV(:,4);
vy = RV(:,5);
vz = RV(:,6);

figure(1) %Plot the position magnitude vs. time
plot(time,sqrt(x.^2+y.^2+z.^2));
xlabel('time (s)');ylabel('position magnitude (km)')

figure(2)  %Plot the orbit in 3D
plot3(x,y,z)
xlabel('x (km)');ylabel('y (km)');zlabel('z (km)')
grid on

figure(3) % Plot the kinetic, potential, and total energies
KE = (vx.^2+vy.^2+vz.^2)/2; PE = - mu./sqrt(x.^2+y.^2+z.^2);
Etot=KE+PE; 
plot(time,KE,time,PE,time,Etot);
xlabel('time (s)');ylabel('spec energy (km^2/s^2)')
legend('kinetic','potential','total')

figure(4) %Plot the % error in energy and angular momentum magnitude compared with initial values
KE0 = (vx(1).^2+vy(1).^2+vz(1).^2)/2; PE0 = - mu./sqrt(x(1).^2+y(1).^2+z(1).^2);
Etot0=KE0+PE0;
H=cross([x,y,z],[vx,vy,vz]);
hmag=(H(:,1).^2+H(:,2).^2+H(:,3).^2).^0.5;
h0mag=norm(cross([x(1),y(1),z(1)],[vx(1),vy(1),vz(1)]));
plot(time,abs((Etot-Etot0)./Etot0),time,abs(hmag-h0mag)./h0mag);
xlabel('time (s)');ylabel('% error')
legend('total energy error','angular momentum error')

end

function dRV = dR_2body(time,RV)

x  = RV(1);
y  = RV(2);
z  = RV(3);
vx = RV(4);
vy = RV(5);
vz = RV(6);
r=sqrt(x^2+y^2+z^2);

mu=4902.801;

ax = -mu*x/r^3;
ay = -mu*y/r^3;
az = -mu*z/r^3;

% The function will return the following variables in a vector
dRV = [vx; vy; vz; ax; ay; az];

end
