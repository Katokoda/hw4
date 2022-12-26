function [val, grad] = LBetaBoth(z, mu, beta, A, B)
    val = LBeta(z, mu, beta, A, B);
    grad = LBetaBoth(z, mu, beta, A, B);
end