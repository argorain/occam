clear variables
close all

k = [0 1 2 3];
sigma = 5;

x = linspace(0,100);
y = k(1)*x.^3+k(2)*x.^2+k(3)*x+k(4)+sigma*randn(size(x));

err = [];
errEst = [];
disp(['eRes:' char(9) 'Pozorované' char(9) 'Předpokládané'])

for i = 1:4
   kEst = polyfit(x,y,i);
   yEst = ones(size(x))*kEst(end);
   for j = 1:i
       yEst = yEst+kEst(j)*x.^(i-j+1);
   end
   err(end+1) = sqrt(sum((y-yEst).^2)/length(x));
   errEst(end+1) = sigma*sqrt((1-(i+1)/length(x)));
   
   disp([char(9) char(9) num2str(err(end),4) char(9) char(9) char(9) num2str(errEst(end),4)])
end


   