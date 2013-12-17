function save_fft_vlad(d)

global qdescs_norm;
global dbdescs_norm;
global dbnames;
global qnames;

longest = 0;
for i = 1:length(dbdescs_norm)
    longest = max(longest, size(dbdescs_norm{i}, 2));
end
for i = 1:length(qdescs_norm)
    longest = max(longest, size(qdescs_norm{i}, 2));
end

ll = nextpow2(longest);

bigtable = [];
for i = 1:length(qdescs_norm)
    seq = [qdescs_norm{i} zeros(512, 2^ll - size(qdescs_norm{i}, 2))];
    seqfft = fft(seq')';
    seqfft = seqfft(:, 1:d);
    bigtable = [bigtable; seqfft];
end
for i = 1:length(dbdescs_norm)
    seq = [dbdescs_norm{i} zeros(512, 2^ll - size(dbdescs_norm{i}, 2))];
    seqfft = fft(seq')';
    seqfft = seqfft(:, 1:d);
    bigtable = [bigtable; seqfft];
end
save([num2str(d), '.mat'], 'bigtable');
end