tic;
addpath('../yeal_matlab/')

cte_load_database;
cte_load_queries;


qdescs_norm = normalize_l2(qdescs);
dbdescs_norm = normalize_l2(dbdescs);

toc;

scoremat = dbdescs_norm' * qdescs_norm;

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