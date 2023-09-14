function [plot_class,legendInfo] = dbscan_search(total_cycle,samples,idx_bd,plot_idx)
%generate the final cluster result based on dbscan method
%%%%%%%%%%%%%
%   inputs -- total_cycle:the number of period repeatition
%             samples: orginal samples
%             idx_bd: clustering result from kmeans
%             plot_idx: generate plot (1) or not (0).
%%%%%%%%%%%%%
%   outputs -- plot_class: final cluster output that can be directly used
%              legendInfo: the legend for corresponding result
%%%%%%%%%%%%%

%find the correct combination based on
%how many classes have been identified based on DBSCAN
total_class = unique(idx_bd);

%which sample points are identified as the same class
clear sample_number
for ix_class = 1:size(total_class,1)
    sample_number(ix_class).number_id = find(idx_bd==total_class(ix_class));
    %project it back to the original number id: 1 to total sample size 
    sample_number(ix_class).org_number_id = mod(sample_number(ix_class).number_id,size(samples,1));
end

% find the similarity between identified class
sample_number_table = struct2table(sample_number);
[outArray, ~, newInd] = uniquearray(sample_number_table.org_number_id);

% choose the accurate classification result (based on how often this cluster has been identified)
total_cluster_type = unique(newInd);
%threshold for at least how often this cluster has been identified
threshold_repeat = 0.5*total_cycle; %can be higher, conceptually should be around the total_cycle 
% (e.g., >=total_cycle-1 will be sufficient enough)  

ix_possible_cluster = 1;
for ix_cluster_type = 1:size(total_cluster_type,1)
    if sum(newInd==ix_cluster_type)>threshold_repeat
        possible_class(ix_possible_cluster) = ix_cluster_type;
        ix_possible_cluster = ix_possible_cluster+1;
    end
end

% compose the final clustering output and find the outliers
class_subset = cell2mat(outArray(possible_class,:));
if sum(class_subset==0)>0
    %correct sample point referencing
    class_subset(class_subset==0) = size(samples,1); %change index 0 to the number of sample size
end
all_samples_list = 1:1:size(samples,1);
idx_subset = ismember(all_samples_list,class_subset);

% DBSCAN function also identifies some outliers in the data. 
% Find the number of points that dbscan identifies as outliers.
outlier_class = all_samples_list(~idx_subset); %unclassed group is outlier

%plot the cluster result and generate the output

if plot_idx == 1
    figure()
    clf
    for ix_class = 1:size(possible_class,2)
        temp_plot_class = outArray{possible_class(ix_class)};
        if sum(temp_plot_class==0)>0
            %correct sample point referencing
            temp_plot_class(temp_plot_class==0) = size(samples,1); %change index 0 to the number of sample size
        end
        plot_class(ix_class).points_in_class = samples(temp_plot_class,:);  
        legendInfo{ix_class} = ['class' num2str(ix_class)];
        polarscatter(deg2rad(samples(temp_plot_class,1)),samples(temp_plot_class,2),180,'filled');
        rlim([0 1])
        hold on
    end
    if size(outlier_class,2)>0 %has outliers
        polarscatter(deg2rad(samples(outlier_class,1)),samples(outlier_class,2),180,'filled');
        rlim([0 1])
        plot_class(ix_class+1).points_in_class = samples(outlier_class,:);
        legendInfo{ix_class+1} = 'outliers';
    end
    legend(legendInfo)
else
    for ix_class = 1:size(possible_class,2)
        temp_plot_class = outArray{possible_class(ix_class)};
        if sum(temp_plot_class==0)>0
            %correct sample point referencing
            temp_plot_class(temp_plot_class==0) = size(samples,1); %change index 0 to the number of sample size
        end
        plot_class(ix_class).points_in_class = samples(temp_plot_class,:);  
        legendInfo{ix_class} = ['class' num2str(ix_class)];
    end
    if size(outlier_class,2)>0 %has outliers
        plot_class(ix_class+1).points_in_class = samples(outlier_class,:);
        legendInfo{ix_class+1} = 'outliers';
    end
end
end