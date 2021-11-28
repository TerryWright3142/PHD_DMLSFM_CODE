function [X,s] = pinv2(A,varargin)
%PINV2   Pseudoinverse with explicit number of modes
% based on matlab built-in pinv
% usage :
%  pinv2(A)             same as pinv(A)
%  pinv2(A,nModes)      nMode is the number of eigenmodes used in the SVD invertion
%
% Author: ALPAO/JCH


if isempty(A)     % quick return
  X = zeros(size(A'),class(A));  
  s = [];
  return  
end

[m,n] = size(A);

if n > m
    
   [X,s] = pinv2(A',varargin{:});
   X=X';
else
    if issparse(A)
        [U,S,V] = svds(A,0);
    else
        [U,S,V] = svd(A,0);
    end
   if m > 1, s = diag(S);
      elseif m == 1, s = S(1);
      else s = 0;
   end
   if nargin == 2 % explicit number of modes
        r = varargin{1};
        if (r>numel(s)) 
            r=numel(s);
        end
   else % default pinv behaviour
      tol = max(m,n) * eps(max(s));
      r = sum(s > tol);
   end
   if (r == 0)
      X = zeros(size(A'),class(A));
   else
      S = diag(ones(r,1)./s(1:r));
      X = V(:,1:r)*S*U(:,1:r)';
   end
end
