%% generate Fig.5: stimulation on the neural data sub#1
clear
%% ITPC with unit circle
load('sub1_sync.mat') %load variable 'samples'
%%
total_cycle = 400;
samples(:,1) = mod(samples(:,1),360); 
repeat_samples = period_repeat(total_cycle,samples);
number_class_k = 2;
%R = 0.8; 
R_input = 5; %direct change value here or use R*2*pi 
[cycle_x,cycle_y] = angle_projection(R_input,repeat_samples);
rng(100)
[idx_K] = kmeans([cycle_x,cycle_y],number_class_k*(total_cycle+1));
%K-means clustering search
plot_idx = 0; %do the plot separately here
[plot_class,legendInfo]= kmeans_search(total_cycle,samples,idx_K,repeat_samples,number_class_k,plot_idx);
%%
figure(5)
clf
subplot(131)
for ix_class = 1:size(plot_class,2)
    polarscatter(deg2rad(plot_class(ix_class).points_in_class(:,1)),plot_class(ix_class).points_in_class(:,2),"filled")
    hold on
end
legend(legendInfo,'Location','best')
title('K-means')
rlim([0 1])
rticks(0:0.5:1)
rticklabels({'0','0.5','1'})
%%
[cycle_x,cycle_y] = angle_projection(5,repeat_samples);
[idx_bd] = dbscan([cycle_x,cycle_y],0.25,5);
%DBSCAN clustering search
plot_idx = 0; %do the plot separately here
subplot(132)
[plot_class,legendInfo]= dbscan_search(total_cycle,samples,idx_bd,plot_idx);
for ix_class = 1:size(plot_class,2)
    polarscatter(deg2rad(plot_class(ix_class).points_in_class(:,1)),plot_class(ix_class).points_in_class(:,2),"filled")
    hold on
end
legend(legendInfo,'Location','best')
title('DBSCAN')
rlim([0 1])
rticks(0:0.5:1)
rticklabels({'0','0.5','1'})
%%
[cycle_x,cycle_y] = angle_projection(5,repeat_samples);
[idx_bd] = dbscan([cycle_x,cycle_y],0.2,3);
%DBSCAN clustering search
plot_idx = 0; %do the plot separately here
subplot(133)
[plot_class,legendInfo]= dbscan_search(total_cycle,samples,idx_bd,plot_idx);
for ix_class = 1:size(plot_class,2)
    polarscatter(deg2rad(plot_class(ix_class).points_in_class(:,1)),plot_class(ix_class).points_in_class(:,2),"filled")
    hold on
end
legend(legendInfo,'Location','best')
title('DBSCAN')
rlim([0 1])
rticks(0:0.5:1)
rticklabels({'0','0.5','1'})