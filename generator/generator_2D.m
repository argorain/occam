close all
clear all
clc

%% Set generator parameters

% data polynom, line per dimension
p2 = [-1 1 -1 1 -1]; % 2D example
p = p2;

% x-timeline
x = [-10:0.2:10];

% filename
filename = '2D_3';

% std deviation
sigma_data = 1000;

fprintf('Generating data...\n');

%% Generate data
%[dim,h] = size(p);
%dim = dim + 1; % y-dimensions + x-dimension

Y = zeros(1, length(x));
%Y(1,:) = x;
YN = Y;

n = 1;
Y(n,:) = polyval(p(n,:), x);
    
% add noise
noise = sigma*randn(size(x));
YN(n, :) = Y(n, :) + noise;

% store data
data = Y;
in_data = x;
noise = YN;
%{
csvwrite(strcat('data_',filename,'.csv'),Y);
csvwrite(strcat('data_',filename,'_n.csv'),YN);
csvwrite(strcat('data_',filename,'_in.csv'),x);
csvwrite(strcat('data_',filename,'_sigma.csv'),sigma);
%}
save(strcat('data_',filename,'.mat'),'data','noise','in_data','sigma');

fprintf('Generation done.\n');