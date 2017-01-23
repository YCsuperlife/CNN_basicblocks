function dzdx = back_relu(x, y, dzdy)
    %dzdx = dzdy * dydx
%     clear;
%     dzdy = [1 1 1; 1 1 1; 1 1 1];
%     x = [0 5 -2; -3 4 7; 3 3 -1];
%     y = forw_relu(x);
    dydx = double(y > 0);
    dzdx = dzdy.*dydx;
end