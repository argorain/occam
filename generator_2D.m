close all
clear all
clc

%% Set generator parameters

% data polynom, line per dimension
p2 = [2, 5, 10]; % 2D example
p = p2;

% x-timeline
x = [-10:0.2:10];

% filename
filename = '2D_3';

% std deviation
sigma = 10;

fprintf('Generating data...\n');

%% Generate data
[dim,h] = size(p);
dim = dim + 1; % y-dimensions + x-dimension

Y = zeros(dim, length(x));
Y(1,:) = x;
YN = Y;

for n = [2:dim]
    Y(n,:) = polyval(p(n-1,:), x);
    
    % add noise
    noise = sigma*randn(1,length(x));
    YN(2:end, :) = Y(n, :) + noise;
end

% store data
csvwrite(strcat('data_',filename,'.csv'),Y);
csvwrite(strcat('data_',filename,'_n.csv'),YN);

fprintf('Generation done.\n');