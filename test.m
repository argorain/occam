clear all
close all
clc


%% Data init
x = [-10:0.2:10];
y = 2*x.^2 + -30; %original
yn = awgn(y, 10,'measured');

% plot them
figure
plot(x,y, '.r')
hold on
plot(x,yn, '.b')
legend('original','gaussian noise')
title('Original and noisy 2D sequence')
xlabel('x')
ylabel('y')

%% Least squares

%models (linear, quadratic, cubic,...)
fun1 = @(x,xdata)x(1)+x(2)*xdata.^1; 
fun2 = @(x,xdata)x(1)+x(2)*xdata.^2; 
fun3 = @(x,xdata)x(1)+x(2)*xdata.^3; 
fun4 = @(x,xdata)x(1)+x(2)*xdata.^4; 

x0 = [1,1,1,1]; % start parameters, amount results in polynom length
% LS fitting
ls1 = lsqcurvefit(fun1,x0,x,yn)
ls2 = lsqcurvefit(fun2,x0,x,yn)
ls3 = lsqcurvefit(fun3,x0,x,yn)
ls4 = lsqcurvefit(fun4,x0,x,yn)

% plot of results
plot(x,fun1(ls1,x), '-black')
plot(x,fun2(ls2,x), '-black')
plot(x,fun3(ls3,x), '-black')
plot(x,fun4(ls4,x), '-black')

%% Maximum likelihood
% https://onlinecourses.science.psu.edu/stat414/node/191

n = length(x);
% simple ML estimator for 2D
% smallest one is best fitting
P1 = 1/n * sum(fun1(ls1,x) - yn)
P2 = 1/n * sum(fun2(ls2,x) - yn)
P3 = 1/n * sum(fun3(ls3,x) - yn)
P4 = 1/n * sum(fun4(ls4,x) - yn)




