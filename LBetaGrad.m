function grad = LBetaGrad(z, mu, beta, A, B)
    n = length(z)/2;
    x = z(1:n);
    y = z(n+1:end);

    C1 = 2 * (beta * (x'*x - 1) - mu(1));
    C2 = 2 * (beta * (y'*y - 1) - mu(2));
    C3 = beta * x' * y + mu(3);
    
    grad = [A*x + C1*x + C3*y; C3*x + B*y + C2*y];
end