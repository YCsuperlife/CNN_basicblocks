x = [ 1 2 4 5 8 6; 2 4 1 6 0 1; 2 4 0 1 3 -1; 3 5 1 2 4 -2];
y	= forw_meanpool(x);
dzdy = [1 2 1; 3 1 1];
dzdx = back_meanpool(x, y, dzdy);

%check dzdx values (deriv of loss with respect to x input values)
fprintf('Numerical gradient check for dzdx: \n')
eps = 1.0e-6;
xderiv = zeros(size(x));
y = forw_meanpool(x);
for i=1:size(x,1)
    for j=1:size(x,2)
        newx = x;
        newx(i,j) = newx(i,j)+eps;
        yprime = forw_meanpool(newx);
        deriv = (yprime-y)/eps;
        %compute dz/dx_ij value using multivariate chain rule        
        xderiv(i,j) = dot(deriv(:),dzdy(:));
    end
end
numdzdx = xderiv;
numdzdx
dzdx
