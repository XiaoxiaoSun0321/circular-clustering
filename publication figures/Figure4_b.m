%% generate Fig.4b

%use randomly generated sample points has 5 default class
clear 
%class#1
%generate 10 points centered at (0,0.9) with 0.1 as radius
n = 10;
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
%generate 10 points centered at (90,0.3) with 0.2 as radius
n = 10;
rng(2)
theta = rand(n,1)*90;
r = 0.3+0.4*rand(n,1)-0.2;
polarscatter(deg2rad(theta),r,180,'red',"filled")
temp_samples(:,:,2) = [theta,r];

%class#3
%generate 10 points centered at (90,0.3) with 0.2 as radius
n = 10;
rng(2)
theta = rand(n,1)*90;
r = 0.3+0.4*rand(n,1)-0.2;
polarscatter(deg2rad(theta)+pi,r,180,'green',"filled")
temp_samples(:,:,3) = [theta+180,r];

%class#4
n = 10;
rng(4)
theta = 270+(rand(n,1)-0.5)*30;
r = 0.6+0.4*rand(n,1)-0.2;
polarscatter(deg2rad(theta),r,180,'black',"filled")
temp_samples(:,:,4) = [theta,r];

%class#5
n = 10;
rng(5)
theta = 120+(rand(n,1)-0.5)*20;
r = 0.5+0.4*rand(n,1)-0.2;
polarscatter(deg2rad(theta),r,180,'magenta',"filled")
temp_samples(:,:,5) = [theta,r];
title('Sample points: 50 points, 5 classes')
%reformat the variable
samples = squeeze(temp_samples(:,:,1));
default_class = 5;
for ix = 2:default_class %total_class
    samples = cat(1,samples,squeeze(temp_samples(:,:,ix)));
end

%plot the samples without its class info
%polarscatter(deg2rad(samples(:,1)),samples(:,2),180,[0.5,0.5,0.5],"filled")
%%
total_cycle = 300;
samples(:,1) = mod(samples(:,1),360); 
repeat_samples = period_repeat(total_cycle,samples);
number_class_k = 5;
R = 0.6; 
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
legend(legendInfo,'Location','best')
title('K-means')
rlim([0 1])
rticks(0:0.5:1)
rticklabels({'0','0.5','1'})
%%
[idx_bd] = dbscan([cycle_x,cycle_y],0.3,3);
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