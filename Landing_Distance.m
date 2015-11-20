%%% Landing Distance
%Updated 11/20/15 JRG

%SI units only
parameters;

WL = 0.84*MTOW; %[kg] Maximum landing weight is 84% of MTOW (average of historical values [Roskam])
CLmax_landing = 2.6;
L_D_landing = 6.1033;

Vs = sqrt((2/(rho_SIN*CLmax_landing))*(WL/511.79)); %[m/s] Calculate stall speed at maximum landing weight
Vapp = 1.3*Vs; %[m/s] Approach speed is 1.3x stall speed
Vland = 1.15*Vs; %[m/s] Touchdown speed is 1.15x stall speed

d_air = 0.3048*(50*L_D_landing+(L_D_landing/(2*32.174))*((Vapp*3.280839895013123)^2 - (Vland*3.280839895013123)^2)); %[m] 50-foot obstacle clearance distance (approach) [ft] Source: http://adg.stanford.edu/aa241/performance/landing.html
d_ground = 5*(WL/511.79)*(1/((rho_SIN/rho_SL)*CLmax_landing)); %[m] Ground roll [Martins]

d_landing = d_air+d_ground %[m] Actual landing distance;
LandingFieldLength = 1.66*d_landing %[m] Borked landing distance per FAR 25.125
