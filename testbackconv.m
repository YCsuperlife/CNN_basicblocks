x = [ 1 2 4 5 8; 2 4 1 6 0; 2 4 0 1 3]
w = [1 3; 2 4]
bias = 3
dzdy = [1 7 0 6 3; 4 9 8 7 6; 9 6 9 7 1]
%dzdy = ones(size(x))

%forward pass
fprintf('Forward pass:\n')
y = forw_conv(x,w,bias)

%backward pass
fprintf('Backward pass:\n')
[dzdx, dzdw, dzdb] = back_conv(x,w,bias,y,dzdy)


%do numerical gradient checks

%check dzdw values (deriv of loss with respect to filter values)
fprintf('Numerical gradient check for dzdw: \n')
eps = 1.0e-6;
filtderiv = zeros(size(w));
y = forw_conv(x,w,bias);
for i=1:size(w,1)
    for j=1:size(w,2)
        filt = w;
        filt(i,j) = filt(i,j)+eps;
        yprime = forw_conv(x,filt,bias);
        deriv = (yprime-y)/eps;
        %compute dz/dw_ij value using multivariate chain rule
        %   deriv contains all dy/dw_ij values and dzdy contains all dz/dy values
        %   so to compute dz/dw_ij we sum up all products (dz/dy_kl)*(dy_kl/dw_ij) 
        filtderiv(i,j) = dot(deriv(:),dzdy(:));
    end
end
numdzdw = filtderiv;
numdzdw
dzdw


%check dzdx values (deriv of loss with respect to x input values)
fprintf('Numerical gradient check for dzdx: \n')
eps = 1.0e-6;
xderiv = zeros(size(x));
y = forw_conv(x,w,bias);
for i=1:size(x,1)
    for j=1:size(x,2)
        newx = x;
        newx(i,j) = newx(i,j)+eps;
        yprime = forw_conv(newx,w,bias);
        deriv = (yprime-y)/eps;
        %compute dz/dx_ij value using multivariate chain rule        
        xderiv(i,j) = dot(deriv(:),dzdy(:));
    end
end
numdzdx = xderiv;
numdzdx
dzdx


%check dzdb value(deriv of loss with respect to bias value)
fprintf('Numerical gradient check for dzdb: \n')
eps = 1.0e-6;
y = forw_conv(x,w,bias);
yprime = forw_conv(x,w,bias+eps);
bderiv = (yprime-y)/eps;
%compute dz/db (scalar) value using multivariate chain rule 
numdzdb = sum(sum(bderiv .* dzdy));
numdzdb
dzdb
