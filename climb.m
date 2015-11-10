%%% TW-WS Curve for Climbing
% Updated 11/9/2015 Author: ---

parameters;
dragpolarPDR;

% Climb Gradients
G_1 = .005;
G_2 = .024;
G_3 = .012;

ks_1 = 1.2;
ks_2 = 1.15;
ks_3 = 1.2;

CL_climb_1 = 2.7;
CL_climb_2 = 2.3;
CL_climb_3 = 1.9;		
% 
% %Calc T/W min
T_W_climb_minimum_1 = Neng*(G_1+2*sqrt(CD0_climb_1/pi/AR/e_climb));
T_W_climb_minimum_2 = Neng*(G_2+2*sqrt(CD0_climb_2/pi/AR/e_climb))-0.005;
T_W_climb_minimum_3 = Neng*(G_3+2*sqrt(CD0_climb_3/pi/AR/e_cruise));
