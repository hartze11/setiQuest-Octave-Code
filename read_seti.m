% This file reads the setiQuest ATA data (interleaved I/Q) and 
% organizes the data into a single vevtor of complex samples, for
% additional processing.
% At a minimum, specify the input vector.  The default loads ONE
% second of data (even though it says two seconds below, since 
% there are double the samples with the I/Q data).

function data = read_seti( input, Fs, time_sec )

 if (nargin < 2)
    Fs = 8738113;
    time_sec = 2;
 endif;

fd=fopen( input );

%  open this many seconds of data
N = Fs * time_sec;

coeffs=fread(fd, N, 'schar');

data(1:N/2)=coeffs(1:2:N)+coeffs(2:2:N)*i;


endfunction;
