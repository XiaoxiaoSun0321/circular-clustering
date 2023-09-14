function [Z,Y] = hierarchical_search(repeat_samples,samples,R,plot_idx)
%generate the final cluster result based on hierarchical method
%%%%%%%%%%%%%
%   inputs -- repeat_samples: orginal samples with points in the repeated cycle
%             samples: orginal samples
%             R: parameter R
%             plot_idx: generate plot (1) or not (0).
%%%%%%%%%%%%%
%   outputs -- Z: matrix Z that encodes a tree containing hierarchical clusters of the rows of the input data matrix.
%           -- Y: Pairwise distance between pairs of observations
%%%%%%%%%%%%%
%%
R_input = R*2*pi; %meet the angle_projection function input
[cycle_x,cycle_y] = angle_projection(R_input,repeat_samples);
Y = pdist([cycle_x cycle_y]);

%
%sample point pair combination
point_combine_list_org = nchoosek((1:1:size(samples,1)),2);
%repeat sample point pair combination
point_combine_list = nchoosek((1:1:size(repeat_samples,1)),2);
%map pairs back to the default cycle (as point_combine_list_org)
combine_list_map = mod(point_combine_list,size(samples,1));
combine_list_map(combine_list_map==0)=size(samples,1);
%put the pair and distance together
Y_combined = [combine_list_map Y.'];

%only keep the minimal distance of each pair
for ix_pair = 1:size(point_combine_list_org,1)
    Y_combined_unique(ix_pair,:) = [point_combine_list_org(ix_pair,:) min(Y_combined(and(Y_combined(:,1)==point_combine_list_org(ix_pair,1),Y_combined(:,2)==point_combine_list_org(ix_pair,2)),3))];
end
Z = linkage(Y_combined_unique(:,3).');
Y = Y_combined_unique; %correct pairwise distance 
if plot_idx == 1
    dendrogram(Z)
end