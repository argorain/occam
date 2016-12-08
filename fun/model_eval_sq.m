function [squares] = model_eval_sq(params,model,in_data,out_data)
    out_model = model(params,in_data);
    n = prod(size(out_model));
    N = 2*n;
    out_model_R = reshape(out_model, 1, n);
    out_data_R = reshape(out_data, 1, n);
    
    %sq = sqrt(sum(sum((out_model-out_data).^2))/N);
    sq = (out_model_R-out_data_R).^2;
    sq = sum(sq);
    sq = sq/N;
    sq = (sq)^(1/2); %<<< FIXME: If I keep there 1/2 as Hans-Z, eq 5.3, it works well for 2D.
    %sq = (sq)^(1/3); %<<< FIXME: But if I put there 1/3 for 3D, it works
    %pretty good. How about putting there dimension?
    
    squares = sq;
end