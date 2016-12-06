function [ params ] = solve_3d_lsq(model, params0, in_data, z_data)
    options = optimset('MaxIter',300000,'MaxFunEvals',300000);
    params = fminsearch(@(pars) model_eval_sq(pars,model,in_data,z_data),params0,options);
end