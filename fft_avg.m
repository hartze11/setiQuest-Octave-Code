% Copyright 2010 Dave Hartzell
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

% This function performs an FFT averaging on a vector, x, along with
% applying a Hanning window (to clean-up the FFT).
% The window length can be specified (win_length).

function y = fft_avg(x, win_length)

  if (nargin == 1)
    win_length = 4096;
  endif;

step = win_length / 2;

fft_win = hanning(win_length)';

y = zeros(1,win_length);

start = 1;
stop = win_length;

while (stop < length(x) )
 y = y + abs(fft(x(start:stop).*fft_win));
 start = start + step;
 stop = stop + step;
end
 
y=y/(length(x)/step);
