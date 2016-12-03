clear all 
close all
clc

disp('Occams razor model selector');
%% Set parameters
dataFile = 'data_3D_3'; % data file name
model_3D;               % model file name
dimension = 3;          % space dimension

%% Load data
disp('Loading data...')
data = csvread(strcat(dataFile,'.csv'));
noise = csvread(strcat(dataFile,'_n.csv'));
if dimension > 2
    in_data=csvread(strcat(dataFile,'_in.csv'));
end

addpath('fun');

%% Model fitting (Least square)
disp('Model  fitting...')

x0 = [1,1,1,1,1,1,1,1,1]; % start parameters, amount results in polynom length
ls = zeros(length(model), length(x0));
for i = [1:length(model)]
    fn = model{i};
    % LS fitting
    if dimension == 2
        ls(i,:) = solve_lsq(fn,x0,noise(1,:),noise(2,:));
    else
        ls(i,:) = solve_lsq(fn,x0,in_data,noise);
    end
    % plot of results
    %plot(noise(1,:),fn(ls(i,:),noise(1,:)), '-black')
end

%% Maximum Likelihood
% https://onlinecourses.science.psu.edu/stat414/node/191
disp('Maximum Likelihood evaluation...')

n = length(noise(1,:));
P = zeros(length(model), 1);
% simple ML estimator for 2D
% smallest one is best fitting
for i = [1:length(model)]
    fn = model{i};
    if dimension == 2
        P(i) = 1/n * sum((fn(ls(i,:),noise(1,:)) - noise(2,:)).^2);
    else
        P(i) = model_eval_sq(ls(i,:),fn,in_data, noise);
    end
    
    % show them
    fprintf('P(%d) = %f\n', i, P(i))
end

%% Show data
% TODO: expand for another dimensions, not only 3D
disp('Results')
[val, pos] = min(P);
fn = model{pos};
fprintf('Selected model #%d\n', pos)
fprintf('Parameters')
ls(pos,:)

if dimension == 2
    figure;
    hold on;
    %plot(data(1,:), data(2,:), '.r')   
    plot(noise(1,:), noise(2,:), '.b')
    plot(noise(1,:),fn(ls(pos,:),noise(1,:)), '-black')
    grid on;
    title('Model fitting, 2D data')
    xlabel('x')
    ylabel('y')
elseif dimension == 3
    figure;
    hold on;
    %plot3(repmat(in_data(1,:),size(in_data,2),1), repmat(in_data(2,:),size(in_data,2),1)', data, '.r')  
    plot3(repmat(in_data(1,:),size(in_data,2),1), repmat(in_data(2,:),size(in_data,2),1)', noise, '.b')
    plot3(repmat(in_data(1,:),size(in_data,2),1), repmat(in_data(2,:),size(in_data,2),1)', fn(ls(pos,:),in_data), '-k')
    grid on;
    title('Model fitting, 3D data')
    xlabel('x')
    ylabel('y1')
    ylabel('y2')
else
    disp('Unsupported dimension, ending.');
    return;
end
%legend('original','noisy','model')
legend('noisy','model')
