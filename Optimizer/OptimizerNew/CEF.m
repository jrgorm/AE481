%%% Function for calculating Cost Escalation Factor
% Updated 11/9/2015 Author: ---

function [CEF] = CEF(b_year, t_year)
b_cef = 5.17053 + 0.104981*(b_year-2006);
t_cef = 5.17053 + 0.104981*(t_year-2006);
CEF = t_cef/b_cef;
end
