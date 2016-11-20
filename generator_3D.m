%% 3D generator
close all
clear all
clc

%% Set generator parameters

% data polynom, line per dimension
p2 = [2, 5, 10]; % 2D example
p3 = [2, 3, 5; 
     4, 0, 0];   % 3D example
p = p3;
 
% Noise added to data at dB
noise = 10; 

% x-timeline
x = [-10:0.2:10];

% y-independent parameter
y = [-10:0.2:10];

% filename
filename = '3D_3';

% std deviation
sigma = 10;

fprintf('Generating data...\n');

%% Generate data
[dim,h] = size(p);
dim = dim + 1; % y-dimensions + x-dimension
in_data = [y; x];
Z = zeros(length(y), length(x)); %original would create just a "curve" in space, not surface, as we might want
%Y(1,:) = x;
ZN = Z;
Z = polyval(p(2,:), y)'*polyval(p(1,:), x);
  
% add noise
noise = sigma*randn(length(y),length(x));
ZN = Z + noise;

% store data
csvwrite(strcat('data_',filename,'_in.csv'),[x;y]);
csvwrite(strcat('data_',filename,'.csv'),Z);
csvwrite(strcat('data_',filename,'_n.csv'),ZN);

fprintf('Generation done.\n');