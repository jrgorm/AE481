%%% TW Constraint
% Updated 11/9/2015 Author: ---
clear all;
close all;

parameters;
dragpolarPDR;
climb;
landing;

S0 = 5973.97028; %ft^2 wing reference area
T_guess = 211002.4868; %lbf max thrust
AR = 9;

S_sweep = [0.5*S0:100:2*S0];

%%% Cruise
for i = 1:length(S_sweep)
    S = S_sweep(i);
    Tcruise(i) = T_guess;
    tol = 0.1;
    conv = 0;
    while conv == 0
        W0 = WeightEst(S,Tcruise(i));
        WS = W0/S;
        T_W_new = q_cruise.*CD0_cruise./WS + WS.*(1./q_cruise./pi./AR./e_cruise);
        T_new = T_W_new*W0;
        if abs(T_new-Tcruise(i)) <= tol
            conv = 1;
        end
        Tcruise(i) = T_new;
    end
end

%%% Climb 1
for i = 1:length(S_sweep)
    S = S_sweep(i);
    Tclimb1(i) = T_guess;
    tol = 0.1;
    conv = 0;
    while conv == 0
        W0 = WeightEst(S,Tclimb1(i));
        WS = W0/S;
        T_W_new = Neng*(G_1+2*sqrt(CD0_climb_1/pi/AR/e_climb));
        T_new = T_W_new*W0;
        if abs(T_new-Tclimb1(i)) <= tol
            conv = 1;
        end
        Tclimb1(i) = T_new;
    end
end

%%% Climb 2
for i = 1:length(S_sweep)
    S = S_sweep(i);
    Tclimb2(i) = T_guess;
    tol = 0.1;
    conv = 0;
    while conv == 0
        W0 = WeightEst(S,Tclimb2(i));
        WS = W0/S;
        T_W_new = Neng*(G_2+2*sqrt(CD0_climb_2/pi/AR/e_climb))-0.005;
        T_new = T_W_new*W0;
        if abs(T_new-Tclimb2(i)) <= tol
            conv = 1;
        end
        Tclimb2(i) = T_new;
    end
end

%%% Climb 3
for i = 1:length(S_sweep)
    S = S_sweep(i);
    Tclimb3(i) = T_guess;
    tol = 0.1;
    conv = 0;
    while conv == 0
        W0 = WeightEst(S,Tclimb3(i));
        WS = W0/S;
        T_W_new = Neng*(G_3+2*sqrt(CD0_climb_3/pi/AR/e_cruise));
        T_new = T_W_new*W0;
        if abs(T_new-Tclimb3(i)) <= tol
            conv = 1;
        end
        Tclimb3(i) = T_new;
    end
end

%%% Ceiling
G = 0.001; 
for i = 1:length(S_sweep)
    S = S_sweep(i);
    Tceiling(i) = T_guess;
    tol = 0.1;
    conv = 0;
    while conv == 0
        W0 = WeightEst(S,Tceiling(i));
        WS = W0/S;
        T_W_new = G + 2 * sqrt(CD0_cruise * K_cruise);
        T_new = T_W_new*W0;
        if abs(T_new-Tceiling(i)) <= tol
            conv = 1;
        end
        Tceiling(i) = T_new;
    end
end

%%% Takeoff
BFL = S_EWR; %Balanced field length (BFL) [ft] 
TOP = BFL/37.5; %Take-off parameter (TOP) 
for i = 1:length(S_sweep)
    S = S_sweep(i);
    Ttakeoff(i) = T_guess;
    tol = 0.1;
    conv = 0;
    while conv == 0
        W0 = WeightEst(S,Ttakeoff(i));
        WS = W0/S;
        T_W_new = WS/((rho_EWR/rho_SL)*CLmax_climb*TOP);
        T_new = T_W_new*W0;
        if abs(T_new-Ttakeoff(i)) <= tol
            conv = 1;
        end
        Ttakeoff(i) = T_new;
    end
end

%%% Landing
W0 = 7.2972e+05;
S_landing = (1/W_S_land)*W0;

%%% Maneuver
%Maneuver speed
v_maneuver = mCruise*aCruise;

%Dynamic Pressure
q_maneuver = .5*rho_cruise*v_maneuver^2;

nz = 2.5;
for i = 1:length(S_sweep)
    S = S_sweep(i);
    Tmaneuver(i) = T_guess;
    tol = 0.1;
    conv = 0;
    while conv == 0
        W0 = WeightEst(S,Tmaneuver(i));
        WS = W0/S;
        T_W_new = q_maneuver.*CD0_cruise./WS + nz^2 .* (WS./q_maneuver).* K_cruise;
        T_new = T_W_new*W0;
        if abs(T_new-Tmaneuver(i)) <= tol
            conv = 1;
        end
        Tmaneuver(i) = T_new;
    end
end

