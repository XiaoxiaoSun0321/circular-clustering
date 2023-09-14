%% generate Fig.1
% Figure 1 illustrates the process of transfer polar coordinate to cartesian coordinate 
% and applies both K-means and DBSCAN methods to cluster by using the cartesian coordinate  
% we assume those points are in a unit circle 
% note: this assumpation doesn't affact the illustrated process
clear
%% calculate the changes in theta (angle) and changes in rho (radius)
%7 example points were used:
%point 1: [90,1] %(angle, radius) as (theta,r)
%point 2: [95,1]
%point 3: [-30,1]
%point 4: [-90,0.2]
%point 5: [90,0.2]
%point 6: [0,0.5]
%point 7: [90,0.5]

angles = [90,95,-30,-90,90,0,90]; 
%critical angles like 0 and 90 degrees are deliberatly chosen to highlight
%the difficult part of circular clustering
radius = [1,1,1,0.2,0.2,0.5,0.5];
samples = [angles;radius]; 

figure(1)
clf
subplot(2,3,1)
for ix_sample = 1:size(samples,2)
    polarscatter(deg2rad(samples(1,ix_sample)),samples(2,ix_sample),'filled') %plot in radians
    hold on
end
rlim([0 1])
title('Polar Coordinate')

%transfor polar coordinates (theta,rho) to cartesian coordinates (x,y)
for ix_sample = 1:size(samples,2)
    [samples_x(ix_sample),samples_y(ix_sample)] = polartocart(deg2rad(samples(1,ix_sample)),samples(2,ix_sample));
end
%alternative matlab function  
%[samples_x,samples_y] = pol2cart(deg2rad(samples(1,:)),samples(2,:))
box on

subplot(2,3,3)
for ix_sample = 1:size(samples,2)
    scatter(samples_x(ix_sample),samples_y(ix_sample),'filled')
    hold on
end
box on
xlabel('X')
ylabel('Y')
xlim([-1 1])
ylim([-1 1])
title('Cartesian Coordinate')

% known K
% kmeans: K = 2 types
rng(2); % For reproducibility
K = 2;
[idx,C] = kmeans([samples_x.' samples_y.'],K);
subplot(2,3,4)
hold on
box on
gscatter(samples_x.',samples_y.',idx)
xlim([-1 1])
ylim([-1 1])
legend({'1','2'})
title('K-means: K=2')
%if want to plot the centroid
%scatter(C(1,1),C(1,2),'black','filled');    
%scatter(C(2,1),C(2,2),'black','filled');

% unknown K: density-based method
% dbscan: epsilon = 0.5, minpts = 2
subplot(2,3,5)
[idx,corepts] = dbscan([samples_x.' samples_y.'],0.5,2);
gscatter(samples_x.',samples_y.',idx)
xlim([-1 1])
ylim([-1 1])
legend({'1','2'})
title('DBSCAN: \epsilon=0.8, minpts = 2')

% unknown K: hierarchical clustering
subplot(2,3,6)
Y = pdist([samples_x.' samples_y.']);
Z = linkage(Y);
dendrogram(Z)
box on
ylabel('Distance')
title('Dendrogram')
