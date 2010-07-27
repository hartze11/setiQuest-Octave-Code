% This function computes the KLT of d, with optional "
% auto correlation length 'len'.

function [vctr, val] = klt( d, len )
 if (nargin >= 1)
  len = 511;
 endif
  
 y = autocor(d, len);
 z = toeplitz(y);
 [vctr,val] = eigs(z, 3, 'lm');

endfunction

