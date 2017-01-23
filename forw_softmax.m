function y = forw_softmax(x)
%     clear;
    y = exp(x);
    y = y/sum(y);

end