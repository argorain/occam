clear all 
close all
clc

%% Set parameters
dataFile = 'data_2D_3'; % data file name
model_2D;               % model file name
dimension = 2;          % space dimension

%% Load data
data = csvread(strcat(dataFile,'.csv'));
noise = csvread(strcat(dataFile,'_n.csv'));

%% Show data
% TODO: expand for another dimensions, not only 3D
if dimension == 2
    figure;
    plot(data(1,:), data(2,:), '.r')
    hold on;
    plot(noise(1,:), noise(2,:), '.b')
    grid on;
    legend('original','noisy')
    title('Original and noisy 2D sequence')
    xlabel('x')
    ylabel('y')
elseif dimension == 3
    figure;
    plot3(data(1,:), data(2,:), data(3,:), '.r')
    hold on;
    plot3(noise(1,:), noise(2,:), noise(3,:), '.b')
    grid on;
    legend('original','noisy')
    title('Original and noisy 3D sequence')
    xlabel('x')
    ylabel('y1')
    ylabel('y2')
end

%% Calculate error (Least square)

x0 = [1,1,1,1,1]; % start parameters, amount results in polynom length
ls = zeros(length(model), length(x0));
for i = [1:length(model)]
    fn = model{i};
    % LS fitting
    ls(i,:) = lsqcurvefit(fn,x0,noise(1,:),noise(2,:));
    % plot of results
    %plot(noise(1,:),fn(ls(i,:),noise(1,:)), '-black')
end

%% Maximum Likelihood

% https://onlinecourses.science.psu.edu/stat414/node/191

n = length(noise(1,:));
P = zeros(length(model), 1);
% simple ML estimator for 2D
% smallest one is best fitting
for i = [1:length(model)]
    fn = model{i};
    P(i) = 1/n * sum((fn(ls(i,:),noise(1,:)) - noise(2,:)).^2);
end

[val, pos] = min(P);
fn = model{pos};
plot(noise(1,:),fn(ls(pos,:),noise(1,:)), '-black')
legend('original','noisy','model')
