%% generating example
% always make sure you have the right set of models (dimension dependent)
% then run generator_3D, it works with 2D and 3D, might as well work with
% more dimensional models, not tested yet
% generator_3D function will generate apropriate .mat files with intended
% dimension in name. syntax is
% generator_3D(model_fcn_hndl,params,dimension,intended_sigma,dataset_number);
model_2D;
generator(model{2,1},[10 20 10 -40],2,1000,3);

model_3D;
generator(model{1,1},[10 20 10 -40],3,1000,3);