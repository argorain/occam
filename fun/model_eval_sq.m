function [squares] = model_eval_sq(params,model,in_data,out_data)
    out_model = model(params,in_data);
    n = prod(size(out_model));
    N = 2*n;
    %sq = 1/n * sum(sum(sqrt(((out-out_data).^2)/N)));
    sq = sqrt(sum(sum((out_model-out_data).^2))/N);
    %P(i) = sqrt(sum((fn(ls{i},in_data)-noise).^2)/n);
    
    %for it = 1:numel(size(out))
    %    sq = sum(sq);
    %end
    squares = sq;
    
    % sqrt(1/n * sum(((fn(ls{i},in_data) - noise).^2)/N));
end