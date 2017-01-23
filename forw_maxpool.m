function y	= forw_maxpool(x)	
    % input x is an	2mx2n matrix (that is, you may assume	
    % it has an	even number	of rows and cols)	
    % output y is an mxn matrix filter of size 2x2 and stride size = 2
%     clear;
    filtersize = [2 2];
    stridesize = 2;
%     x = [ 1 2 4 5 8 6; 2 4 1 6 0 1; 2 4 0 1 3 -1; 3 5 1 2 4 -2];
    m = size(x, 1)./filtersize(1);
    n = size(x, 2)./filtersize(2);
    counti = 1;
    y = zeros(m, n);
    for i = 1:stridesize:2*m
        countj = 1;
        for j = 1:stridesize:2*n
            sub = x(i:i+filtersize(1)-1, j:j+filtersize(2)-1);
            y(counti, countj) = max(max(sub));
            countj = countj + 1;
        end
        counti = counti + 1;
    end
    clear sub;
    clear i;
    clear j;
    clear counti;
    clear countj;

end
