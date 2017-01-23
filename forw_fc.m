function y = forw_fc(x, w, b)
    y = sum(sum(w.*x)) + b;
end