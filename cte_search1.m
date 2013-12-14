tic;
addpath('../yeal_matlab/')

cte_load_database;
cte_load_queries;


qdescs_norm = cte_normalize_l2(qdescs);
dbdescs_norm = cte_normalize_l2(dbdescs);
%save('features.mat', '-v7.3');

toc;