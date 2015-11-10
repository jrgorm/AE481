%%% Initial Weight Estimation (old iteration)
% Updated 11/9/2015 Author: ---

wCrew = 14*(180+30); % lbs
wPayload = 125*(180+100+20); % lbs
%
ff1=0.990; % start and warmup (Roskam)
ff2=0.990; % taxi (Roskam)
ff3=0.995; % takeoff (Roskam)
ff4=0.980; % climb (Roskam)
%
rangeCruise=8285; % nmi
mCruise=0.83; %S Specified
lOverDCruise=16; % Typical value for Commercial Jets (Roskam)
cjCruise=0.45; % 1/hr (Roskam)
aCruise=973.1; % ft/s at 35000 ft (std atm table)
ftPerNm=6076.1; % conversion factor
secsPerHr=3600; % conversion factor
vCruise=mCruise*aCruise/ftPerNm*secsPerHr; % knots
ff5=1/exp((rangeCruise/(vCruise/cjCruise))/lOverDCruise); % cruise fuel fraction
%
% enduranceLoiter=0.5; % Hours
% cjLoiter=0.4; % 1/hr (Roskam)
% lOverDLoiter=18; % Optimistic value for Commercial Jets (Roskam)
% ff6=1/exp((enduranceLoiter*cjLoiter)/lOverDLoiter); % loiter fuel fraction
% ff7=0.990; % Descent
% %
% rangeAlt=200; % Alternate Range
% AltV=250; % Alternate Cruise Speed
% cjAlt=0.9; % Alternate cj
% lOverDAlt=10; % L/D Alternate
% ff8=exp(-rangeAlt/AltV*cjAlt/lOverDAlt); % Alternate fuel fraction
% ff9=0.992; % landing, taxi,shutdown
% %
% mFF=ff1*ff2*ff3*ff4*ff5*ff6*ff7*ff8*ff9;
% wFBurnedOverWTO=1-mFF;
% wFOverWTO=1.005*1.06*wFBurnedOverWTO; % 25% reserve plus 0.5% tfo/reserve
% %
% A=0.0833; % (Roskam)
% B=1.0383; % (Roskam)
% wTO=1000000; % lbs, initial guess for gross takeoff weight
% error=wTO;
% 
% a=1.02; % (Raymer)
% c=-0.06; % (Raymer)
% A = 0.0827;
% B = 1.0446;
% 
% 
% while(error>1)
%     %The two equations represent two methods of solving this problem. 
%     %We believe that the weight will be in between the values obtained 
%     %using equation 1 and equation 2
%     %wE=10.^((log10(wTO)-A)/B); % Equation 1
%     wE = wTO*a*(wTO^c);          % Equation 2
%     wTONew=(wPayload+wCrew)/(1-wFOverWTO-wE/wTO);
%     error=100*((abs(wTONew-wTO))/wTO);
%     wTO=wTONew;
%     pause(1)
% end
% 
% fprintf('Gross takeoff weight is %8.0f\n',wTO);
% fprintf('Empty weight is %8.0f\n',wE);
% fprintf('Fuel weight is %8.0f\n',wFOverWTO*wTO);