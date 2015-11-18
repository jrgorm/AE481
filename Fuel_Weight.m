%%% Fuel Fractions
% Updated 11/17/15 JRG

Parameters;
g = 32.174; %[ft/s^2] Gravitational acceleration
cruise_h = 35000; %[ft] Cruise altitude

%% Startup and Take-off
W1_W0 = 1-C*0.25*((0.05*2*T0)/W0); %Weight fraction MTOW-Taxi
W2_W1 = 1-C*(1/60)*((2*T0)/W1); %Weight fraction Taxi-TO

%% Climb
n = 20; %[integer] Number of climb segments
W(1) = W2_W1*W1_W0*W0; %[lb] Weight at start of climb
V_climb(1) = 0; %[ft/s] Initial climb airspeed (=/= climb rate)
h(1) = 35; %[ft] Altitude at start of climb
del_h = (cruise_h-35)/n; %[ft] Climb segment height increment
for i=2:n+1
    V_climb(i) = sqrt(((W(i)/Sref)/(3*rho*CD0))*(((2*T0)/W(i))+sqrt(((2*T0)/W(i))^2 +12*CD0*K)));
    CL(i) = (2*W(i))/(rho*Sref*V_climb(i)^2);
    CD(i) = CD0+K*CL(i)^2;
    D(i) = ((rho*V_climb(i)^2)/2)*Sref*CD(i);
    
    h(i) = h(i-1)+del_h; %[ft] Climb segment height
    del_he(i) = (h(i)+((V_climb(i)^2)/(2*g)))-(h(i-1)+((V_climb(i-1)^2)/(2*g))); 
    
    Wf_Wi(i) = exp(-(C*del_he(i))/(V(i)*(1-D(i)/(2*T0))));
    W(i) = prod(Wf_Wi(:))*W(1); %[lb] Current weight
    
    Ps(i) = (V_climb(i)*(2*T0-D(i)))/W(i);
    x_climb(i) = del_he(i)/Ps(i); %[ft] Ground distance covered during climb segment
end
W3 = W(n+1); %[lb] Weight at end of climb

%% Cruise
n = 20; %[integer] Number of cruise segments
W(1) = W3; %Weight at start of cruise
for i=1:n
    CL(i) = (2*W(i))/(rho*Sref*V_cruise^2);
    L_D(i) = CL(i)/(CD0 + K*CL(i)^2);
    W(i+1) = W(i)*exp(-(R*C)/(V*L_D(i)));
end



%Analytical result for cruise
%W_end = ((rho_cruise*Sref*V_cruise^2)/2)*sqrt(CD0/K)*tan(atan(sqrt(K/CD0)*((2*W_start)/(rho_cruise*Sref*V_cruise^2)))-((C*R)/V)*sqrt(CD0*K));


