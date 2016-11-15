close all
clear all
clc

%% Set generator parameters

% data polynom, line per dimension
p2 = [2, 5, 10]; % 2D example
p3 = [2, 3, 5; 
     4, 0, 0];   % 3D example
p = p2;
 
% Noise added to data at dB
noise = 10; 

% x-timeline
x = [-10:0.2:10];

% filename
filename = '2D_3';

fprintf('Generating data...\n');

%% Generate data
[dim,h] = size(p);
dim = dim + 1; % y-dimensions + x-dimension

Y = zeros(dim, length(x));
Y(1,:) = x;
YN = Y;

for n = [2:dim]
    Y(n,:) = polyval(p(n-1,:), x);
end

% add noise
YN(2:end,:) = awgn(Y(2:end,:), noise,'measured');

% store data
csvwrite(strcat('data_',filename,'.csv'),Y);
csvwrite(strcat('data_',filename,'_n.csv'),YN);

fprintf('Generation done.\n');