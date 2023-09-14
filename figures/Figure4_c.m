%% generate hierarchical clustering method of synthetic data in Fig.4

%use randomly generated sample points has 2 default class
clear 
%class#1
%generate 25 points centered at (0,0.9) with 0.1 as radius
n = 25;
rng(1)
theta = rand(n,1)*20-10;
r = 0.9+0.2*rand(n,1)-0.1;
%save the generated sample points
temp_samples(:,:,1) = [theta,r];

%class#2
%generate 25 points centered at (90,0.3) with 0.2 as radius
n = 25;
rng(2)
theta = rand(n,1)*90;
r = 0.3+0.4*rand(n,1)-0.2;
temp_samples(:,:,2) = [theta,r];

%reformat the variable
samples = squeeze(temp_samples(:,:,1));
default_class = 2;
for ix = 2:default_class %total default class
    samples = cat(1,samples,squeeze(temp_samples(:,:,ix)));
end

%plot the samples without its class info
%polarscatter(deg2rad(samples(:,1)),samples(:,2),180,[0.5,0.5,0.5],"filled")
%%
total_cycle = 4;
samples(:,1) = mod(samples(:,1),360); 
repeat_samples = period_repeat(total_cycle,samples);
R = 0.8; 
plot_idx = 0;
Z = hierarchical_search(repeat_samples,samples,R,plot_idx);

f = figure(1);
clf
f.Position = [100 100 540*2 400*2];
subplot(221)
dendrogram(Z,0);
title('Tree Structure')
xlabel('sample label')
subplot(222)
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
%%
%use randomly generated sample points has 5 default class
clear 
%class#1
%generate 10 points centered at (0,0.9) with 0.1 as radius
n = 10;
rng(1)
theta = rand(n,1)*20-10;
r = 0.9+0.2*rand(n,1)-0.1;
%save the generated sample points
temp_samples(:,:,1) = [theta,r];

%class#2
%generate 10 points centered at (90,0.3) with 0.2 as radius
n = 10;
rng(2)
theta = rand(n,1)*90;
r = 0.3+0.4*rand(n,1)-0.2;
temp_samples(:,:,2) = [theta,r];

%class#3
%generate 10 points centered at (90,0.3) with 0.2 as radius
n = 10;
rng(2)
theta = rand(n,1)*90;
r = 0.3+0.4*rand(n,1)-0.2;
temp_samples(:,:,3) = [theta+180,r];

%class#4
n = 10;
rng(4)
theta = 270+(rand(n,1)-0.5)*30;
r = 0.6+0.4*rand(n,1)-0.2;
temp_samples(:,:,4) = [theta,r];

%class#5
n = 10;
rng(5)
theta = 120+(rand(n,1)-0.5)*20;
r = 0.5+0.4*rand(n,1)-0.2;
temp_samples(:,:,5) = [theta,r];
%reformat the variable
samples = squeeze(temp_samples(:,:,1));
default_class = 5;
for ix = 2:default_class %total_class
    samples = cat(1,samples,squeeze(temp_samples(:,:,ix)));
end

%plot the samples without its class info
%polarscatter(deg2rad(samples(:,1)),samples(:,2),180,[0.5,0.5,0.5],"filled")
%%
total_cycle = 4;
samples(:,1) = mod(samples(:,1),360); 
repeat_samples = period_repeat(total_cycle,samples);
R = 0.8; 
plot_idx = 0;
Z = hierarchical_search(repeat_samples,samples,R,plot_idx);

subplot(223)
dendrogram(Z,0);
title('Tree Structure')
xlabel('sample label')
subplot(224)
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