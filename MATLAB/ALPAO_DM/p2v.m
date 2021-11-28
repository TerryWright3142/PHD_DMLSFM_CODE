function out = p2v( in)
    M = ~isnan(in(:));
    out = max(in(M)) - min(in(M));
end

