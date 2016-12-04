model = cell(4,3); %first cell is function, second cell is x dimension, third cell is printing function
% model1: a1 + a2*x
model(1,3) = {@(params)sprintf('%f + (%f * x)',params(1),params(2))};
model(1,1) = {@(x,xdata)x(1)+x(2)*xdata.^1}; 
% model2: a1 + a2*x + a3*x^2
model(2,3) = {@(params)sprintf('%f + (%f * x) + (%f * x^2)',params(1),params(2),params(3))};
model(2,1) = {@(x,xdata)x(1)+x(2)*xdata.^1+x(3)*xdata.^2}; 
% model3: a1 + a2*x + a3*x^2 + a4*x^3
model(3,3) = {@(params)sprintf('%f + (%f * x) + (%f * x^2) + (%f * x^3)',params(1),params(2),params(3),params(4))};
model(3,1) = {@(x,xdata)x(1)+x(2)*xdata.^1+x(3)*xdata.^2+x(4)*xdata.^3}; 
% model3: a1 + a2*x + a3*x^2 + a4*x^3 + a5*x^4
model(4,3) = {@(params)sprintf('%f + (%f * x) + (%f * x^2) + (%f * x^3) + (%f * x^4)',params(1),params(2),params(3),params(4),params(5))};
model(4,1) = {@(x,xdata)x(1)+x(2)*xdata.^1+x(3)*xdata.^2+x(4)*xdata.^3+x(5)*xdata.^4};
% model3: a1 + a2*x + a3*x^2 + a4*x^3 + a5*x^4 + a6*x^5
model(5,3) = {@(params)sprintf('%f + (%f * x) + (%f * x^2) + (%f * x^3) + (%f * x^4) + (%f * x^5)',params(1),params(2),params(3),params(4),params(5),params(6))};
model(5,1) = {@(x,xdata)x(1)+x(2)*xdata.^1+x(3)*xdata.^2+x(4)*xdata.^3+x(5)*xdata.^4+x(6)*xdata.^5};
% model3: a1 + a2*x + a3*x^2 + a4*x^3 + a5*x^4 + a6*x^5 + a7*x^6
model(6,3) = {@(params)sprintf('%f + (%f * x) + (%f * x^2) + (%f * x^3) + (%f * x^4) + (%f * x^5) + (%f * x^6)',params(1),params(2),params(3),params(4),params(5),params(6),params(7))};
model(6,1) = {@(x,xdata)x(1)+x(2)*xdata.^1+x(3)*xdata.^2+x(4)*xdata.^3+x(5)*xdata.^4+x(6)*xdata.^5+x(7)*xdata.^6};

model(1,2) = {2};
model(2,2) = {3};
model(3,2) = {4};
model(4,2) = {5};
model(5,2) = {6};
model(6,2) = {7};

solve_lsq = @(fn,x0,xdata,ydata)lsqcurvefit(fn,x0,xdata,ydata);
promenne = 'x';