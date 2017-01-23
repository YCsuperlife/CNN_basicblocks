x = [ 1 2 4 5 2 4 1 6 2 4 0 1 3 6 0 1]';
y = forw_softmax(x);
dzdy = [1 7 0 6 4 9 8 7 9 6 9 7 3 6 1 8]';
dzdx = back_softmax(x,y,dzdy);


%check dzdx values (deriv of loss with respect to x input values)
fprintf('Numerical gradient check for dzdx: \n')
eps = 1.0e-6;
xderiv = zeros(size(x));
y = forw_softmax(x);
for i=1:size(x,1)
    for j=1:size(x,2)
        newx = x;
        newx(i,j) = newx(i,j)+eps;
        yprime = forw_softmax(newx);
        deriv = (yprime-y)/eps;
        %compute dz/dx_ij value using multivariate chain rule        
        xderiv(i,j) = dot(deriv(:),dzdy(:));
    end
end
numdzdx = xderiv;
[numdzdx dzdx]