function [plot_class,legendInfo] = kmeans_search(repeat_cycle,samples,idx,repeat_samples,number_class_k,plot_idx)
%generate the final cluster result based on kmeans method
%%%%%%%%%%%%%
%   inputs -- repeat_cycle:the number of period repeatition
%             idx: clustering result from kmeans
%             repeat_samples: orginal samples with points in the repeated cycle 
%             plot_idx: generate plot (1) or not (0).
%%%%%%%%%%%%%
%   outputs -- plot_class: final cluster output that can be directly used
%              legendInfo: the legend for corresponding result
%%%%%%%%%%%%%


%use the classification exists in the middle cycle
used_period = repeat_cycle/2+1;
%get the points range in degrees
period_angle_range = 360*[used_period-1,used_period];
%points within this range
point_list = and(repeat_samples(:,1)<=period_angle_range(2),repeat_samples(:,1)>=period_angle_range(1));
%get the representaion of the points within range if needed
%resize_points = repeat_samples(point_list,:);

%the possible class exists for those points within range
possible_class = unique(idx(point_list));

%get the point index of both middle cycle used and the original(1st) cycle
clear sample_number
for ix_class = 1:size(possible_class,1)
    sample_number(ix_class).number_id = find(idx==possible_class(ix_class));
    %project it back to the original number id: 1 to total sample size 
    sample_number(ix_class).org_number_id = mod(sample_number(ix_class).number_id,size(samples,1));
end

%the combination of possible class
possible_combine = nchoosek((1:1:size(possible_class,1)),number_class_k); %possible class, actual class

%get the correct class combination
%if the union set of points in different class equals to univerisal set
%then the combination of class is the classification it obtained. 
clear correct_combine
for ix_combine = 1:size(possible_combine,1)
    temp_points = sample_number(possible_combine(ix_combine,1)).org_number_id;
    for ix_class = 2:size(possible_combine,2)
        temp_points = cat(1,temp_points,sample_number(possible_combine(ix_combine,ix_class)).org_number_id);
    end
    [~, uniqueIdx] = unique(temp_points);
    dupeIdx = ismember( temp_points, temp_points( setdiff( 1:numel(temp_points), uniqueIdx ) ) );
    if and(length(uniqueIdx)==size(samples,1),sum(dupeIdx)==0) %complete and no duplicates
       correct_combine(ix_combine) = 1; %the class should be used
    else
       correct_combine(ix_combine) = 0; %the class shouldn't be used
    end
end

%display the final combination if needed
%disp(correct_combine)

if sum(correct_combine)<=0
    disp('No correct clusters can be located, please change the repeat cycle, double check parameter R, or change the rng.')
    plot_class = struct();
    legendInfo = cell(1);
    return
else
    disp('Correct clusters can be located.') 
end

%plot the cluster result and generate the output
if plot_idx==1
    figure()
    clf
    for ix_class = 1:size(possible_combine,2)
        points_in_class = sample_number(possible_combine(correct_combine==1,ix_class)).number_id;
        %map back to the original points
        plot_class(ix_class).points_in_class = mod(repeat_samples(points_in_class,:),360);
        %plot_class contains the final cluster output
        polarscatter(deg2rad(plot_class(ix_class).points_in_class(:,1)),plot_class(ix_class).points_in_class(:,2),"filled")
        hold on
        legendInfo{ix_class} = ['class' num2str(ix_class)]; 
    end
    legend(legendInfo)
else
    for ix_class = 1:size(possible_combine,2)
        points_in_class = sample_number(possible_combine(correct_combine==1,ix_class)).number_id;
        %map back to the original points
        plot_class(ix_class).points_in_class = mod(repeat_samples(points_in_class,:),360);
        legendInfo{ix_class} = ['class' num2str(ix_class)]; 
    end
end
end