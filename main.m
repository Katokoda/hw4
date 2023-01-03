clear;
close all;
clc;

%% Set up (Defining parameters and functions).
n = 5;
N = 9; %Number of iterions of QPM and ALM
A = [ 2 4 4 5 9
      4 4 8 7 5
      4 8 2 8 5
      5 7 8 6 5
      9 5 5 5 2 ];
B = [ 4 8 3 6 8
      8 4 4 5 2
      3 4 2 8 5
      6 5 8 4 7
      8 2 5 7 8 ];

silentMinXY = @(mu, beta, z0) minXY(mu, beta, A, B, z0, 0);

f = @(z) f(z, A, B);


%% CheckGradient, only for DEBUG
   %{
disp('===========================')
disp('Start of the gradient check')
disp(newline)
mu = randn(3, 1);
beta = randn(1, 1);
z = randn(2*n, 1); z = z/norm(z);
v = randn(2*n, 1); v = v/norm(v);
figure(2147483646); set(gcf, 'units', 'characters', 'position', [60 10 90 25]);
checkgradient(@(z) LBeta(z, mu, beta, A, B), @(z) LBetaGrad(z, mu, beta, A, B), z, v);
    %}


%% fminunc, Question 9
%   %{
disp('===========================================')
disp('Start of one fminunc with fixed mu and beta')
mu = [1; 2; -3];
beta = 1.42;
z0 = [1; 0; -1; 2; 1; 1; 2; 0; 1; 2];

% Calling our function, with details
[z, zval] = minXY(mu, beta, A, B, z0, 1);

% Display
disp('Found x and y are')
disp([z(1:n), z(n+1:end)])
    disp("with value f(x, y) = " + f(z) + "    and LBeta(x, y, mu) = " + LBeta(z, mu, beta, A, B))
disp("and h(x, y), mu:       which have norms " + vecnorm(h(z)) + ", " + vecnorm(mu))
disp([h(z), mu])
    %}


%% Quadratic penalty method, Question 10
%    %{
disp('=====================================')
disp('Start of the Quadratic penalty method')
mu = [0; 0; 0];
z0 = randn(2*n, 1);
z = z0;
beta = 1;
for i = 1:N
    [z, zval] = silentMinXY(mu, beta, z);

    % Display
    disp(newline + "Iteration " + i + " with beta = " + beta + ". We found x and y:")
    disp([z(1:n), z(n+1:end)])
    disp("with value f(x, y) = " + f(z) + "    and LBeta(x, y, mu) = " + LBeta(z, mu, beta, A, B))
    hz = h(z);
    disp("and h(x, y), beta*h(x, y):       which have norms " + vecnorm(hz) + ", " + beta * vecnorm(hz))
    disp([hz, beta * hz])

    beta = 2 * beta; % Updating
end
    %}


%% augmented Lagrangian method, Question 11
%    %{
disp('========================================')
disp('Start of the augmented Lagrangian method')
mu = [0; 0; 0];
% z0 = randn(2*n, 1);   % We start with the same z0 as for QPM.
z = z0;
beta = 1;
for i = 1:N
    [z, zval] = silentMinXY(mu, beta, z);

    hz = h(z);
    mu = mu + beta * hz; % Updating

    % Display
    disp(newline + "Iteration " + i + " with beta = " + beta + ". We found x and y:")
    disp([z(1:n), z(n+1:end)])
    disp("with value f(x, y) = " + f(z) + "    and LBeta(x, y, mu) = " + LBeta(z, mu, beta, A, B))
    disp("and h(x, y), new mu:       which have norms " + vecnorm(hz) + ", " + vecnorm(mu))
    disp([hz, mu])

    beta = 2 * beta; % Updating
end
    %}


disp('========================================')
disp('Final result''s interpretation')

if N > 30
    disp("ALERT: Be careful with big values of N.")
    disp("When Beta is too big the stored value of mu will get turbulent.")
end

disp("Our (hopefully feasible) obtained value for the Dual problem (D) is mu_1 + mu_2 = " + (mu(1) + mu(2)))
lambdaA = min(eig(A));
lambdaB = min(eig(B));
if 2 * mu(1) > lambdaA
    disp("But 2 * mu(1) > lambda_min(A): " + (2 * mu(1)) + " > " + lambdaA)
end
if 2 * mu(2) > lambdaB
    disp("But 2 * mu(2) > lambda_min(B): " + (2 * mu(2)) + " > " + lambdaB)
end
if 2 * mu(1) <= lambdaA ||  2 * mu(2) <= lambdaB
    disp("And mu is valid in the dual.")
end

I = eye(5);
M = [A - 2 * mu(1) * I, mu(3) * I; mu(3) * I, B - 2 * mu(2) * I];
lambdaM = min(eig(M));
disp("hence, lambda_min(M_mu) = " + lambdaM + ".")
if lambdaM < 0
    disp("And therefore, M_mu is not semi-positive definite,")
    disp("and mu is not feasible in (D).")
else
    disp("<=> M_mu is semi-positive definite.")
end

disp(newline + "Note that the theoretical maximal value for (D) is:")
disp("(lambda_min(A) + lambda_min(B))/2 = " + (lambdaA + lambdaB)/2)