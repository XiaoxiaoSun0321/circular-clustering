function [theta_seq,r_seq] = dna_polar(dna_seq,unique_comb_list,idx_omega)
%transfer dna sequence to polar coordinates
%   extract 16 features from the dna sequence and calculate rho and theta
%   corresondingly based on formula provided in paper below
%%%%%%%%%%%%%%%%%%%%%%
% Dai, Q., Guo, X., & Li, L. (2012). 
% Sequence comparison via polar coordinates representation and curve tree. 
% Journal of theoretical biology, 292, 78-85.
%%%%%%%%%%%%%%%%%%%%%%
count_total = zeros(16,1);
for ix_seq = 1:size(dna_seq,2)-1
    idx_match = (dna_seq(ix_seq:ix_seq+1)==unique_comb_list);
    list_loc = find(sum(idx_match,2)==2);
    count_total(list_loc,1) = count_total(list_loc,1)+1;
end
%
freq_total = count_total./sum(count_total);
omega = [1,2];
r_seq = 1+omega(idx_omega).*freq_total;
theta_seq = nan(16,1);
for ix_com = 1:16
    if ix_com==1
        theta_seq(ix_com) = freq_total(1);
    else
        theta_seq(ix_com) = theta_seq(ix_com-1)+2*pi*freq_total(ix_com);
    end
end

end