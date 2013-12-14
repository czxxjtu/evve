function vids = load_descs(kw, split, d, nmax)
  
  if nargin < 4
    nmax = 100000;
    if nargin < 3
      d = 1024;
    end
  end
  
  annotname = sprintf('annots/%s.dat', kw)
  f = fopen(annotname, 'r');
  if f == -1 
    error('cannot open annot file')
  end
  
  vids = struct();
  i = 1;
  while 1
    line = fgets(f);
    if line(1) == -1
      break
    end
    spc = find(line == ' ');
    split_in = line(spc(2) + 1 : end - 1);
    if ~strcmp(split_in, split)
      continue
    end
    name = line(1:spc(1) - 1);
    gt = str2num(line(spc(1) + 1 : spc(2) - 1));
    vids(i).name = name;
    vids(i).gt = gt;
    descfilename = sprintf('descs/%s/%s.fvecs', kw, name)
    
    descs = fvecs_read(descfilename);
    descs(find(~isfinite(descs))) = 0;
    % strip down to d dimensions
    descs = descs(1:d, :);
    
    % L2 normalize
    norms = 1 ./ sqrt(sum(descs.^2));
    norms(find(~isfinite(norms))) = 0; 
    descs = bsxfun(@times, descs, norms);
    
    
    vids(i).descs = descs;
    
    if i >= nmax
      break
    end
    
    i = i + 1;
  end
  fclose(f);
 
