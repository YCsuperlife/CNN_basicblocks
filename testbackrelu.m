x = [6 5 -2; -3 4 7; 3 3 -1];
y = forw_relu(x);
dzdy = [1 7 0 ; 4 9 8 ; 9 6 9 ];

dzdx = back_relu(x, y, dzdy);

%check dzdx values (deriv of loss with respect to x input values)
fprintf('Numerical gradient check for dzdx: \n')
eps = 1.0e-6;
xderiv = zeros(size(x));
y = forw_relu(x);
for i=1:size(x,1)
    for j=1:size(x,2)
        newx = x;
        newx(i,j) = newx(i,j)+eps;
        yprime = forw_relu(newx);
        deriv = (yprime-y)/eps;
        %compute dz/dx_ij value using multivariate chain rule        
        xderiv(i,j) = dot(deriv(:),dzdy(:));
    end
end
numdzdx = xderiv;
numdzdx
dzdx