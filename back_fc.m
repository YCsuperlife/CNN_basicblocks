function [dzdx, dzdw, dzdb] = back_fc(x, w, b, y, dzdy)
    dzdx = dzdy*w;
    dzdw = dzdy*x;
    dzdb = dzdy;
end