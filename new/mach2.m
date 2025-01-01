function M2=mach2(gamma,M1)
a = (gamma-1).*M1.*M1+2;
b = 2.*gamma.* M1.* M1-gamma+1;
M2 = sqrt((a./b));
end







