%%%%%%%%% TAIL SIZING FOR OPTIMIZER

%    Function Inputs Length of Fuselage, Diameter of Fuselage, Main wing reference area,
%    main wing mean aerodynamic chord, main wing wingspan

%    Function Outputs reference area of Horz and Vertical Tails

%%%% PROBLEM:::: DON'T KNOW WHY WE NEEDED FUSELAGE DIAMETER AS MENTIONED IN CLASS...

function [Sht, Svt] = TailSizing(Lfus,Dfus,Sref,cw,bw)

Cvt = 0.0577;   %%%% ADJUST THIS IF NEEDED: Vertical Tail Volume Coefficient: BASED ON 777-100X1

Cht = 0.8385; %%%% ADJUST THIS IF NEEDED: Horizontal Tail Volume Coefficient: : BASED ON 777-100X1

Lht = 0.55 * Lfus %%% Class Slides "emmpanage" list tail moment arm to be 50-55% of fuselage length
Lvt = 0.50 * Lfus %%% Class Slides "emmpanage" list tail moment arm to be 50-55% of fuselage length
%%% NOTE: Wanted to shift Vtail forward of Htail, so used 50% and 55% respectively

Sht = Cht *cw * Sref / Lht ; %%%% Calculate Horz Tail Area Based on volume coeff, main wing chord, main wing ref area, and horz tail moment arm
Svt = Cvt *bw * Sref / Lvt ; %%%% Calculate Vert Tail Area Based on volume coeff, main wing wingspan, main wing ref area, and vert tail moment arm

end
