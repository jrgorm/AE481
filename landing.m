%%% TW-WS Plotting for Landing
% Updated 11/9/2015 Author: ---

parameters;
dragpolarPDR;

S_a = 1000; 
S_land = S_SIN;

W_S_land = (rho_SIN/rho_SL)*CLmax_landing/80*(S_land-S_a)/1.67; 