function dzdx = back_meanpool(x, y, dzdy)
% input	x	is	an	2mx2n	matrix	
% input	y	is	an	mxn	matrix	(output	from	forward	pass)	
% input	dzdy	is	an	mxn	matrix	of	dz/dyij	values	
% output	dzdx	is	an	2mx2n	matrix	of	dz/dxij	values  
%     x = [ 1 2 4 5 8 6; 2 4 1 6 0 1; 2 4 0 1 3 -1; 3 5 1 2 4 -2];
%     dzdy = [1 2 1; 3 1 1];
%     y = forw_maxpool(x);
    m = size(x,1)./2;
    n = size(x, 2)./2;
    counti = 1;
    dzdx = [];
    for i = 1:2:2*m
        countj = 1;
        for j = 1:2:2*n
            dzdx(i:i+1, j:j+1) = ones(2, 2)*dzdy(counti, countj);
            countj = countj + 1;
        end
        counti = counti+1;
    end
    dzdx = 0.25.*dzdx;
end