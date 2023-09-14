clear
%% 16 types
X = 'ACGT';
Y = 'ACGT';
comb_list = nchoosek([X Y],2); %more than 4*4, has repetition
unique_comb_list = unique(comb_list,'rows');
%% 
Human_seq = 'ATGGTGCACCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTGAACGTGGATGAAGTTGGTGGTGAGGCCCTGGGCAG';
Chimp_seq =  'ATGGTGCACCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTGAACGTGGATGAAGTTGGTGGTGAGGGCCCTGGGCAGGTTGGTATCAAGG';
Mouse_seq = 'ATGGTGCACCTGACTGATGCTGAGAAGGCTGCTGTCTCTTGCCTGTGGGGAAAGGTGAACTCCGATGAAGTTGGTGGTGAGGCCCTGGGCAG';
%%
figure(2)
clf
idx_omega = 1;
[theta_seq,r_seq] = dna_polar(Human_seq,unique_comb_list,idx_omega);
subplot(241)
polarscatter(theta_seq,r_seq,'filled')
title('Human')
rlim([0 1.3])
[theta_seq,r_seq] = dna_polar(Chimp_seq,unique_comb_list,idx_omega);
subplot(242)
polarscatter(theta_seq,r_seq,'filled')
title('Chimp')
rlim([0 1.3])
[theta_seq,r_seq] = dna_polar(Mouse_seq,unique_comb_list,idx_omega);
subplot(243)
polarscatter(theta_seq,r_seq,'filled')
title('Mouse')
rlim([0 1.3])