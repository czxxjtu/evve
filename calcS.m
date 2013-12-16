 function [ s ] = calcS(q, b, lambda, d)
 %p and b are feature matrice
 %d is the dimension, 512 in this config

 lQ = nextpow2(size(q,2));
 lB = nextpow2(size(b,2));
 ll = 2^max(lQ,lB);
 q = [q zeros(size(q,1), ll-size(q,2))];
 b = [b zeros(size(b,1), ll-size(b,2))];
 
 Q = fft(q')';
 Q = Q(1:d, :);
 cQ = conj(Q);
 B = fft(b')';
 B = B(1:d,:);
 
 he = 0; %sum, in fact
  
 for i = 1:d    
     numer = cQ(i,:).*B(i,:);
     denom = cQ(i,:).*Q(i,:);
     he = he + numer ./ (denom + lambda);
end
s = ifft(he);
