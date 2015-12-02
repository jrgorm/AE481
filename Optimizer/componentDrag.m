%% parameters
r_fus = 9.5; %%% ft
h_fus = 144; %%% ft
l_f = 233.14; %%% Fuselage length (w/ nosecone and tailcone) [ft]

S_ref = 888888888888888; % GIVE ME THE NUMBER
SfuseCabin = 2*pi*r_fus*h_fus; %ft^2 Calc using surface area of tube
SfuseCockpit = 1322; %%% ft^2 (wetted)
SfuseTail = 2488; %%% ft^2 (wetted)
SwetWing = 888888888888; % GIVE ME THE NUMBER
SwetHt = 888888888888; % GIVE ME THE NUMBER
SwetVt = 888888888888; % GIVE ME THE NUMBER
SfuseTotal = SfuseCabin + SfuseCockpit + SfuseTail;
%Interference Factor
Q_fuse = 1; %%% Interference Factor for fuselage%% Fuselage
Q_wing = 1.3; %Interference Factor for wing
Q_tail = 1.05; %Interference Factor for tail

M_cruise = 0.83;
u_cruise = 969.16; %%% ft/s
cl_cruise = 8888888888; %%% NEED THE RIGHT NUMBER

tailcone_upsweep = 8.1; % tail cone average upsweep angle
area_lgTotal = 103.01; % landing gear total frontal area

%Trim Drag variables
x_w = 88888888888; % WRONG, moment arm btwn wing AC and CG
x = 888888888888; %WRONG, moment arm btwn the 2 ACs
cl_wing = 88888888888; % WRONG, wing CL
cm = 88888888888; % WRONG, pitching moment of wing (no tail, wing AC to CG)
S_ht = 8888888888; % WRONG, htail area
v_ht = 888888888888; % GIVE ME THE NUMBER (htail volume coefficient)

%%% flap parameters
del_f_to = 10; % Take off flap setting
del_f_land = 35; % Landing flap setting
sf = 888888888888; % WRONG, CHANGE (area of flapped portion, see slide page 24)
cf_c = 88888888888; % WRONG, CHANGE LATER

%%% FUDGE FACTORS (wing)
mac_wing = 888888888888888888888888; %%% WRONG, REPLACE WITH RIGHT ONE
t_c_wing = 999999999999999999999999; %%% WRONG, REPLACE WITH RIGHT ONE (max thickness)
t_c_wing_avg = 888888888888888; %%% WRONG, REPLACE WITH RIGHT ONE (average thickness)
x_c_wing = 777777777777777777777777; %%% WRONG, REPLACE WITH RIGHT ONE (chordwise location of max thickness)
sweep_wing = 666666666666666666666666; %%% WRONG, REPLACE WITH RIGHT ONE (sweep angle of max thickness line)

%%% FUDGE FACTORS (htail)
mac_ht = 888888888888888888888888; %%% WRONG, REPLACE WITH RIGHT ONE
t_c_ht = 999999999999999999999999; %%% WRONG, REPLACE WITH RIGHT ONE (max thickness)
x_c_ht = 777777777777777777777777; %%% WRONG, REPLACE WITH RIGHT ONE (chordwise location of max thickness)
sweep_ht = 666666666666666666666666; %%% WRONG, REPLACE WITH RIGHT ONE (sweep angle of max thickness line)

%%% FUDGE FACTORS (vtail)
mac_vt = 888888888888888888888888; %%% WRONG, REPLACE WITH RIGHT ONE
t_c_vt = 999999999999999999999999; %%% WRONG, REPLACE WITH RIGHT ONE (max thickness)
x_c_vt = 777777777777777777777777; %%% WRONG, REPLACE WITH RIGHT ONE (chordwise location of max thickness)
sweep_vt = 666666666666666666666666; %%% WRONG, REPLACE WITH RIGHT ONE (sweep angle of max thickness line)

mu_cruise = 3.75e-7; %%% lbf-s/ft^2
rho_cruise = 0.000736627; %%% Air density @ 35,000 ft [slugs/ft^3]

%% fuselage (friction drag)
Re_fuse_cruise = rho_cruise*l_f*u_cruise/mu_cruise;

Cf_fuse_Lam_Cruise = 1.328/sqrt(Re_fuse_cruise);
Cf_fuse_Turb_Cruise = 0.455/(log10(Re_fuse_cruise))^2.58/(1+0.144*M_cruise^2)^0.65;

