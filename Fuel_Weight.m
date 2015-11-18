%%%  Fuel Fractions
% Updated 11/17/15 JRG

Parameters;

%% Startup and Take-off
W1_W0 = 1-C*0.25*((0.05*2*T0)/W0); %Weight fraction MTOW-Taxi
W2_W1 = 1-C*(1/60)*((2*T0)/W1); %Weight fraction Taxi-TO

%% Climb
n = 20; %[integer] Number of climb segments
W(1) = W2_W1*W1_W0*W0; %Weight at start of climb
for i=1:n
    V_climb(i) = sqrt((W(i)/Sref)
end
W3 = W(n+1); %Weight at end of climb

%% Cruise
n = 20; %[integer] Number of cruise segments
W(1) = W3; %Weight at start of cruise
for i=1:n
    CL(i) = (2*W(i))/(rho*Sref*V_cruise^2);
    L_D(i) = CL(i)/(CD0 + K*CL(i)^2);
    W(i+1) = W(i)*exp(-(R*C)/(V*L_D(i)));
end



%Anaaytical result for cruise
%W_end = ((rho_cruise*Sref*V_cruise^2)/2)*sqrt(CD0/K)*tan(atan(sqrt(K/CD0)*((2*W_start)/(rho_cruise*Sref*V_cruise^2)))-((C*R)/V)*sqrt(CD0*K));

