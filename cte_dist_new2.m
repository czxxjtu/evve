function cte_dist_new2(lambda, d, p, matfile)

load matlab.mat;
load(matfile);

dbdescs_norm_l = 2375;
qdescs_norm_l = 620;

largematrix  = zeros(size(bigtable, 1), size(bigtable, 2) * 2);
 for i = 1:size(bigtable, 2)
     largematrix(:, i * 2  - 1) = real(bigtable(:,i));
     largematrix(:, i * 2) = imag(bigtable(:,i));
 end

sublength = size(largematrix, 2) / p;
scoremat = zeros(d, dbdescs_norm_l, qdescs_norm_l);
table = zeros(d, 256, 256, p);
idxs = [];
 for i = 1:p
     submatrix = largematrix(:,sublength * (i -1) + 1:sublength * i);
     tic;
     [idx, ctr] = kmeans(submatrix, 256);
     toc;
     idxs = [idxs idx];
     for j = 1:256
         for k = 1:j
             table(:,j,k,p) = calcS_new(ctr(j,:), ctr(k,:), lambda);
         end
     end
 end
 
 for iii = 1:p
     for i = 1:dbdescs_norm_l
         for j = 1:qdescs_norm_l
             idxq = idxs(j);
             idxb = idxs(qdescs_norm_l + i);
             idxmax = max(idxq, idxb); idxmin = min(idxq, idxb);
             scoremat(:, i, j) = scoremat(:, i, j) + table(:, idxmax, idxmin, iii);
         end
     end
 end
     
save(['scoremat_' num2str(lambda) '_' num2str(d) '_.mat'], 'scoremat');

f = fopen(['resfile_' num2str(lambda) num2str(d) '_.dat'], 'w');
assert(f ~= -1)
  
for qno = 1:qdescs_norm_l
  
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

 
 