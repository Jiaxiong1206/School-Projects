function[T_ratio]= temperature_ratio(gamma,M1) 
b = 2.*gamma.* M1.* M1-gamma+1;
T_ratio = (b.*(2+(gamma-1).*M1.*M1))./((gamma+1).*(gamma+1).*M1.*M1);
end