tic;
addpath('../yeal_matlab/')

cte_load_database;
cte_load_queries;


qdescs_norm = cte_normalize_l2(qdescs);
dbdescs_norm = cte_normalize_l2(dbdescs);
save('features.mat');

toc;

scoremat = zeros(length(dbdescs_norm, qdescs_norm));

for i = 1:length(dbdescs_norm)
    db = dbdescs_norm{i};
    for j =1:length(qdescs_norm)
        q = qdescs_norm{j};
        scoremat(i,j) = calcS(q, db, 512, 1);
    end
end

f = fopen('resfile.dat', 'w');
assert(f ~= -1)
  
for qno = 1:size(qdescs, 2)
  
  fprintf(f, '%s ', qnames(qno, :));
  
  [~, ids] = sort(scoremat(:, qno), 'descend');
  
  for j=1:length(ids)
    fprintf(f, '%s ', dbnames(ids(j), :));
  end

  fprintf(f, '\n');
  
end
fclose(f)