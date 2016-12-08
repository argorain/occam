function [squares] = model_eval_sq(params,model,in_data,out_data)
    out_model = model(params,in_data);
    n = prod(size(out_model));
    N = 2*n;

    sq = sqrt(sum(sum((out_model-out_data).^2))/N);

    squares = sq;
end