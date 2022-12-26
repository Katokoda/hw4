clear;
close all;
clc;

%% Set up (Defining parameters and functions).
n = 5;
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
%   %{
disp("===========================")
disp("Start of the gradient check")
disp(newline)
mu = [1; 2; -3];
beta = 1.42;

z = randn(2*n, 1); z = z/norm(z);
v = randn(2*n, 1); v = v/norm(v);
figure(2147483646); set(gcf, 'units', 'characters', 'position', [60 10 90 25]);
checkgradient(@(z) LBeta(z, mu, beta, A, B), @(z) LBetaGrad(z, mu, beta, A, B), z, v);
    %}


%% fminunc, Question 9
%   %{
disp("===========================================")
disp("Start of one fminunc with fixed mu and beta")
mu = [1; 2; -3];
beta = 1.42;
z0 = [1; 0; -1; 2; 1; 1; 2; 0; 1; 2];

[z, zval] = minXY(mu, beta, A, B, z0, 1);
disp("Found x and y are")
disp([z(1:n), z(n+1:end)])
disp("with value f(x, y) = " + f(z))
disp("and h(x, y), mu :")
disp([h(z), mu])
    %}

%% Quadratic penalty method, Question 10
%    %{
disp("=====================================")
disp("Start of the Quadratic penalty method")
mu = [0; 0; 0];
z0 = randn(2*n, 1); z0 = z0/norm(z0);
z = z0;
for beta = [1, 2, 4, 8, 16, 32, 64, 128, 256 ]% , 512, 1024, 2048, 4096]
    [z, zval] = silentMinXY(mu, beta, z);
    disp(newline + "Iteration with beta = " + beta + ".")
    disp("We found x and y:")
    disp([z(1:n), z(n+1:end)])
    disp("with value f(x, y) = " + f(z))
    disp("and h(x, y), beta*h(x, y) :")
    hz = h(z);
    disp([hz, beta * hz])
    disp("which have norms")
    disp([vecnorm(hz), beta * vecnorm(hz)])
end
    %}




%% augmented Lagrangian method, Question 11
%    %{
disp("========================================")
disp("Start of the augmented Lagrangian method")
mu = [0; 0; 0];
z0 = randn(2*n, 1); z0 = z0/norm(z0);
z = z0;
for beta = [1, 2, 4, 8, 16, 32, 64, 128, 256 ]% , 512, 1024, 2048, 4096]
    [z, zval] = silentMinXY(mu, beta, z);
    disp(newline + "Iteration with beta = " + beta + ".")
    disp("We found x and y:")
    disp([z(1:n), z(n+1:end)])
    disp("with value f(x, y) = " + f(z))
    disp("and h(x, y), mu :")
    hz = h(z);
    disp([hz, mu])
    disp("which have norms")
    disp([vecnorm(hz), vecnorm(mu)])

    disp("Alerte : Faut-il changer mu?")
end
    %}






disp("Alerte : fminunc with Quasi-Newton or TR?")

disp("Alerte : tous nos vecteurs aléatoires sont unitaires, est-ce logique?")
