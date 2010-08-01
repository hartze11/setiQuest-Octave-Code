% Copyright 2010 Anders Feder
%
%   Licensed under the Apache License, Version 2.0 (the "License");
%   you may not use this file except in compliance with the License.
%   You may obtain a copy of the License at
%
%       http://www.apache.org/licenses/LICENSE-2.0
%
%   Unless required by applicable law or agreed to in writing, software
%   distributed under the License is distributed on an "AS IS" BASIS,
%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%   See the License for the specific language governing permissions and
%   limitations under the License.

% Generates Gaussian white noise from a uniform entropy source file.
% by Anders Feder
%
% This function generates GWN, with a uniformly distributed seed file, using
% the Box-Muller transform. The two GWN vectors produced by the transform are
% interleaved to create a single vector of size blocksize*2.

function Z = gwn ( blocksize, filename )
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
    Z(n*2+1) = sqrt(-2*log(u1))*cos(2*pi*u2);
    Z(n*2+2) = sqrt(-2*log(u1))*sin(2*pi*u2);
  endfor
endfunction
