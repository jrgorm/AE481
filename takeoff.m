%%% TW-WS Calculation and Plotting 
% Updated 11/9/2015 Author: ---

parameters;
dragpolarPDR;

BFL = S_EWR; %Balanced field length (BFL) (ft)
               
TOP = BFL/37.5; %Take-off parameter (TOP) 

T_W_takeoff = W_S/((rho_EWR/rho_SL)*CLmax_climb*TOP);