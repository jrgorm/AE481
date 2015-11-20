%%T_W Calc

function [thrustParameters] = T_W_Calc(parameters,dragPolar)

% Input: Drag polar -- CD0, K, CL_max
%        Parameters -- S_FL, K_s, G, M
%        S_ref      -- S_ref
%        MTOW       -- MTOW

%% Define Wingloading
thrustParameters.W_S = parameters.W0/parameters.Sref;

%% %Load Parameters

%%% Climb
% Climb Gradients
G_1 = parameters.G_1;
G_2 = parameters.G_2;
G_3 = parameters.G_3;

K_climb = parameters.K_climb;
K_cruise = parameters.K_cruise;

Neng = parameters.Neng;

q_cruise = parameters.qCruise;

CD0_climb_1 = dragPolar.CD__climb_1;
CD0_climb_2 = dragPolar.CD0_climb_2;
CD0_climb_3 = dragPolar.CD0_climb_3;   

CD0_cruise = dragPolar.CD0_cruise;

CL_landing = dragPolar.CL_landing;

rho_EWR = parameters.rho_EWR;
rho_SIN = parameters.rho_SIN;

S_EWR = parameters.S_EWR;
S_SIN = parameters.S_SIN;


%% Contraints
thrustParameters.T_W_climb_minimum_1 = Neng*(G_1+2*sqrt(CD0_climb_1*K_climb));
thrustParameters.T_W_climb_minimum_2 = Neng*(G_2+2*sqrt(CD0_climb_2*K_climb))-0.005;
thrustParameters.T_W_climb_minimum_3 = Neng*(G_3+2*sqrt(CD0_climb_3*K_cruise));


thrustParameters.T_W_cruise = q_cruise.*CD0_cruise./thrustParameters.W_S + ...
                thrustParameters.W_S.*(1./q_cruise.*K_cruise);

%%% Takeoff

% We need to check this since were told it is wrong. We have a code
% "TO_length_est.m" that might do this better

BFL = S_EWR; %Balanced field length (BFL) (ft)
               
TOP = BFL/37.5; %Take-off parameter (TOP) 

thrustParameters.T_W_takeoff = W_S/((rho_EWR/rho_SIN)* dragPolar.CLmax_climb*TOP);

%%% Land

% We need to check this since were told it is wrong. We have a code
% "Landing_Distance.m" that might do this better
% It looks like we dont even need this though, so long as our W_S is less
% than W_S_land

S_a = 1000; 
S_land = S_SIN;

thrustParameters.W_S_land = (rho_SIN/rho_SIN)*CL_landing/80*(S_land-S_a)/1.67; 

%%% Ceiling

G = 0.001; % safty factor specified in slides

thrustParameters.T_W_ceiling = G + 2 * sqrt(CD0_cruise * K_cruise);

%%% Manuever

%Maneuver speed
v_maneuver = mCruise*aCruise;

%Dynamic Pressure
q_maneuver = .5*parameters.rho_cruise*v_maneuver^2;

nz = 2.5;

thrustParameters.T_W_maneuver = q_maneuver.*CD0_cruise./thrustParameters.W_S + nz^2 .* (W_S./q_maneuver).* K_cruise;

%% Solve Contraints for bounding conditions, then find minimum T_W there
thrustParameters.T_W_design = max([thrustParameters.T_W_climb_minimum_1,thrustParameters.T_W_climb_minimum_2, ...
                    thrustParameters.T_W_climb_minimum_3,thrustParameters.T_W_takeoff]);

%% Solve T0 from T_W

thrustParameters.T0 = thrustParameters.T_W_design * W0;

%% Pass T0 back to Empty Weight Calculation for iteration

end
