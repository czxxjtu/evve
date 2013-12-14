

function descs = normalize_l2(descs)
  
  norms = 1 ./ sqrt(sum(descs.^2));
  norms(find(~isfinite(norms))) = 0; 
  descs = bsxfun(@times, descs, norms);
  
