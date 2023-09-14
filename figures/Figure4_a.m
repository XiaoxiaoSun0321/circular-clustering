%% generate the hierarchical clustering result of Fig.4

%use randomly generated sample points has 2 default class
clear 
%class#1
%generate 25 points centered at (0,0.9) with 0.1 as radius
n = 25;
rng(1)
theta = rand(n,1)*20-10;
r = 0.9+0.2*rand(n,1)-0.1;
%plot the sample points
f = figure(1);
clf
f.Position = [100 100 540*2 400];
subplot(131)
polarscatter(deg2rad(theta),r,180,'blue',"filled")
hold on
rlim([0 1])
%save the generated sample points
temp_samples(:,:,1) = [theta,r];

%class#2
%generate 25 points centered at (90,0.3) with 0.2 as radius
n = 25;
rng(2)
theta = rand(n,1)*90;
r = 0.3+0.4*rand(n,1)-0.2;
polarscatter(deg2rad(theta),r,180,'red',"filled")
temp_samples(:,:,2) = [theta,r];
title('Sample points: 50 points, 2 classes')

%reformat the variable
samples = squeeze(temp_samples(:,:,1));
default_class = 2;
for ix = 2:default_class %total default class
    samples = cat(1,samples,squeeze(temp_samples(:,:,ix)));
end

%plot the samples without its class info
%polarscatter(deg2rad(samples(:,1)),samples(:,2),180,[0.5,0.5,0.5],"filled")
%% balanced weights on phase, greater R
total_cycle = 30;
samples(:,1) = mod(samples(:,1),360); 
repeat_samples = period_repeat(total_cycle,samples);
number_class_k = 2;
R = 0.8; 
R_input = R*2*pi; %meet the function input
[cycle_x,cycle_y] = angle_projection(R_input,repeat_samples);
[idx_K] = kmeans([cycle_x,cycle_y],number_class_k*(total_cycle+1));
%K-means clustering search
plot_idx = 0; %do the plot separately here
[plot_class,legendInfo]= kmeans_search(total_cycle,samples,idx_K,repeat_samples,number_class_k,plot_idx);
%% 
subplot(132)
for ix_class = 1:size(plot_class,2)
    polarscatter(deg2rad(plot_class(ix_class).points_in_class(:,1)),plot_class(ix_class).points_in_class(:,2),"filled")
    hold on
end
legend(legendInfo,'Location','southwest')
title('Balanced R: K-means')
rlim([0 1])
rticks(0:0.5:1)
rticklabels({'0','0.5','1'})
%% more weights on phase, greater R
total_cycle = 50;
repeat_samples = period_repeat(total_cycle,samples);
number_class_k = 2;
R = 1.5; 
R_input = R*2*pi; %meet the angle_projection function input
[cycle_x,cycle_y] = angle_projection(R_input,repeat_samples);
[idx_K] = kmeans([cycle_x,cycle_y],number_class_k*(total_cycle+1));
%K-means clustering search
plot_idx = 0; %do the plot separately here
[plot_class,legendInfo]= kmeans_search(total_cycle,samples,idx_K,repeat_samples,number_class_k,plot_idx);
%%
subplot(133)
for ix_class = 1:size(plot_class,2)
    polarscatter(deg2rad(plot_class(ix_class).points_in_class(:,1)),plot_class(ix_class).points_in_class(:,2),"filled")
    hold on
end
legend(legendInfo,'Location','southwest')
title('Greater R: K-means')
rlim([0 1])
rticks(0:0.5:1)
rticklabels({'0','0.5','1'})

