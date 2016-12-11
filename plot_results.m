function plot_results(dim, dataset, methods, visibility)
set(0,'DefaultFigureVisible',visibility)
file_in = sprintf('data_%dD_%d.mat',dim,dataset);
file_processed = cell(size(methods)-1);
for it=1:size(methods,2)-1
    file_processed{it} = sprintf('processedM%d_%dD_%d.mat',methods(it),dim,dataset);
end
dimension = dim;
if dim==2
    model_2D;
elseif dim==3
    model_3D;
end
load(file_in);
fin_pars = cell(size(model,1),size(methods,2));
for it=1:size(methods,2)-1
    load(file_processed{it});
    fin_pars(:,it) = final_parameters;
    if it==1
        sel_models = selected_models;
    else
        sel_models(it+1) = selected_models(2);
    end
end
figure();
plotcol = {'-r', '+g', '-.b'};
titleStr = strcat('Model fitting, ',num2str(dim),'D data, dataset #',num2str(dataset), ' Method #',num2str(methods));
%% Show data
% TODO: expand for another dimensions, not only 3D
for i=methods
    pos = sel_models(i);
    if i==1
        final_parameters = fin_pars(:,1);
    else
        final_parameters = fin_pars(:,i-1);
    end
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
            plot(in_data, noise, '.c')
        end
        plot(in_data,fn(final_parameters{pos},in_data), plotcol{i})
        grid on;
        xlabel('x')
        ylabel('y')
    elseif dimension == 3
        hold on;
        %plot3(repmat(in_data(1,:),size(in_data,2),1), repmat(in_data(2,:),size(in_data,2),1)', data, '.r')  
        if i==1
            plot3(repmat(in_data(1,:),size(in_data,2),1), repmat(in_data(2,:),size(in_data,2),1)', noise, '.c')
        end
        plot3(repmat(in_data(1,:),size(in_data,2),1), repmat(in_data(2,:),size(in_data,2),1)', fn(final_parameters{pos},in_data), plotcol{i})
        grid on;
        xlabel('x')
        ylabel('y1')
        zlabel('y2')
        view([70 30])
    else
        disp('Unsupported dimension, ending.');
        return;
    end
    %legend('original','noisy','model')
end
title(titleStr)
legend('noisy','model1','model2','model3')
filename = strcat('processedM',num2str(methods),'_',num2str(dim),'D_',num2str(dataset),'.png');
saveas(gcf, filename);