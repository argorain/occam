model = cell(4,2); %first cell is function, second cell is x dimension
model(1,1) = {@(x,xdata)x(1)+x(2)*xdata.^1}; 
model(2,1) = {@(x,xdata)x(1)+x(2)*xdata.^1+x(3)*xdata.^2}; 
model(3,1) = {@(x,xdata)x(1)+x(2)*xdata.^1+x(3)*xdata.^2+x(4)*xdata.^3}; 
model(4,1) = {@(x,xdata)x(1)+x(2)*xdata.^1+x(3)*xdata.^2+x(4)*xdata.^3+x(5)*xdata.^4};

model(1,2) = {2};
model(2,2) = {3};
model(3,2) = {4};
model(4,2) = {5};

solve_lsq = @(fn,x0,xdata,ydata)lsqcurvefit(fn,x0,xdata,ydata);