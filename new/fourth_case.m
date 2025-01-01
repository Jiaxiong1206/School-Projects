function [P2,T2,P3,T3,Ms,M2,M3_p,M2r,iter,computeTime]= fourth_case(P1,T1,P2P1,gamma,V1,R)
%%sample question 4 (reflected)
P2=P1.*P2P1;
M1_p=sqrt(((P2P1.*(gamma+1))+(gamma-1))./(2.*gamma));
V1_p=M1_p.*(sqrt(gamma.*R.*T1));
Vs=V1_p+V1;
Ms=Vs./(sqrt(gamma.*R.*T1));
T2T1= temperature_ratio(gamma,M1_p);
T2=T2T1.*T1;
M2_p=mach2(gamma,M1_p);
V2_p=M2_p.*(sqrt(gamma.*R.*T2));
V2=Vs-V2_p;
M2=V2./(sqrt(gamma.*R.*T2));
f=@(x) ((gamma-1)*x^2+2)/((gamma+1)*x)-x+M2;
df=@(x) -(2*x^2+2)/((gamma+1)*x^2); 
tol=1e-6;
maxIter=1000;
M2r_guess=2;
[M2r,computeTime,iter] = newtonRaphson(f, df, M2r_guess, tol, maxIter);
M3_p=mach2(gamma,M2r);
P_ratio= pressure_ratio(gamma,M2r);
P3=P_ratio.*P2;
T_ratio= temperature_ratio(gamma,M2r);
T3=T_ratio.*T2;
disp(['Number of iterations: ', num2str(iter)]);
disp(['Computation time: ', num2str(computeTime), ' seconds']);
end
