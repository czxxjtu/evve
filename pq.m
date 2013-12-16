function pq(p)
global qdescs_norm
global dbdescs_norm
global dbnames
global qnames;

bigmatrix = [qdescs_norm; dbdescs_norm];
sublength = size(bigmatrix, 2) / p;
for i = 1:p
    submatrix = bigmatrix(sublength * (i - 1): sublength * i, :);
    [idx , ctr] = kmeans(submatrix, 256);
    