%%% Weighted Cf_fuse based on Table 12.4 - Civil Jet research goal(passive) 
Cf_fuse = 0.25*Cf_fuse_Lam_Cruise + 0.75*Cf_fuse_Turb_Cruise;

%%% Form factor for fuselage
f = l_f/(2*r_fus);
FF_fuse = 1 + 60/f^3 + f/400;

CD0_fuse = Cf_fuse*FF_fuse*Q_fuse*SfuseTotal/S_ref;
%% wing (friction drag)
Re_wing_cruise = rho_cruise*mac_wing*u_cruise/mu_cruise;
Cf_wing_Lam_Cruise = 1.328/sqrt(Re_wing_cruise);
Cf_wing_Turb_Cruise = 0.455/(log10(Re_wing_cruise))^2.58/(1+0.144*M_cruise^2)^0.65;

%%% Weighted Cf_wing based on Table 12.4 - Civil Jet research goal (passive)
Cf_wing = 0.5*Cf_wing_Lam_Cruise + 0.5*Cf_wing_Turb_Cruise;

%%% Form factor for wing
FF_wing = (1 + 0.6/x_c_wing * t_c_wing + 100*t_c_wing^4)*(1.34 * M_cruise^0.18 * cosd(sweep_wing)^0.28);

CD0_wing = Cf_wing*FF_wing*Q_wing*SwetWing/S_ref;
%% Htail (friction drag)
Re_ht_cruise = rho_cruise*mac_ht*u_cruise/mu_cruise;
Cf_ht_Lam = 1.328/sqrt(Re_ht_cruise);
Cf_ht_Turb = 0.455/(log10(Re_ht_cruise))^2.58/(1+0.144*M_cruise^2)^0.65;

%%% Weighted Cf_wing based on Table 12.4 - Civil Jet research goal (w/ active suction)
Cf_ht = 0.8*Cf_ht_Lam + 0.2*Cf_ht_Turb;

%%% Form factor for wing
FF_ht = (1 + 0.6/x_c_ht * t_c_ht + 100*t_c_ht^4)*(1.34 * M_cruise^0.18 * cosd(sweep_ht)^0.28);

CD0_ht = Cf_ht*FF_ht*Q_tail*SwetHt/S_ref;
%% Vtail (friction drag)
Re_vt_cruise = rho_cruise*mac_vt*u_cruise/mu_cruise;
Cf_vt_Lam = 1.328/sqrt(Re_vt_cruise);
Cf_vt_Turb = 0.455/(log10(Re_vt_cruise))^2.58/(1+0.144*M_cruise^2)^0.65;

%%% Weighted Cf_wing based on Table 12.4 - Civil Jet research goal (w/ active suction)
Cf_vt = 0.8*Cf_vt_Lam + 0.2*Cf_vt_Turb;

%%% Form factor for wing
FF_vt = (1 + 0.6/x_c_vt * t_c_vt + 100*t_c_vt^4)*(1.34 * M_cruise^0.18 * cosd(sweep_vt)^0.28);

CD0_vt = Cf_vt*FF_vt*Q_tail*SwetVt/S_ref;
%% "Missing" Form Drag
%fuselage
D_q_fuse = 3.83*(degtorad(tailcone_upsweep))^2.5*pi*r_fus^2;
% landing gear
D_q_lg = 0.16*area_lgTotal;
CD_mis = (D_q_fuse+D_q_lg)/S_ref;

% LP drag (assume as 2% parasite drag)
CD0 = (CD0_fuse + CD0_wing + CD0_ht + CD0_vt + CD_mis)/(1-0.02);
%% Flap Drag
del_CD_to = 0.9*cf_c^1.38*sf/S_ref*(sind(del_f_to))^2;
del_CD_land = 0.9*cf_c^1.38*sf/S_ref*(sind(del_f_land))^2;

%% Trim Drag
% Tail lift coefficient
cl_tail = (cl_wing*x_w/(x-x_w)+cm*mac_wing/(x-x_w))*S_ref/S_ht;

%% Wave Drag
M_dd = 0.95/cosd(sweep_wing)-t_c_wing_avg/(cosd(sweep_wing)^2)-cl_cruise/10/(cosd(sweep_wing)^3);
M_crit = M_dd - (0.1/80)^(1/3);
Cd_wave = 20*(M_cruise-M_crit)^4;
