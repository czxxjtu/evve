function he = calcS_new(p, q, lambda)
P = zeros(1, length(p) / 2);
Q = zeros(1, length(p) / 2);
for k = 1:length(p) / 2
    P(k) = p(2 * k) + 1i * p(2 * k + 1);
    Q(k) = q(2 * k) + 1i * q(2 * k + 1);
end
  
numer = conj(P).*Q;
denom = conj(P).*P;
he = numer ./ (denom + lambda);
end