% Updated 11/9/2015 Author: ---
clear all
close all
clc

%Wing lift coefficient in cruise
CL_cruise = .47;
%wing sweep at quarter chord
%   lambda = (solve)
%average wing thickness-to-chord ratio: t/c
t_c = 14/100;
%airfoil technology factor
k = 0.95;
%Cruise Mach number
M = .83;

M_crit = M;

%Solve for M_DD:
M_DD = M_crit + (0.1/80)^(1/3);

%selected airfoil has set t/c, use this to solve for sweep

syms lambda

lamb = solve(M_DD == (k/cos(lambda))-((t_c)/(cos(lambda))^2)-(CL_cruise/(10*((cos(lambda))^3))),lambda);

lamb = double(lamb/pi*180);
lamb = real(lamb);
lambda = [];

for i=1:size(lamb)
    if lamb(i) > 0
        lambda(end+1)=lamb(i);
    end
end

lambda = double(min(lambda));
lambda = [0:1:lambda]/180*pi;
%Drag Divergent Mach number:   
M_DD = (k./cos(lambda))-(((t_c)./(cos(lambda)).^2))-(CL_cruise./((10.*(cos(lambda)).^3)));

%Critical Mach number is the min Mach number for which there is sonic flow over any portion of the wing:   
M_crit = M_DD - (0.1/80)^(1/3);

%Wave drag coeff. For M > M_crit. If M < M_crit there are no shocks and wave drag is equal to zero:    
CD_wave = 20.*(M - M_crit).^4;

figure
[ax,p1,p2] = plotyy(lambda/pi*180,CD_wave,lambda/pi*180,M_crit)
ylabel(ax(1),'CD Wave')
ylabel(ax(2),'Critcal Mach Number')
xlabel('Quarter Cord Sweep (deg)');




