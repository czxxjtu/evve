kws = dir('annots/*.dat');

global qnames
global qdescs

qnames = [];
qdescs = {};

d = 1024;

for i=1:length(kws)
  % for i=1:1
  kw = kws(i).name(1:end-4);
  v = load_descs(kw, 'query', d);
  for j = 1:length(v)
    descs = v(j).descs;
    assert(size(descs, 2) > 0);
    assert(all(isfinite(descs(:))));
    
    %store name
    qnames = [qnames ; v(j).name];
    %store description
    qdescs = [qdescs v(j).descs];
  end
end
