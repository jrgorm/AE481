%%% Maneuver
% Updated 11/9/2015 Author: ---

parameters;
dragpolarPDR;

%Maneuver speed
v_maneuver = mCruise*aCruise;

%Dynamic Pressure
q_maneuver = .5*rho_cruise*v_maneuver^2;

nz = 2.5;

T_W_maneuver = q_maneuver.*CD0_cruise./W_S + nz^2 .* (W_S./q_maneuver).* K_cruise;
