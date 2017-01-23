function dzdx = back_maxpool(x, y, dzdy)
% input	x	is	an	2mx2n	matrix	
% input	y	is	an	mxn	matrix	(output	from	forward	pass)	
% input	dzdy	is	an	mxn	matrix	of	dz/dyij	values	
% output	dzdx	is	an	2mx2n	matrix	of	dz/dxij	values  
%     x = [ 1 2 4 5 8 6; 2 4 1 6 0 1; 2 4 0 1 3 -1; 3 5 1 2 4 -2];
%     dzdy = [1 2 1; 3 1 1];
%     y = forw_maxpool(x);
    m = size(x,1)./2;
    n = size(x, 2)./2;
    dzdx = zeros(2*m, 2*n);
    counti = 1;
    for i = 1:2:2*m
        countj = 1;
        for j = 1:2:2*n
            sub = x(i:i+1, j:j+1);
            [row, col] = find(sub == y(counti, countj));
            row = row + i - 1;
            col = col + j - 1;
            dzdx(row, col) = dzdy(counti, countj);
            countj = countj + 1;
        end
        counti = counti + 1;
    end
    
end