MTOW = 700000; %%% inital MTOW guess
T0 = 200000; %%% intial thrust guess

WfoverMTOW = .6; %%%% fuel weight over MTOW (from john's code) : UPDATE TO ACTUAL VALUE

tolerance = .1; %%%% weight error tolerance

while (MTOW - MTOWnew) > tolerance
    
    
[WeoverMTOW] = EmptyweightIII(T0,5000,2000,1200,MTOW,9,35,.2,.10,6000,1200,2000,800);

Wfuel = WfoverMTOW * MTOW;
Wempty = WeoverMTOW * MTOW;

MTOWnew = Wfuel + Wempty;

MTOW = MTOWnew;

end
