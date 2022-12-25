function [val, grad] = LBetaWithGrad(z, mu, beta, A, B)
	n = length(z)/2;
	x = z(1:n);
    y = z(n+1:end);
	val = LBeta(z, mu, beta, A, B);

    C1 = 2 * beta * (x'*x - 1) + 2 * mu(1);
    C2 = 2 * beta * (y'*y - 1) + 2 * mu(2);
    C3 = x' * y + mu(3);

    grad = [A*x + C1*x; B*y + C2*y] + C3*z;
end