%%% Landing Distance
%Updated 12/5/15 JRG

function [d_landing]=Landing_Distance(parameters)
W0 = parameters.W0;
Sref = parameters.Sref;

WL = 0.84*W0; %[lb] Maximum landing weight is 84% of MTOW (average of historical values [Roskam])
CLmax_landing = 2.6;
L_D_landing = 6.1033;
rho_SL = 0.0023768924; %[slugs/ft^3] Sea level air density
rho_SIN = 0.002185959988755; %[slug/ft^3]

Vs = sqrt((2/(rho_SIN*CLmax_landing))*(WL/Sref)); %[ft/s] Calculate stall speed at maximum landing weight
Vapp = 1.3*Vs; %[ft/s] Approach speed is 1.3x stall speed
Vland = 1.15*Vs; %[ft/s] Touchdown speed is 1.15x stall speed

d_air = 50*L_D_landing+(L_D_landing/(2*32.174))*(Vapp^2 - Vland^2); %[ft] 50-foot obstacle clearance distance (approach) [ft] Source: http://adg.stanford.edu/aa241/performance/landing.html
d_ground = 80*(WL/Sref)*(1/((rho_SIN/rho_SL)*CLmax_landing)); %[ft] Ground roll [Martins]

d_landing = d_air+d_ground %[ft] Actual landing distance;
LandingFieldLength = 1.66*d_landing %[ft] Borked landing distance per FAR 25.125
end
