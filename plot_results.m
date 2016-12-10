function plot_results(dim, dataset);
file_in = sprintf('data_%dD_%d.mat',dim,dataset);
file_processed = sprintf('processed_%dD_%d.mat',dim,dataset);
dimension = dim;
if dim==2
    model_2D;
elseif dim==3
    model_3D;
end
load(file_in);
load(file_processed);
figure();
plotcol = {'-r', '+g'};
%% Show data
% TODO: expand for another dimensions, not only 3D
for i=[1,2]
    pos = selected_models(i);
    fn = model{pos,1};
    disp('')
    fprintf('Results METHOD %d\n', i)
    disp('================')
    fprintf('Selected model #%d\n', pos)
    fprintf('Parameters')
    final_parameters{pos}
    vys_rovnice = model{pos,3};
    fprintf('Equation: f(%s) = \n %s\n',promenne, vys_rovnice(final_parameters{pos}));

    if dimension == 2
        hold on;
        %plot(in_data, data, '.r')   
        if i==1
            plot(in_data, noise, '.b')
        end
        plot(in_data,fn(final_parameters{pos},in_data), plotcol{i})
        grid on;
        title('Model fitting, 2D data')
        xlabel('x')
        ylabel('y')
    elseif dimension == 3
        hold on;
        %plot3(repmat(in_data(1,:),size(in_data,2),1), repmat(in_data(2,:),size(in_data,2),1)', data, '.r')  
        if i==1
            plot3(repmat(in_data(1,:),size(in_data,2),1), repmat(in_data(2,:),size(in_data,2),1)', noise, '.b')
        end
        plot3(repmat(in_data(1,:),size(in_data,2),1), repmat(in_data(2,:),size(in_data,2),1)', fn(final_parameters{pos},in_data), plotcol{i})
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
    legend('noisy','model1','model2')
end