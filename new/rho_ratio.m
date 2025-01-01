function [rho_ratio]= rho_ratio(gamma,M1)
rho_ratio = ((gamma+1).*M1.*M1)./(2+(gamma-1).*M1.*M1)
end