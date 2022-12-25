function vec = h(z)
	n = length(z)/2;
	x = z(1:n);
    y = z(n+1:end);
    vec = [1 - x'*x; 1 - y'*y; x'*y];
end