model = cell(4,1);
model(1) = {@(x,xdata)x(1)+x(2)*xdata.^1}; 
model(2) = {@(x,xdata)x(1)+x(2)*xdata.^1+x(3)*xdata.^2}; 
model(3) = {@(x,xdata)x(1)+x(2)*xdata.^1+x(3)*xdata.^2+x(4)*xdata.^3}; 
model(4) = {@(x,xdata)x(1)+x(2)*xdata.^1+x(3)*xdata.^2+x(4)*xdata.^3+x(5)*xdata.^4};

solve_lsq = @(fn,x0,xdata,ydata)lsqcurvefit(fn,x0,xdata,ydata);