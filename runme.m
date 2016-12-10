clear all 
close all
clc

addpath('fun');
addpath('model');
addpath('generator');

disp('Occams razor model selector');
%% Set parameters
dimension = 3;          % space dimension
dataFile = ['data_' sprintf('%d',dimension) 'D_3']; % data file name
if dimension == 3
    model_3D;               % model file name
else
    model_2D;
end
compensation_exp = 1;     % exponent of compensation, 1 for linear, 2 for quadratic, 3 for cubic...
sigmaAvail = 1;         % Sigma is known
treshold=0.1;           % Treshold percentage (0-1.0) ~ 0-100%

%% Load data
disp('Loading data...')
%{
data = csvread(strcat(dataFile,'.csv'));
noise = csvread(strcat(dataFile,'_n.csv'));
in_data=csvread(strcat(dataFile,'_in.csv'));
if sigmaAvail ==1
    sigma=csvread(strcat(dataFile,'_sigma.csv'));
end
%}
load([dataFile '.mat']);

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
Eres = zeros(length(model), 1);
EresData = zeros(length(model), 1);
sigmaEst = zeros(length(model), 1);

N = 2*n;

% smallest one is best fitting
for i = [1:length(model)]
    fn = model{i,1};

    %Eres(i) = sqrt(sum((fn(ls{i},in_data)-noise).^2)/n);
    Eres(i) = model_eval_sq(ls{i},fn,in_data, noise);

    d = model{i,2};
    if sigmaAvail == 1
        % sigma is known    
        EresData(i) = sigma*sqrt(1-d/N);
        fprintf('\nEresData(%d) = %f\n',i, EresData(i));
    else
        sigmaEst(i) = sqrt((Eres(i)^2)/(1-d/N));
        fprintf('SigmaEst(%d) = %f\n', i, sigmaEst(i))
    end
    
    % show them
    fprintf('Eres(%d) = %f\n', i, Eres(i))
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

posL = zeros(1, 2);

% METHOD 1
% compensate
%EresOrig = Eres;
Eres1 = Eres .* w';
% Select best match
[val, posL(1)] = min(Eres1);

% METHOD 2
if sigmaAvail == 1
    for i = [1:length(model)]
        posL(2) = i;
        if Eres(i)<EresData(i)*(1-treshold)
            break; 
        end
    end
else
    for i=[1:length(model)-1]
        posL(2) = i;
        if sigmaEst(i)<sigmaEst(i+1)*(1+treshold)
            break;
        end
    end
end
%% Show data
% TODO: expand for another dimensions, not only 3D
for i=[1,2]
    pos = posL(i);
    fn = model{pos,1};
    
    disp('')
    fprintf('Results METHOD %d\n', i)
    disp('================')
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

end
