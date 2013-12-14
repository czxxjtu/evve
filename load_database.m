
kws = dir('annots/*.dat');

dbnames = []
dbdescs = []

d = 512;

for i=1:length(kws)
  % for i=1:1
  kw = kws(i).name(1:end-4);
  v = load_descs(kw, 'database', d);
  nv = length(v);
  di = zeros(d, nv);
  for j = 1:length(v)
    descs = v(j).descs;
    assert(size(descs, 2) > 0);
    assert(all(isfinite(descs(:))));
    
    % compute mean descriptor (MMV)
    
    descs = sum(descs, 2) / size(descs, 2);
    di(:, j) = descs;
    dbnames = [dbnames ; v(j).name];
  end
  dbdescs = [dbdescs di];
  
end
