clear variables
close all
clc

addpath('fun');
addpath('model');
addpath('generator');

req_tests = 10;
fprintf('Generating data..\n');
%% generate 2D data
dim = 2;
model_2D;
models = size(model,1);
mod_n = 1;
for it=1:req_tests
    pars_n = model{mod_n,2};
    pars = randn(1,pars_n)*10;
    generator(model{mod_n,1},pars,dim,100,it);
    mod_n=mod_n+1;
    if mod_n>models
        mod_n=1;
    end
end

%% generate 3D data
dim = 3;
model_3D;
models = size(model,1);
mod_n = 1;
for it=1:req_tests
    pars_n = model{mod_n,2};
    pars = randn(1,pars_n)*10;
    generator(model{mod_n,1},pars,dim,100,it);
    mod_n=mod_n+1;
    if mod_n>models
        mod_n=1;
    end
end

%% Evaluate
fprintf('Evaluating data..\n');
for method = [1,2,3]
    % eval 2D data M1
    dim = 2;
    for it=1:req_tests
        [sigmas, selected_models, final_parameters] = runme_as_fcn(dim,it,0,method);
        save(sprintf('processedM%d_%dD_%d',method,dim,it),'sigmas','selected_models','final_parameters');
    end

    % eval 3D data M1
    dim = 3;
    for it=1:req_tests
        [sigmas, selected_models, final_parameters] = runme_as_fcn(dim,it,0,method);
        save(sprintf('processedM%d_%dD_%d',method,dim,it),'sigmas','selected_models','final_parameters');
    end
end

%% Process results
fprintf('Processing results..\n');

for method = [1,2,3]
    for it=1:req_tests
       plot_results(2,it,method,'off'); 
    end
    for it=1:req_tests
       plot_results(3,it,method,'off'); 
    end
end
