%%% TW-WS Plot for Cruise
% Updated 11/9/2015 Author: ---

parameters;
dragpolarPDR;

%Velocity at cruise
v_cruise = mCruise*aCruise;

%Dynamic Pressure
q_cruise = .5*rho_cruise*v_cruise^2;

T_W_cruise = q_cruise.*CD0_cruise./W_S + W_S.*(1./q_cruise./pi./AR./e_cruise);
