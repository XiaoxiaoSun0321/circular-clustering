%% generate Fig.6
clear
%% 16 types of combinations
X = 'ACGT';
Y = 'ACGT';
comb_list = nchoosek([X Y],2); %more than 4*4, has repetition
unique_comb_list = unique(comb_list,'rows');
%% dna sequences
Human_seq = 'ATGGTGCACCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTGAACGTGGATGAAGTTGGTGGTGAGGCCCTGGGCAG';
Chimp_seq =  'ATGGTGCACCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTGAACGTGGATGAAGTTGGTGGTGAGGGCCCTGGGCAGGTTGGTATCAAGG';
Mouse_seq = 'ATGGTGCACCTGACTGATGCTGAGAAGGCTGCTGTCTCTTGCCTGTGGGGAAAGGTGAACTCCGATGAAGTTGGTGGTGAGGCCCTGGGCAG';
%% Human
idx_omega = 1; %or idx_omega = 2
[theta_seq,r_seq] = dna_polar(Human_seq,unique_comb_list,idx_omega);
samples = [rad2deg(theta_seq),r_seq];
total_cycle = 4;
samples(:,1) = mod(samples(:,1),360); 
repeat_samples = period_repeat(total_cycle,samples);
R = 0.8; 
plot_idx = 0;
[Z,~] = hierarchical_search(repeat_samples,samples,R,plot_idx);

f = figure(6);
clf
f.Position = [100 100 540*3 400*2];
subplot(234)
dendrogram(Z,0);
box on
ylim([0 1])

title('Tree Structure')
xlabel('sample label')
subplot(231)
for ix_sample = 1:size(samples,1)
    h=polarscatter(deg2rad(samples(ix_sample,1)),samples(ix_sample,2),'filled'); %plot in radians
    h.SizeData = 100;
    text(deg2rad(samples(ix_sample,1)),samples(ix_sample,2)-0.1,num2str(ix_sample))
    hold on
end
rlim([0 1.3])
%rticks([0 1])
rticklabels('')
title('Human')
%% Chimpanzee
idx_omega = 1; %or idx_omega = 2
[theta_seq,r_seq] = dna_polar(Chimp_seq,unique_comb_list,idx_omega);
samples = [rad2deg(theta_seq),r_seq];
total_cycle = 4;
samples(:,1) = mod(samples(:,1),360); 
repeat_samples = period_repeat(total_cycle,samples);
R = 0.8; 
plot_idx = 0;
[Z,~] = hierarchical_search(repeat_samples,samples,R,plot_idx);

subplot(235)
dendrogram(Z,0);
box on
ylim([0 1])

title('Tree Structure')
xlabel('sample label')
subplot(232)
for ix_sample = 1:size(samples,1)
    h=polarscatter(deg2rad(samples(ix_sample,1)),samples(ix_sample,2),'filled'); %plot in radians
    h.SizeData = 100;
    text(deg2rad(samples(ix_sample,1)),samples(ix_sample,2)-0.1,num2str(ix_sample))
    hold on
end
rlim([0 1.3])
%rticks([0 1])
rticklabels('')
title('Chimpanzee')
%% Mouse
idx_omega = 1; %or idx_omega = 2
[theta_seq,r_seq] = dna_polar(Mouse_seq,unique_comb_list,idx_omega);
samples = [rad2deg(theta_seq),r_seq];
total_cycle = 4;
samples(:,1) = mod(samples(:,1),360); 
repeat_samples = period_repeat(total_cycle,samples);
R = 0.8; 
plot_idx = 0;
[Z,~] = hierarchical_search(repeat_samples,samples,R,plot_idx);

subplot(236)
dendrogram(Z,0);
box on
ylim([0 1])

title('Tree Structure')
xlabel('sample label')
subplot(233)
for ix_sample = 1:size(samples,1)
    h=polarscatter(deg2rad(samples(ix_sample,1)),samples(ix_sample,2),'filled'); %plot in radians
    h.SizeData = 100;
    text(deg2rad(samples(ix_sample,1)),samples(ix_sample,2)-0.1,num2str(ix_sample))
    hold on
end
rlim([0 1.3])
%rticks([0 1])
rticklabels('')
title('Mouse')