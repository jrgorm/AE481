%%% Fuel Fractions
% Updated 11/19/15 JRG

clear all
close all
Parameters;
g = 9.8; %[m/s^2] Gravitational acceleration

%%% NOTE all T0 is taken as single engine maximum thrust %%%

%% Startup and Take-off
W1_W0 = 1-C*0.25*((0.05*2*T0)/W0); %Weight fraction MTOW-Taxi
W1 = W1_W0*W0; %[N] Weight at end of taxi
W2_W1 = 1-C*(1/60)*((2*T0)/W1); %Weight fraction Taxi-TO
W2 = W2_W1*W1; %[N] Weight at end of take-off

%% Climb
n = 20; %[integer] Number of climb segments
h_inc = (cruise_h-hbase)/n; %[m] Climb segment height increment

W_climb = zeros(1,n); %Pre-allocation
W3_W2 = ones(1,n); %Pre-allocation

%Run first loop to create initial values
W_climb(1) = W2; %Set start of climb weight to end of take-off weight

V_climb(1) = sqrt(((W_climb(1)./Sref)./(3*rho_EWR*CD0_climb)).*(((2*T0)./W_climb(1))+sqrt(((2*T0)./W_climb(1)).^2 +12*CD0_climb*K_climb))); %[m/s] Cruise segment velocity
CL_climb(1) = (2.*W_climb(1))./(rho_EWR.*Sref.*V_climb(1).^2);
CD_climb(1) = CD0_climb+K_climb.*CL_climb(1).^2;
D_climb(1) = (0.5*(rho_EWR.*V_climb(1).^2)).*Sref.*CD_climb(1); %[N] Drag force during climb

h(1) = h_inc.*(1)+hbase; %[m] Climb segment height
del_he(1) = (h(1)+((V_climb(1).^2)/(2*g)))-(hbase+((1.2*V_stall^2)/(2*g))); %[m] Variation between consecutive segments
    
W3_W2(1) = exp(-(C.*del_he(1))./(V_climb(1).*(1-D_climb(1)./(2*T0)))); %Weight fraction TO-cruise per segment
W_climb(2) = W3_W2(1).*W2; %[N] Weight at end of current climb segment
    
Ps(1) = (V_climb(1).*(2*T0-D_climb(1)))./W_climb(1);
x_climb(1) = del_he(1)./Ps(1); %[m] Ground distance covered during climb segment

for i=2:n
    V_climb(i) = sqrt(((W_climb(i)./Sref)./(3*rho_EWR*CD0_climb)).*(((2*T0)./W_climb(i))+sqrt(((2*T0)./W_climb(i)).^2 +12*CD0_climb*K_climb))); %[m/s] Cruise segment velocity
    CL_climb(i) = (2.*W_climb(i))./(rho_EWR.*Sref.*V_climb(i).^2);
    CD_climb(i) = CD0_climb+K_climb.*CL_climb(i).^2;
    D_climb(i) = ((rho_EWR.*V_climb(i).^2)./2).*Sref.*CD_climb(i); %[N] Drag force during climb
    
    h(i) = h_inc.*(i)+hbase; %[m] Climb segment height
    del_he(i) = (h(i)+((V_climb(i).^2)./(2*g)))-(h(i-1)+((V_climb(i-1).^2)./(2*g))); %[m] Variation between consecutive segments

    W3_W2(i) = exp(-(C.*del_he(i))./(V_climb(i).*(1-D_climb(i)./(2*T0)))); %Weight fraction TO-cruise per segment
    W_climb(i+1) = W3_W2(i).*W2; %[N] Weight at end of current climb segment
    
    Ps(i) = (V_climb(i).*(2*T0-D_climb(i)))./W_climb(i);
    x_climb(i) = del_he(i)./Ps(i); %[m] Ground distance covered during climb segment
end
W3 = W_climb(n+1); %[N] Weight at end of climb
climb_dist = sum(x_climb); %[m] Total ground distance covered during climb phase 
R = R-climb_dist; %[m] Remaining cruise range after climb

%% Cruise
n = 20; %[integer] Number of cruise segments
W_cruise = zeros(1,n+1); %Pre-allocation
W_cruise(1) = W3; %Weight at start of cruise
for i=1:n
    CL_cruise(i) = (2*W_cruise(i))/(rho_cruise*Sref*V_cruise^2);
    L_D_cruise(i) = CL_cruise(i)/(CD0_cruise + K_cruise*CL_cruise(i)^2);
    W_cruise(i+1) = W_cruise(i)*exp(-(R*C)/(V_cruise*L_D_cruise(i))); %[N] Compute aircraft weight for next cruise segment
end
W4 = W_cruise(n+1); %[lb] Weight at end of cruise
W4_W3 = W4/W3; %Weight fraction climb-cruise

%Analytical result for cruise - useful for comparison with segment method
%W_end = ((rho_cruise*Sref*V_cruise^2)/2)*sqrt(CD0_cruise/K_cruise)*tan(atan(sqrt(K+cruise/CD0_cruise)*((2*W3)/(rho_cruise*Sref*V_cruise^2)))-((C*R)/V_cruise)*sqrt(CD0_cruise*K_cruise));
%W4_W3_analytical = W_end/W3;

%% Loiter
CL_loiter = sqrt(CD0_loiter/K_loiter);
CD_loiter = CD0_loiter+K_loiter*CL_loiter^2;
L_D_loiter = CL_loiter/CD_loiter;

W5_W4 = exp(-(E_loiter*C_loiter)/L_D_loiter); %Weight fraction cruise-loiter
W5 = W5_W4*W4; %[N] Weight at end of loiter

%% Descent, alternate, landing
W6_W5 = 0.990; %Weight fraction loiter-descent [Roskam]
W7_W6 = exp(-R_alt/V_alt*C_alt/L_D_alt); %Weight fraction descent-alternate
W8_W7 = 0.992; %Weight fraction alternate-landing-shutdown [Roskam]

%% Weight
Mff = W8_W7*W7_W6*W6_W5*W5_W4*W4_W3*W3_W2*W2_W1*W1_W0; %Total weight fraction startup-shutdown
WFused_W0 = 1-Mff; %Ratio of burned fuel to MTOW
WF = WFused_W0*W0; %[N] Fuel weight

%% Plots

% figure
% plot(R,
