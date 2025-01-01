function [Vs,V2,T2]=second_case(T1,P2P1,V1,gamma,R)
%%normal moving shock wave sample question 1

M1_p=sqrt(((P2P1.*(gamma+1))+(gamma-1))./(2.*gamma));
V1_p=M1_p.*sqrt(T1.*R.*gamma);
Vs=V1_p+V1;
M2_p=mach2(gamma,M1_p);
T_ratio=temperature_ratio(gamma,M1_p);
T2= T_ratio.*T1;
V2_p=M2_p.*sqrt(T2.*R.*gamma);
V2=Vs-V2_p;

end