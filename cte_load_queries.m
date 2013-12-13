kws = dir('annots/*.dat');

qnames = [];
qdescs = {};

d = 512;

for i=1:length(kws)
  kw = kws(i).name(1:end-4);
  v = load_descs(kw, 'query', d);
  nv = length(v);
  di = zeros(d, nv);
  for j = 1:length(v)
    descs = v(j).descs;
    descs = sum(descs, 2) / size(descs, 2);
    di(:, j) = descs;
    qnames = [qnames ; v(j).name];
    qdescs = [qdescs v(j).descs];
  end
end
