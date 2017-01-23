function y = forw_relu(x)	
%input	x	is	an	mxn	matrix	
%output	y	is	an	mxn	matrix	
    m = size(x, 1);
    n = size(x, 2);
    y = zeros(m, n);
    for i = 1:m
        for j = 1:n
            y(i,j) = max(0, x(i, j));
        end
    end

end