%% generate Fig.3: hierarchical clustering method

%cluster result based on hierarchical clustering method on example data
%use same sample points as Fig.1
clear 
angles = [90,95,-30,-90,90,0,90]; 
%critical angles like 0 and 90 degrees are deliberatly chosen to highlight
%the difficult part of circular clustering
radius = [1,1,1,0.2,0.2,0.5,0.5];
samples = [angles;radius].'; 
%%
total_cycle = 4;
samples(:,1) = mod(samples(:,1),360); 
repeat_samples = period_repeat(total_cycle,samples);
R = 0.8; 
plot_idx = 0;
Z = hierarchical_search(repeat_samples,samples,R,plot_idx);

f = figure(2);
clf
f.Position = [100 100 540*2 400];
subplot(121)
dendrogram(Z,0);
title('Tree Structure')
xlabel('sample label')
subplot(122)
for ix_sample = 1:size(samples,1)
    h=polarscatter(deg2rad(samples(ix_sample,1)),samples(ix_sample,2),'filled'); %plot in radians
    h.SizeData = 100;
    text(deg2rad(samples(ix_sample,1)),samples(ix_sample,2)-0.1,num2str(ix_sample))
    hold on
end
rlim([0 1])
%rticks([0 1])
rticklabels('')
title('Polar Coordinate')