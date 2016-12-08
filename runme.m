clear all 
close all
clc

addpath('fun');
addpath('model');
addpath('generator');

disp('Occams razor model selector');
%% Set parameters
dimension = 2;          % space dimension
dataFile = ['data_' sprintf('%d',dimension) 'D_3']; % data file name
if dimension == 3
    model_3D;               % model file name
else
    model_2D;
end
compensation_exp = 0;     % exponent of compensation, 1 for linear, 2 for quadratic, 3 for cubic...
sigmaAvail = 1;         % Sigma is known

%% Load data
disp('Loading data...')
data = csvread(strcat(dataFile,'.csv'));
noise = csvread(strcat(dataFile,'_n.csv'));
in_data=csvread(strcat(dataFile,'_in.csv'));
if sigmaAvail ==1
    sigma=csvread(strcat(dataFile,'_sigma.csv'));
end

%% Model fitting - Maximum Likelihood (Least square)
% https://onlinecourses.science.psu.edu/stat414/node/191

disp('Model  fitting...')

ls = cell(length(model), 1);
for i = [1:length(model)]
    fn = model{i};
    x0 = ones(1,model{i,2});
    ls(i) = {solve_lsq(fn,x0,in_data,noise)};
   
    % plot of results
    %plot(noise(1,:),fn(ls(i,:),noise(1,:)), '-black')
end

%% Classification

disp('Classification...')

n = length(noise(1,:));
P = zeros(length(model), 1);

N = 2*n;

% smallest one is best fitting
for i = [1:length(model)]
    fn = model{i,1};
    %if dimension == 2
        P(i) = sqrt(sum((fn(ls{i},in_data)-noise).^2)/n);
        %P(i) = (1/n * sum(sqrt(((fn(ls{i},in_data) - noise).^2)/N)));
    %else
       % P(i) = model_eval_sq(ls{i},fn,in_data, noise);
    %end
    d = model{i,2};
    if sigmaAvail == 1
        % sigma is known    
        EresD = sigma*sqrt(1-d/N)
    else
    
    end
    
    % show them
    fprintf('P(%d) = %f\n', i, P(i))
end

% Compensate model dimensionality (smaller dimensions are better, smaller P is better)
w = zeros(1, length(model));
% load dimensions of models
for i = [1:length(model)]
    w(i) = model{i,2};
end
% normaize
wmax = max(w);
w = w./wmax;
w = w.^compensation_exp;

% compensate
Po = P;
P = P .* w';

% Select best match
[val, pos] = min(P);
fn = model{pos,1};

%% Show data
% TODO: expand for another dimensions, not only 3D
disp('')
disp('Results')
disp('=======')
fprintf('Selected model #%d\n', pos)
fprintf('Parameters')
ls{pos}
vys_rovnice = model{pos,3};
fprintf('Equation: f(%s) = \n %s\n',promenne, vys_rovnice(ls{pos}));

if dimension == 2
    figure;
    hold on;
    %plot(in_data, data, '.r')   
    plot(in_data, noise, '.b')
    plot(in_data,fn(ls{pos},in_data), '-r')
    grid on;
    title('Model fitting, 2D data')
    xlabel('x')
    ylabel('y')
elseif dimension == 3
    figure;
    hold on;
    %plot3(repmat(in_data(1,:),size(in_data,2),1), repmat(in_data(2,:),size(in_data,2),1)', data, '.r')  
    plot3(repmat(in_data(1,:),size(in_data,2),1), repmat(in_data(2,:),size(in_data,2),1)', noise, '.b')
    plot3(repmat(in_data(1,:),size(in_data,2),1), repmat(in_data(2,:),size(in_data,2),1)', fn(ls{pos},in_data), '-r')
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
