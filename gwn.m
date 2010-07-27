% Generates Gaussian white noise from a uniform entropy source file.
% by Andres Foster
% This function generates GWN, with a seed file.
function Z0, Z1 = gwn ( blocksize, filename )
  persistent fd;
  if (exist("filename"))
    if (isscalar(fd))
    fclose(fd);
  endif
  fd = fopen(filename);
  endif
  if (!exist("blocksize"))
    blocksize = 1;
  endif
  b1 = fread(fd, blocksize, "uint8");
  b2 = fread(fd, blocksize, "uint8");
  for n = 1:blocksize
    u1 = (b1(n)+1)/256;
    u2 = (b2(n)+1)/256;
    z0 = sqrt(-2*log(u1))*cos(2*pi*u2);
    z1 = sqrt(-2*log(u1))*sin(2*pi*u2);
    Z0(n) = z0;
    Z1(n) = z1;
  endfor
endfunction
