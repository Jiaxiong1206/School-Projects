function [root,computeTime,iter] = newtonRaphson(f, df, x0, tol, maxIter)
    % f: Function handle for the equation
    % df: Function handle for the derivative of f
    % x0: Initial guess
    % tol: Tolerance for convergence
    % maxIter: Maximum number of iterations
    
    % Perform the Newton-Raphson iterations
    tic;
    iter = 0;
   
    while abs(f(x0)) > tol && iter < maxIter
        x1 = x0 - f(x0) / df(x0);
        x0 = x1;
        iter = iter + 1;
    end
    computeTime=toc;
    
    % Check if convergence was achieved
    if iter == maxIter
        error('Maximum number of iterations reached without convergence.');
    else
        root = x1;
    end
end