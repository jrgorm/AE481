%%% MAIN WING TAPER SIZING WITH M.A.C AND Sref : 
%%%%%Outputs Taper ratios, Croot, Ctip
% Updated 11/12/2015 Author: JRG

clc

parameters;

mac = 9.109;

syms croot lam 

[croot,lam] = solve(mac == (2/3)*((1+lam + lam^2)/(1+lam))*croot , croot == 2*WingAreaMeters/(b_w*(1+lam)), croot, lam);

croot = double(croot)
lam = double(lam)

ctip = lam.*croot
