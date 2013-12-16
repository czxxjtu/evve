function cte_dist_new(lambda, d, p)

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

largematrix  = zeros(size(bigtable, 1), size(bigtable, 2) * 2);
 for i = 1:size(bigtable, 2)
     largematrix(:, i * 2  - 1) = real(bigtable(:,i));
     largematrix(:, i * 2) = imag(bigtable(:,i));
 end

sublength = size(largematrix, 2) / p;
scoremat = zeros(d, length(dbdescs_norm), length(qdescs_norm));
table = zeros(d, 256, 256, p);
idxs = [];
 for i = 1:p
     submatrix = largematrix(:,sublength * (i -1):sublength * i);
     [idx, ctr] = kmeans(submatrix, 256);
     idxs = [idxs idx];
     for j = 1:256
         for k = 1:j
             table(:,j,k,p) = calcS_new(ctr(j), ctr(k), lambda);
         end
     end
 end
 
 for iii = 1:p
     for i = 1:length(dbdescs_norm)
         for j = 1:length(qdescs_norm)
             idxq = j;
             idxb = length(qdescs_norm) + i;
             idxmax = max(idxq, idxb); idxmin = min(idxq, idxb);
             scoremat(:, i, j) = scoremat(:, i, j) + table(:, idxmax, idxmin, iii);
         end
     end
 end
     
save(['scoremat_' num2str(lambda) '_' num2str(d) '_.mat'], 'scoremat');

f = fopen(['resfile_' num2str(lambda) num2str(d) '_.dat'], 'w');
assert(f ~= -1)
  
for qno = 1:length(qdescs_norm)
  
  fprintf(f, '%s ', qnames(qno, :));
  
  [~, ids] = sort(scoremat(:, qno), 'descend');
  
  for j=1:length(ids)
    fprintf(f, '%s ', dbnames(ids(j), :));
  end

  fprintf(f, '\n');
  
end
fclose(f)
clear scoremat ;
 end

 
 