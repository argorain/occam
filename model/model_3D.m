model = cell(7,3); %first cell is function, second cell is x dimension, third is sprintf function
% model 1: a1 + a2*y + a3*xy + a4*x
model(1,3) = {@(params)sprintf('%f + (%f * y) + (%f * xy) + (%f * x)',params(1),params(2),params(3),params(4))};
model(1,1) = {@(params,in_data)params(1) + params(2)*in_data(2,:)'*ones(1,size(in_data,2)) + params(3)*in_data(2,:)'*in_data(1,:) + params(4)*ones(size(in_data,2),1)*in_data(1,:)}; %in_data(2,:) is y and in_data(1,:) is x
%{
  model 2: a1 + a2*y + a3*xy + a4*x 
         + a5*y^2 + a6*(xy)^2 + a7*x^2
%}
model(5,3) = {@(params)sprintf(['%f + (%f * y) + (%f * xy) + (%f * x)\n' ...
    ' + (%f * y^2) + (%f * (xy)^2) + (%f * x^2)'],params(1),params(2),params(3),params(4),params(5),params(6),params(7))};
model(5,1) = {@(params,in_data)params(1) + params(2)*in_data(2,:)'*ones(1,size(in_data,2)) + params(3)*in_data(2,:)'*in_data(1,:) + params(4)*ones(size(in_data,2),1)*in_data(1,:) ...
    + params(5)*in_data(2,:).^2'*ones(1,size(in_data,2)) + params(6)*in_data(2,:)'.^2 * in_data(1,:).^2 + params(7)*ones(size(in_data,2),1)*in_data(1,:).^2};
%{
  model 3: a1 + a2*y + a3*xy + a4*x 
         + a5*y^2 + a6*(xy)^2 + a7*x^2
         + a8*y^3 + a9*(xy)^3 + a10*x^3
%}
model(6,3) = {@(params)sprintf(['%f + (%f * y) + (%f * xy) + (%f * x)\n' ...
    ' + (%f * y^2) + (%f * (xy)^2) + (%f * x^2) + (%f * y^3) + (%f * (xy)^3) + (%f * x^3)'],params(1),params(2),params(3),params(4),params(5),params(6),params(7),params(8),params(9),params(10))};
model(6,1) = {@(params,in_data)params(1) + params(2)*in_data(2,:)'*ones(1,size(in_data,2)) + params(3)*in_data(2,:)'*in_data(1,:) + params(4)*ones(size(in_data,2),1)*in_data(1,:) ...
    + params(5)*in_data(2,:).^2'*ones(1,size(in_data,2)) + params(6)*in_data(2,:)'.^2 * in_data(1,:).^2 + params(7)*ones(size(in_data,2),1)*in_data(1,:).^2 ...
    + params(8)*in_data(2,:).^3'*ones(1,size(in_data,2)) + params(9)*in_data(2,:)'.^3 * in_data(1,:).^3 + params(10)*ones(size(in_data,2),1)*in_data(1,:).^3};
%{
  model 4: a1 + a2*y + a3*xy + a4*x 
         + a5*y^2 + a6*(xy)^2 + a7*x^2
         + a8*y^3 + a9*(xy)^3 + a10*x^3
         + a11*y^4 + a12*(xy)^4 + a13*x^4
%}
model(7,3) = {@(params)sprintf(['%f + (%f * y) + (%f * xy) + (%f * x)\n' ...
    ' + (%f * y^2) + (%f * (xy)^2) + (%f * x^2)\n + (%f * y^3) + (%f * (xy)^3) + (%f * x^3)\n' ...
    ' + (%f * y^4) + (%f * (xy)^4) + (%f * x^4)'],params(1),params(2),params(3),params(4),params(5),params(6), ...
    params(7),params(8),params(9),params(10),params(11),params(12),params(13))};
model(7,1) = {@(params,in_data)params(1) + params(2)*in_data(2,:)'*ones(1,size(in_data,2)) + params(3)*in_data(2,:)'*in_data(1,:) + params(4)*ones(size(in_data,2),1)*in_data(1,:) ...
    + params(5)*in_data(2,:).^2'*ones(1,size(in_data,2)) + params(6)*in_data(2,:)'.^2 * in_data(1,:).^2 + params(7)*ones(size(in_data,2),1)*in_data(1,:).^2 ...
    + params(8)*in_data(2,:).^3'*ones(1,size(in_data,2)) + params(9)*in_data(2,:)'.^3 * in_data(1,:).^3 + params(10)*ones(size(in_data,2),1)*in_data(1,:).^3 ...
    + params(11)*in_data(2,:).^4'*ones(1,size(in_data,2)) + params(12)*in_data(2,:)'.^4 * in_data(1,:).^4 + params(13)*ones(size(in_data,2),1)*in_data(1,:).^4};
%{
 model 5: a1 + a2*y^2 + a3*(xy) + a4*x^2
%}
model(2,3) = {@(params)sprintf('%f + (%f * y^2) + (%f * xy) + (%f * x^2)',params(1),params(2),params(3),params(4))};
model(2,1) = {@(params,in_data)params(1) + params(2)*(in_data(2,:).^2)'*ones(1,size(in_data,2)) + params(3)*in_data(2,:)'*in_data(1,:) + params(4)*ones(size(in_data,2),1)*in_data(1,:).^2}; 
%{
 model 6: a1 + a2*y^3 + a3*y^2*x + a4*y*x^2 + a5*x^3
%}
model(3,3) = {@(params)sprintf('%f + (%f * y^3) + (%f * x * y^2) + (%f * x^2 * y) + (%f * x^3)',params(1),params(2),params(3),params(4),params(5))};
model(3,1) = {@(params,in_data)params(1) + params(2)*(in_data(2,:).^3)'*ones(1,size(in_data,2)) + params(3)*(in_data(2,:).^2)'*in_data(1,:) + params(4)*in_data(2,:)'*in_data(1,:).^2 + params(5)*ones(size(in_data,2),1)*in_data(1,:).^3}; 

%{
 model 7: a1 + a2*y^4 + a3*y^3*x + a4*y^2*x^2 + a5*y*x^3 + a6*x^4
%}
model(4,3) = {@(params)sprintf('%f + (%f * y^4) + (%f * x * y^3) + (%f * x^2 * y^2) + (%f * x^3 * y) + (%f * x^4)',params(1),params(2),params(3),params(4),params(5),params(6))};
model(4,1) = {@(params,in_data)params(1) + params(2)*(in_data(2,:).^4)'*ones(1,size(in_data,2)) + params(3)*(in_data(2,:).^3)'*in_data(1,:) + params(4)*(in_data(2,:).^2)'*in_data(1,:).^2 + params(5)*(in_data(2,:))'*in_data(1,:).^3 + params(6)*ones(size(in_data,2),1)*in_data(1,:).^4}; 

model(1,2) = {4};
model(2,2) = {4}; %5 -> 2
model(3,2) = {5}; %6 -> 3
model(4,2) = {6}; %7 -> 4
model(5,2) = {7}; %2 -> 5
model(6,2) = {10};%3 -> 6
model(7,2) = {13};%4 -> 7

solve_lsq = @(fn,x0,in_data,Zdata)solve_3d_lsq(fn,x0,in_data,Zdata);
promenne = 'x,y';