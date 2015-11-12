%Updated 10/31/2015 Author: JRG

parameters;

%%% This equation uses ONLY Imperial units, sorry

Vs = sqrt((2/(rho_SIN*CLmax_landing))*(MTOW/5973.97028));
Vapp = 1.5*Vs;
Vland = 1.25*Vs;

d_air = 50*L_D_landing+(L_D_landing/(2*32.174))*(Vapp^2 - Vland^2); %50-foot obstacle clearance distance (approach) [ft] Source: http://adg.stanford.edu/aa241/performance/landing.html
d_ground = 80*(MTOW/5973.97028)*(1/((rho_SIN/rho_SL)*CLmax_landing)); %Ground roll [ft] Martins

d_landing = d_air+d_ground %Actual landing distance;
LandingFieldLength = 1.67*d_landing %Borked landing distance per FAR 25.125
