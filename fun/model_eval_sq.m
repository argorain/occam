function [squares] = model_eval_sq(params,model,in_data,out_data)
    out = model(params,in_data);
    n = prod(size(out));
    sq = ((out-out_data).^2)/n;
    for it = 1:numel(size(out))
        sq = sum(sq);
    end
    squares = sq;
end