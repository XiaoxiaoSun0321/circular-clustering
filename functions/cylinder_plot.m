function cylinder_plot(r,R)
% plot cylinder that we used to map the polar coordinates
%%%%%%%%%%%%%
% inputs: r = the height of the cylinder which equals to the radius of polar coordinates system (e.g., in unit circle, r = 1)
%         R = the radius of the base circle which adjusts the weights the importance of angles and radius  
%%%%%%%%%%%%%

% theta of base circle
theta = linspace(0,2*pi); 

% height of cylinder (z-axis)
z = linspace(0,r); 

% Create a meshgrid from theta and z:
[TH,Z] = meshgrid(theta,z);

% function R_base(TH,Z):
% R_base represents the surface
% For cylinder it would be simply 
R_base = R*ones(size(Z)); %R determines the size of base circle (radius of the base circle) 

%Convert cylindrical coordinates to cartesian:
[x,y,z] = pol2cart(TH,R_base,Z);

%Plot the result using surf, mesh or any other functions:
mesh(x,y,z,'EdgeColor',[0 0 0],'FaceAlpha',0.1); %default with black color
box on
xlabel('X')
ylabel('Y')
zlabel('Z')
end