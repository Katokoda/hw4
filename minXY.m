function [z, zval] = minXY(mu, beta, A, B, z0, verbose)
    options = optimoptions('fminunc', 'SpecifyObjectiveGradient', true); % indicate gradient is provided
    if verbose % add display
        options.Display = 'iter-detailed';
    else
        options.Display = 'none';
    end
    [z, zval] = fminunc(@(z) LBetaValAndGrad(z, mu, beta, A, B), z0, options);
end