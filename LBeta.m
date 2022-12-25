function val = LBeta(z, mu, beta, A, B)
    val = f(z, A, B) + mu' * h(z);
    if beta ~= 0
        hz = h(z);
        val = val + beta * sum(hz .* hz)/2;
        % = val + beta * vecnorm(hz)^2 /2;
    end
end