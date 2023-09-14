%% generate Fig.2
% Figure 2 

clear
angles = [90,95,-30,-90,90,0,90]; 
%critical angles like 0 and 90 degrees are deliberatly chosen to highlight
%the difficult part of circular clustering
radius = [1,1,1,0.2,0.2,0.5,0.5];
samples = [angles;radius]; 

r = 1; %indicate it's within a unit circle
R = 1; %control the weights

f = figure(2);
clf
f.Position = [100 100 540*2 400];
subplot(121)
cylinder_plot(r,R)
%axis equal
hold on
[cy_x,cy_y,cy_z] = pol2cart(deg2rad(samples(1,:)),R*ones(1,7),samples(2,:));

%make the color align
for ix_sample = 1:size(samples,2)
    h=scatter3(cy_x(ix_sample),cy_y(ix_sample),cy_z(ix_sample),'filled');
    h.SizeData = 100;
    hold on
end 
%view angle
view([20.6 27]);
xlim([-R R])
ylim([-R R])
xticks(linspace(-R,R,5))
yticks(linspace(-R,R,5))
zticks(0:0.5:r)

%unwrap the lateral surface
subplot(122)
samples = samples.';
samples(:,1) = mod(samples(:,1),360);
[new_x,new_y] = angle_projection(R*2*pi,samples);
for ix_sample = 1:size(new_x,1)
    h=scatter(new_x(ix_sample),new_y(ix_sample),'filled');
    h.SizeData = 100;
    hold on
end
box on
xlim([0 R*2*pi])
xticks(0:pi/2:R*2*pi)
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
%xticklabels({'0','\pi','2\pi','3\pi','4\pi'}) %R=2
ylim([0 1])
ylabel('Y=Z=r')
xlabel(strcat('f(\theta)=\theta R, \theta(rad), R=',num2str(R)))