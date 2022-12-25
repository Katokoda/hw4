function val = f(z, A, B)
	n = length(z)/2;
	x = z(1:n);
    y = z(n+1:end);
    val = x' *A* x + y' *B* y;
    val = val/2;
end