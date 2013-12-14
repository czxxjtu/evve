

%addpath('~/src/yael/matlab')
addpath('../yeal_matlab/')

% load_database 
load_database;
load_queries;
% load_queries

qdescs_norm = normalize_l2(qdescs);
dbdescs_norm = normalize_l2(dbdescs);

% nr = 200;

scoremat = dbdescs_norm' * qdescs_norm;

f = fopen('resfile2.dat', 'w');
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
