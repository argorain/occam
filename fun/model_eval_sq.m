function [squares] = model_eval_sq(params,model,in_data,out_data)
    out = model(params,in_data);
    n = prod(size(out));
    N = 2*n;
    sq = sqrt(1/n * sum(sum(((out-out_data).^2))/N));
    %for it = 1:numel(size(out))
    %    sq = sum(sq);
    %end
    squares = sq;
    
    % sqrt(1/n * sum(((fn(ls{i},in_data) - noise).^2)/N));
end