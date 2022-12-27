function [z, zval] = minXY(mu, beta, A, B, z0, verbose)
% Our function that runs fminunc with desired parameters,
    % to minimize LBeta with fixed mu and beta.
% Input:
    % mu            : Fixed vector of size (3, 1)
    % beta          : Fixed cost factor.
    % A and B       : The defined matrices, size (n, n)
	% z0			: Initial point.
	% verbose		: Boolean indicating what the algorithm should print.
% Output:
    %   z           : The final z found with the given algorithm.
    %   zval        : It's value.
    options = optimoptions('fminunc');
    options.SpecifyObjectiveGradient = true;  % indicate gradient is provided
    %options.Algorithm = 'trust-region'; %TODO, think about that
    if verbose % add display
        options.Display = 'iter-detailed';
    else
        options.Display = 'none';
    end
    [z, zval] = fminunc(@(z) LBetaValAndGrad(z, mu, beta, A, B), z0, options);
end