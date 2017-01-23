function dzdx = back_softmax(x,y,dzdy)
    m = size(x,1);
    dydx = zeros(m,m);
    for i= 1:m
        for j = 1:m
            if i ~= j
                numerator = -1*y(j);
            else
                numerator = 1 - y(j);
            end
            dydx(i,j) = y(i)*numerator;
        end    
    end
    dzdx= zeros(m,1);
    for i = 1:m
        dzdx(i) = dot(dzdy(:),dydx(:,i));
    end
end