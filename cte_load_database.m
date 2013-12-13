kws = dir('annots/*.dat');

dbnames = [];
dbdescs = {};

d = 512;

for i=1:length(kws)
  % for i=1:1
  kw = kws(i).name(1:end-4);
  v = load_descs(kw, 'database', d);
  for j = 1:length(v)
    descs = v(j).descs;
    assert(size(descs, 2) > 0);
    assert(all(isfinite(descs(:))));
    
    %store name
    dbnames = [dbnames ; v(j).name];
    %store description
    dbdescs = [dbdescs v(j).descs];
  end
  
  
end