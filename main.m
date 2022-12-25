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

f = @(z) f(z, A, B);
%LBeta = @(z, mu, beta) LBeta(z, mu, beta, A, B);
LBetaWithGrad = @(z, mu, beta) LBetaWithGrad(z, mu, beta, A, B)


%% CheckGradient, only for DEBUG
%   %{
[~, LGrad] = @(z, mu, beta) LBetaWithGrad(z, mu, beta);
z = randn(2*n, 1); z = z/norm(z);
v = randn(2*n, 1); v = v/norm(v);
[val, grad] = LBetaWithGrad(z, [0.1; 0.2; 0.3], 0.4)
figure(2147483646); set(gcf, 'units', 'characters', 'position', [60 10 90 25]);
%checkgradient(LBeta, LGrad, z, v);
    %}

