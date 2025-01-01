function [P_ratio]= pressure_ratio(gamma,M1)
T_ratio= temperature_ratio(gamma,M1);
rho_r= rho_ratio(gamma,M1);
P_ratio=(rho_r)*(T_ratio);
end