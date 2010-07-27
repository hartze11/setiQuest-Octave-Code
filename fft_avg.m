% This function performs an FFT averaging on a vector, x, along with
% applying a Hanning window (to clean-up the FFT).
% The window length can be specified (win_length).

function y = fft_avg2(x, win_length)

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
