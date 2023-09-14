function [x,y] = polartocart(theta,r)
% polar coordinates (r,theta) to cartesian coordinates (x,y)
%x = r*cos(theta)
%y = r*sin(theta)
% note: it is only used for one coordinate input case
x = r*cos(theta);
y = r*sin(theta);
end