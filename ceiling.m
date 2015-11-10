%%% TW-WS Curve for Ceiling
% Updated 11/9/2015 Author: ---

parameters;
dragpolarPDR;
cruise;

G = 0.001; % safty factor specified in slides

T_W_ceiling = G + 2 * sqrt(CD0_cruise * K_cruise);
