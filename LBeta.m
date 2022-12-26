function val = LBeta(z, mu, beta, A, B)
    hz = h(z);
    val = f(z, A, B) + mu' * hz;
    if beta ~= 0
        val = val + beta * sum(hz .* hz)/2;
        % = val + beta * vecnorm(hz)^2 /2;
    end
end