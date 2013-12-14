 function [ s ] = calcS(q, b, lambda, d)
 %p and b are feature matrice
 %d is the dimension, 512 in this config

 for i = 1:d
     Q = fft(q(i,:));
     B = fft(b(i,:));
     lQ = nextpow2(length(Q)); lB = nextpow2(length(B));
     ll = 2^max(lQ,lB);
     B = [B zeros(1, ll-length(B))];
     Q = [Q zeros(1, ll-length(Q))];
     sum = zeros(1, ll);
     
     %conjugate of Q
     cQ = conj(Q);
     numer = cQ.*B;
     denom = cQ.*Q;
     sum = sum + numer ./ (denom + lambda);
     clear B;
     clear Q;
end
s = ifft(sum);
