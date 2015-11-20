%%T_W Calc

% Input: Drag polar -- CD0, K, CL_max
%        Parameters -- S_FL, K_s, G, M
%        S_ref      -- S_ref
%        MTOW       -- MTOW

%% Define Wingloading
airplane.W_S = MTOW/Sref;

%% Contraints

%%% Climb
% Climb Gradients
G_1 = .005;
G_2 = .024;
G_3 = .012;

ks_1 = 1.2;
ks_2 = 1.15;
ks_3 = 1.2;

CL_climb_1 = 2.7;
CL_climb_2 = 2.3;
CL_climb_3 = 1.9;

T_W_climb_minimum_1 = Neng*(G_1+2*sqrt(CD0_climb_1/pi/AR/e_climb));
T_W_climb_minimum_2 = Neng*(G_2+2*sqrt(CD0_climb_2/pi/AR/e_climb))-0.005;
T_W_climb_minimum_3 = Neng*(G_3+2*sqrt(CD0_climb_3/pi/AR/e_cruise));

%%% Cruise
%Velocity at cruise
v_cruise = mCruise*aCruise;

%Dynamic Pressure
q_cruise = .5*rho_cruise*v_cruise^2;

T_W_cruise = q_cruise.*CD0_cruise./W_S + W_S.*(1./q_cruise./pi./AR./e_cruise);

%%% Takeoff

% We need to check this since were told it is wrong. We have a code
% "TO_length_est.m" that might do this better

BFL = S_EWR; %Balanced field length (BFL) (ft)
               
TOP = BFL/37.5; %Take-off parameter (TOP) 

T_W_takeoff = W_S/((rho_EWR/rho_SL)*CLmax_climb*TOP);

%%% Land

% We need to check this since were told it is wrong. We have a code
% "Landing_Distance.m" that might do this better
% It looks like we dont even need this though, so long as our W_S is less
% than W_S_land

S_a = 1000; 
S_land = S_SIN;

W_S_land = (rho_SIN/rho_SL)*CLmax_landing/80*(S_land-S_a)/1.67; 

%%% Ceiling

G = 0.001; % safty factor specified in slides

T_W_ceiling = G + 2 * sqrt(CD0_cruise * K_cruise);

%%% Manuever

%Maneuver speed
v_maneuver = mCruise*aCruise;

%Dynamic Pressure
q_maneuver = .5*rho_cruise*v_maneuver^2;

nz = 2.5;

T_W_maneuver = q_maneuver.*CD0_cruise./W_S + nz^2 .* (W_S./q_maneuver).* K_cruise;

%% Solve Contraints for bounding conditions, then find minimum T_W there

%% Solve T0 from T_W

airplane.T0 = T_W * airplane.MTOW;

%% Pass T0 back to Empty Weight Calculation for iteration
