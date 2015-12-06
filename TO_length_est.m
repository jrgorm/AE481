%%% Field length estimation
% Updated 12/5/2015 JRG
% http://www.aerospaceweb.org/question/performance/q0088.shtml

function [FAR_dist] = TO_length_est(parameters)
W0 = parameters.W0; %[lb]
T0 = parameters.T0; %[lb]
Sref = parameters.Sref*0.09290304; %[m^2] 
cWing = parameters.cWing*0.3048; %[m]
Dfus = parameters.Dfus*0.3048; %[m]

W0 = W0*0.45359237*9.81; % [N]
T0 = T0*4.44822162; %Total thrust [N]
S_wing_wet = Sref-cWing*Dfus;  %[m^2] Sref - root chord*fuselage diameter
CL_max = 1.9;
L_D_to = 7.3;
v_clear = 10.668; %[m] Obstacle height
ang_rot = 9; %[deg] Must not exceed tail angle!
mu = 0.02;  %concrete runway friction coefficient
rho_ewr = 1.15; %[kg/m^3] July average high T @ EWR, 303K, 1 atm, worst case scenario
V_mu = sqrt(W0*2/rho_ewr/S_wing_wet/CL_max); %[m/s] Min unstick speed = stall speed
V_lof = 1.1*V_mu; %[m/s] Min unstick speed + 10%, liftoff speed
V_r = V_mu*1.05; %[m/s] Rotation speed
V2 = 1.2*V_mu; %[m/s] Obstacle clearance speed
CD_to = CL_max/L_D_to;
D = 0.5*rho_ewr*V_lof^2*S_wing_wet*CD_to; %[N] aero drag
%x_accel = 1.44*W0^2/(9.81*rho_ewr*S_wing_wet*(T0-D-mu*W0));
x_g = W0/((CD_to-mu*CL_max)*(9.81*rho_ewr*S_wing_wet))*log((T0-mu*W0)/((T0-mu*W0)-1.21*(CD_to-mu*CL_max)*W0/CL_max)); %[m]
%Assume 9 deg rotation
x_a = v_clear/tand(ang_rot); %[m]
x = x_g + x_a; %[m] Landing distance
FAR_dist = 1.15*x;  %[m] FAR landing distance with 15% margin required

%%% Table Generation
 %%% Item Names
 Item = { 'Takeoff Distance'; 'FAR Field Length'; 'Lift-off Speed';'Min Safe Unstick Speed'; 'Takeoff Climb Speed at 35 ft'; 'Rotation Speed'; 'Rotation Angle'};
 %%% Item costs
 Stuff = [x; FAR_dist; V_lof; V_mu; V2; V_r; ang_rot];
 Stuff(3:6,1) = Stuff(3:6,1)*1.94384;
 format long g
 %%% Round values to nearest meter
 Stuff = round(Stuff);
 table(Item,Stuff)
end
