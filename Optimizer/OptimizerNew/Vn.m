%%% V-n Diagram
% Updated 11/30/15 JRG

close all;
clear all;

g = 32.174; %[ft/s^2] Gravitational acceleration
rhoSL = 0.0023768924; %[slugs/ft^3] Sea level air density
CLmaxcruise = 1.4;
CLmax = 2.6; % Landing configuration
W0=729715; %[lb]
Sref=5500; %[ft^2]
mCruise = 0.83;
aCruise = 973.09711; %[ft/s]
CLalpha = 0.4;
cWing = 40.288714; %[ft]

%% Equivalent airspeeds
Vcruise = 0.5924838012958963*aCruise*mCruise; %[knots] Cruise velocity
VS1 = sqrt((2/(rhoSL*CLmaxcruise))*(W0/Sref)); %[ft/s] Stall speed without flaps
mu = (2*(W0/Sref))/(rhoSL*cWing*CLalpha*g);
Kg = (0.88*mu)/(5.3+mu);
UB = 52; %[ft/s] (From EqGust.m plot)
VB = VS1*sqrt(1+(Kg*UB*Vcruise*CLalpha)/(498*(W0/Sref))); %[ft/s] [FAR 25.335(d)(1)]
%
UC = 37.5; %[ft/s] (From EqGust.m plot)
VC = VB+1.32*UC; %[ft/s] [FAR 25.335(a)(2)]
%
VMO = aCruise*0.88; %[ft/s]
VD = 1.07*VMO; %[ft/s] [Martins]
%
VA = VS1*sqrt(2.5); %[ft/s] The square-root value is the positive load factor at VC [FAR 25.335(c)]

%% Maneuver envelope
VEAS = [0:10:1000]; %[ft/s] Equivalent airspeed

for i=1:length(VEAS)
    n(i) = (rhoSL*CLmaxcruise*VEAS(i)^2)/(2*(W0/Sref)); %Load factors [Martins]
end

figure
plot(VEAS,n)
hold on
plot(VEAS,-n)
% VEAS boundaries
plot([VA 1000],[2.5 2.5],'k-')
plot([VB VB],[10 -10],'--')
plot([VC VC],[10 -10],'--')
plot([VD VD],[15 -15])

plot([0 1000],[-1,-1])



%% Gust envelope
% Vb = parameters.Vb;
% Vc = parameters.Vc;
% Vd = parameters.Vd;
% CLalpha = 1.5; %???????? AVL
% 
% 
% W0 = parameters.W0;
% Sref = parameters.Sref;
% cWing = parameters.cWing;
% 
% 
% 
% for i=1:length(VEAS)
%     n_gustpos_Vb(i) = 1 + (Kg*CLalpha*Vb*VEAS(i))/(498*(W0/Sref));
%     n_gustneg_Vb(i) = 1 - (Kg*CLalpha*Vb*VEAS(i))/(498*(W0/Sref));
%     n_gustpos_Vc(i) = 1 + (Kg*CLalpha*Vc*VEAS(i))/(498*(W0/Sref));
%     n_gustneg_Vc(i) = 1 - (Kg*CLalpha*Vc*VEAS(i))/(498*(W0/Sref));
%     n_gustpos_Vd(i) = 1 + (Kg*CLalpha*Vd*VEAS(i))/(498*(W0/Sref));
%     n_gustneg_Vd(i) = 1 - (Kg*CLalpha*Vd*VEAS(i))/(498*(W0/Sref));
% end
