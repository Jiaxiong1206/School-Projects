function [T2,P2,V2]=third_case(Vs,gamma,V1,P1,T1,R)
%% sample question 3(hydrogen)
V1_p=Vs-V1;
M1_p=V1_p/sqrt(gamma.*R.*T1);
T2T1= temperature_ratio(1.4,M1_p);
P2P1=pressure_ratio(gamma,M1_p);
M2_p=mach2(gamma,M1_p);
T2=T2T1.*T1;
P2=P2P1.*P1;
V2_p=M2_p.*(sqrt(gamma.*R.*T2));
V2= Vs-V2_p;
end