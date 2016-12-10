function generator_3D(model,params,dim,sigma)
%% 3D generator
%close all
%clear all
%clc

%% Set generator parameters

% data polynom, line per dimension
p3 = [-20, -3, 5; 
     -40, 10, -10];   % 3D example
p = p3;

% x-timeline
x = [-10:0.2:10];

% y-independent parameter
y = [-10:0.2:10];

% filename
filename = [sprintf('%d',dim) 'D_3'];

% std deviation
%sigma = 10000;

fprintf('Generating data...\n');

%% Generate data
%[dim,h] = size(p);
%dim = dim + 1; % y-dimensions + x-dimension
in_data = repmat(x,dim-1,1);
%Z = zeros(length(y), length(x)); %original would create just a "curve" in space, not surface, as we might want
%Y(1,:) = x;
%ZN = Z;
Z = model(params,in_data);
  
% add noise
noise = sigma*randn(size(Z));
ZN = Z + noise;

% store data
%in_data = [x;y];
data = Z;
noise = ZN;
%{
csvwrite(strcat('data_',filename,'_in.csv'),[x;y]);
csvwrite(strcat('data_',filename,'.csv'),Z);
csvwrite(strcat('data_',filename,'_n.csv'),ZN);
csvwrite(strcat('data_',filename,'_sigma.csv'),sigma);
%}
save(['data_' filename '.mat'],'in_data','data','noise','sigma');

fprintf('Generation done.\n');