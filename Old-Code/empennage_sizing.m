%%% Empennage Sizing
% Updated 11/12/2015 Author: JRG

MainWingSizing; % all in meters!

l_ht = 36.67; % from CAD
l_vt = 35.25; % from CAD
c_vt = 0.06467; %777: 0.06467, 340: 0.0569, 
c_ht = 0.89; %777: 0.891, 340: 0.79
s_vt = c_vt*b_w*WingAreaMeters/l_vt
s_ht = c_ht*8.847*WingAreaMeters/l_ht
AR_vt = 1.6;
AR_ht = 4.5;
lam_vt = 0.3;
lam_ht = 0.3;
sweep_vtqc = 46; % From 777
sweep_vtle = atand(tand(sweep_vtqc)+(1-lam_vt)/AR_vt/(1+lam_vt));
sweep_htqc = 35; %From 777
sweep_htle = atand(tand(sweep_htqc)+(1-lam_ht)/AR_ht/(1+lam_ht));
b_vt = sqrt(AR_vt*s_vt);
b_ht = sqrt(AR_ht*s_ht);
Croot_vt = 2*s_vt/b_vt/(1+lam_vt);
Croot_ht = 2*s_ht/b_ht/(1+lam_ht);
