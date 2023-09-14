function repeat_samples = period_repeat(total_cycle,samples)
%This function do the repeatition based on the given repeatition numbers.
%The input sample points should between 0 and 2*pi.
%%%%%%%%%%%%%
%   inputs -- total_cycle: the number of period repeatition, final cycle number 
%             is 1+total_cycle
%             samples: total sample points maps into [0,360)
%%%%%%%%%%%%%
%   outputs -- repeat_samples: orginal samples with points in the repeated cycle
%%%%%%%%%%%%%


repeat_samples = samples;
for ix_cycle = 1:total_cycle
    cycle_samples = samples(:,1)+(ix_cycle)*360;
    temp_samples = [cycle_samples,samples(:,2)];
    repeat_samples = cat(1,repeat_samples,temp_samples);
end

end