% Copyright 2010 Dave Hartzell, Claudio Maccone, Sarod Yatawatta
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

% This function calculates the KLT using the Bordered Autocorrelation method,
% as suggested by Claudio Macccone.  This code was written by Sarod Yatawatta
% and tweaked / adopted here by Dave Hartzell.

% Right now this code is significantly slower that using the standard
% auto correlation code built-in to Octave.  Ideally, this should be faster
% than the standard autocorrelation, with optimization.

function lambda = bam_klt(x, M)

 if (nargin < 2)
  M=500;
 endif;

N = length(x);

%% max window size

lambda=zeros(M,1);

%% number of largest eigenvalues
K=1;

%% loop over window size
for m=1:M,
 %% covariance
 R=zeros(m,m);
 %% first row
 r=zeros(1,m);
 for ci=1:m,
  r(ci)=x(ci:N)'*x(1:N-ci+1)/(N-ci+1);
 end
 for ci=1:m,
  R(ci,ci:m)=r(1:m-ci+1);
  R(ci+1:m,ci)=r(2:m-ci+1)';
 end

 %% find the largest magnitude eigenvalue
 if m<=40,
  %% use normal
  d=sort(eig(R),'descend');
  lambda(m)=mean(d(1:min(K,m)));
 else,
  %% use ARPACK
  d=eigs(R,K,'LM');
  lambda(m)=mean(d);
 end
end
