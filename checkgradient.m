function checkgradient(fVal, fGrad, theta, v)
% Numerically check if the gradient is correct.
% fVal, fGrad: Function handles returning the function value and the gradient at
% a given point.
% theta: Point where to perform the Taylor expansion as (n,1).
% v: Direction in which to perform the Taylor expansion as (n,1).

    s = 101;
    ts = logspace(-10, 0, s); % as (1, s)
    
    f = fVal(theta); % f as (1, 1)
    grad_f = fGrad(theta); % grad_f as (n, 1)
    f_chngd = linspace(0, 0, s);
    
    
    for k = 1:s
        f_chngd(k) = fVal((v * ts(k)) + theta);
    end


	error = abs( f_chngd - f - (ts * (sum(v(:).* grad_f(:)))));
	
    errorMID = error(s); tMID = ts(s); % Scaling constants
    C = errorMID/(tMID^2); % Constant by which the error is bigger than ts^2

	loglog(ts, ts.^2 * 1, 'k:'); % unscaled goal
	hold on
	loglog(ts, ts.^2 * C, 'k--'); % scaled goal
	loglog(ts, error, 'r'); % our error
    title('Test of the gradient', 'using taylor expension')
    xlabel('value of t') 
    ylabel('error of the approximation')
	legend show
	legend('slope = 2', 'slope = 2, scaled',  'error')
    legend('Location','southeast')
	hold off

end