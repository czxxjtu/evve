tic;
addpath('../yeal_matlab/')

cte_load_database;
cte_load_queries;

global qdescs_norm
global dbdescs_norm

qdescs_norm = cte_normalize_l2(qdescs);
dbdescs_norm = cte_normalize_l2(dbdescs);

toc;
