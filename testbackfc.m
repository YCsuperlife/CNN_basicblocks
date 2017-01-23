x = [ 1 2 4 5; 2 4 1 6; 2 4 0 1; 3 6 0 1];
w = [1 1 2 1; 4 2 1 2; 1 8 2 3; 3 4 1 6];
bias = 3;
dzdy = 12;

y = forw_fc(x, w, bias);

[dzdx, dzdw, dzdb] = back_fc(x,w,bias,y,dzdy);

%check dzdw values (deriv of loss with respect to filter values)
fprintf('Numerical gradient check for dzdw: \n')
eps = 1.0e-6;
filtderiv = zeros(size(w));
y = forw_fc(x,w,bias);
for i=1:size(w,1)
    for j=1:size(w,2)
        filt = w;
        filt(i,j) = filt(i,j)+eps;
        yprime = forw_fc(x,filt,bias);
        deriv = (yprime-y)/eps;
        %compute dz/dw_ij value using multivariate chain rule
        %   deriv contains all dy/dw_ij values and dzdy contains all dz/dy values
        %   so to compute dz/dw_ij we sum up all products (dz/dy_kl)*(dy_kl/dw_ij) 
        filtderiv(i,j) = dot(deriv,dzdy(:));
    end
end
numdzdw = filtderiv;
int16(numdzdw)
dzdw


%check dzdx values (deriv of loss with respect to x input values)
fprintf('Numerical gradient check for dzdx: \n')
eps = 1.0e-6;
xderiv = zeros(size(x));
y = forw_fc(x,w,bias);
for i=1:size(x,1)
    for j=1:size(x,2)
        newx = x;
        newx(i,j) = newx(i,j)+eps;
        yprime = forw_fc(newx,w,bias);
        deriv = (yprime-y)/eps;
        %compute dz/dx_ij value using multivariate chain rule        
        xderiv(i,j) = dot(deriv(:),dzdy(:));
    end
end
numdzdx = xderiv;
int16(numdzdx)
dzdx


%check dzdb value(deriv of loss with respect to bias value)
fprintf('Numerical gradient check for dzdb: \n')
eps = 1.0e-6;
y = forw_fc(x,w,bias);
yprime = forw_fc(x,w,bias+eps);
bderiv = (yprime-y)/eps;
%compute dz/db (scalar) value using multivariate chain rule 
numdzdb = sum(sum(bderiv .* dzdy));
int16(numdzdb)
dzdb