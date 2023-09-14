%% generate Fig.3: K-means and DBSCAN method (another parameters)

%same sample points as Fig.1
clear 

angles = [90,95,-30,-90,90,0,90]; 
%critical angles like 0 and 90 degrees are deliberatly chosen to highlight
%the difficult part of circular clustering
radius = [1,1,1,0.2,0.2,0.5,0.5];
samples = [angles;radius].'; 

%map to [0 360)
samples(:,1) = mod(samples(:,1),360);

%period repeation
total_cycle = 4; %final cycle is 1+4 = 5
repeat_samples = samples;
for ix_cycle = 1:total_cycle
    cycle_samples = samples(:,1)+(ix_cycle)*360;
    temp_samples = [cycle_samples,samples(:,2)];
    repeat_samples = cat(1,repeat_samples,temp_samples);
end

f = figure(1);
clf
f.Position = [100 100 540 600];
%K-means
rng(1)
R = 1;
[cycle_x,cycle_y] = angle_projection(R*2*pi,repeat_samples);
[idx_K] = kmeans([cycle_x,cycle_y],2*(total_cycle+1));
sample_size = size(samples,1);
rng(6)
point_color = rand(sample_size,3);
subplot(3,2,[1 2])
h=gscatter(cycle_x,cycle_y,idx_K,point_color);
ylabel('r');
xlabel('f(\theta)')
xlim([0 (total_cycle+1)*R*2*pi])
ylim([0 1])
xticks(0:R*2*pi:(total_cycle+1)*R*2*pi)
xticklabels({'0','2\pi','4\pi','6\pi','8\pi','10\pi'})
xline(R*2*pi:R*2*pi:total_cycle*R*2*pi,'k--','LineWidth',1)
title('K-means')
legend(h,{'c1','c2','c3','c4','c5','c6','c7','c8','c9','c10'},'Location','bestoutside')

%DBSCAN
subplot(3,2,[3 4])
[idx_bd] = dbscan([cycle_x,cycle_y],1.5,2);
h=gscatter(cycle_x,cycle_y,idx_bd,point_color);
ylabel('r');
xlabel('f(\theta)')
xlim([0 (total_cycle+1)*R*2*pi])
ylim([0 1])
xticks(0:R*2*pi:(total_cycle+1)*R*2*pi)
xticklabels({'0','2\pi','4\pi','6\pi','8\pi','10\pi'})
xline(R*2*pi:R*2*pi:total_cycle*R*2*pi,'k--','LineWidth',1)
title('DBSCAN')
legend(h,{'outliers','c1','c2','c3','c4','c5','c6','c7','c8','c9','c10'},'Location','bestoutside')

%K-means clustering search
plot_idx = 0; %do the plot separately here
subplot(3,2,5)
[plot_class,legendInfo]= kmeans_search(total_cycle,samples,idx_K,repeat_samples,2,plot_idx);
for ix_class = 1:size(plot_class,2)
    polarscatter(deg2rad(plot_class(ix_class).points_in_class(:,1)),plot_class(ix_class).points_in_class(:,2),"filled")
    hold on
end
legend(legendInfo,'Location','best')
title('K-means')
rlim([0 1])
rticks(0:0.5:1)
rticklabels({'0','0.5','1'})

%DBSCAN clustering search
plot_idx = 0; %do the plot separately here
subplot(3,2,6)
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

