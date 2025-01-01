function [Ms,Vs,P2,T2,M2,V2,iter,computeTime]=first_case(v1,T1,M2,P1,gamma,R)
%%moving normal shock wave sample question 2 
%%only applicable when M2 is not zero;
a1=sqrt(gamma.*R.*T1);
M1=v1./(a1);
f=@(x) (-(gamma-1).*x^2+(gamma+1).*x.*(x-M1)-2)./sqrt(((gamma-1).*x.^2+2).*(2.*gamma.*x.^2-gamma+1))-M2;
df= @(x) (2.*(gamma+1).*((M1.*gamma.^2-M1.*gamma).*x.^4+(3.*gamma-1).*x.^3+(3-gamma).*x+M1.*gamma-M1))./(((gamma-1).*x.^2+2).*(2.*gamma.*x.^2-gamma+1)).^(3/2);
%initial guess 
M1_p=2;
tolerance=1e-6;
maxIter=1000;

[Ms,computeTime,iter] = newtonRaphson(f, df, M1_p, tolerance, maxIter);
Vs=Ms.*(sqrt(gamma.*R.*T1));
disp(['The root is approximately Ms = ', num2str(Ms)]);
P_ratio= pressure_ratio(gamma,M1_p);
P2=P_ratio*P1;
T_ratio= temperature_ratio(gamma,M1_p);
T2= T_ratio*T1;
V2=M2*sqrt(gamma*R*T2);
disp(['Number of iterations: ', num2str(iter)]);
disp(['Computation time: ', num2str(computeTime), ' seconds']);


end
