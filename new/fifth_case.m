function [P2,T2,M2,M1_p,iter,computeTime]=fifth_case(V1,P1,T1,M2,gamma,R)
%%reflected shock sample question 6
%%only applicable when V2=0 and M2=0
M1=V1./(sqrt(gamma.*R.*T1));
f=@(x) -sqrt((gamma-1)*x^2+2)/sqrt(2*gamma*x^2-gamma+1)+((gamma+1)*x*(x+M1))/(sqrt((gamma-1)*x^2+2)*sqrt(2*gamma*x^2-gamma+1))-M2;
df=@(x) -(2*(gamma+1)*((M1*gamma^2-M1*gamma)*x^4+(1-3*gamma)*x^3+(gamma-3)*x+M1*gamma-M1))/(((gamma-1)*x^2+2)^(3/2)*(2*gamma*x^2-gamma+1)^(3/2));
tolerance=1e-6;
maxIter=1000;
M1_Pguess=2.0;
% M1_p = newtonRaphson(f, df,M1_Pguess , tolerance, maxIter);
[M1_p,computeTime,iter] = newtonRaphson(f, df, M1_Pguess, tolerance, maxIter);
% M2_p=mach2(gamma,M1_p);
P_ratio= pressure_ratio(gamma,M1_p);
T_ratio= temperature_ratio(gamma,M1_p);
P2=P1.*P_ratio;
T2=T1*T_ratio;
disp(['Number of iterations: ', num2str(iter)]);
disp(['Computation time: ', num2str(computeTime), ' seconds']);

end