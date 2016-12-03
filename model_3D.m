model = cell(4,2); %first cell is function, second cell is x dimension
model(1,1) = {@(params,in_data)params(1)+(params(3)*in_data(2,:))'*(params(2)*in_data(1,:))};
model(2,1) = {@(params,in_data)params(1)+(params(3)*in_data(2,:))'*(params(2)*in_data(1,:)) + (params(5)*in_data(2,:)'.^2)*(params(4)*in_data(1,:).^2)};
model(3,1) = {@(params,in_data)params(1)+(params(3)*in_data(2,:))'*(params(2)*in_data(1,:)) ... 
    + (params(5)*in_data(2,:)'.^2)*(params(4)*in_data(1,:).^2) ...
    + (params(7)*in_data(2,:)'.^3)*(params(6)*in_data(1,:).^3)};
model(4,1) = {@(params,in_data)params(1)+(params(3)*in_data(2,:))'*(params(2)*in_data(1,:)) ... 
    + (params(5)*in_data(2,:)'.^2)*(params(4)*in_data(1,:).^2) ...
    + (params(7)*in_data(2,:)'.^3)*(params(6)*in_data(1,:).^3) ...
    + (params(9)*in_data(2,:)'.^4)*(params(8)*in_data(1,:).^4)};

model(1,2) = {3};
model(2,2) = {5};
model(3,2) = {7};
model(4,2) = {9};

solve_lsq = @(fn,x0,in_data,Zdata)solve_3d_lsq(fn,x0,in_data,Zdata);