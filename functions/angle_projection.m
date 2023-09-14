function [project_x,project_y] = angle_projection(threshold,samples)
%
% project angle with greater weight (diffientiate the opposite direction)
% make sure the 180 degree difference is penalized the most 
% should be greater than the 2*radius (beta*180 degree>2*1) beta> = 1/90
%%%%%%%%%%%%%
% input -- threshold: minimal threshold = 4 (where 180 is 2*radius) 
%          samples: polar coordinate points: (theta,r), theta is degree not rad
%%%%%%%%%%%%%
% output -- project_x: x-axis of the projected sample point
%           project_y: y-axis of the projected sample point
%%%%%%%%%%%%%
% note: samples should be expressed within [0 360) period
% include it outside the function
% samples(:,1) = mod(samples(:,1),360);

project_x = threshold/360*samples(:,1); 
project_y = samples(:,2);
end