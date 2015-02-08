function x = pagerank(I,G,d)
% I is the initial "hyperlink" matrix 
% G is the adjacency matrix
% p is damping factor (default is .85)

if nargin < 3
    d = 0.85; 
end

% Eliminate any self-referential links 
% (which is actually not necessary in the present problem)  

G = G - diag(diag(G));
  
% c = out-degree, r = in-degree

[n,n] = size(G);
c = full(sum(G,1));   % modified  so that sprintf does not get sparse input 
r = full(sum(G,2));   % (which it used to be able to handle, but no longer can)

% Scale column sums to be 1 (or 0 where there are no out links).

k = find(c~=0);
D = sparse(k,k,1./c(k),n,n);

% Solve (I - p*G*D)*x = e

e = ones(n,1);
I = speye(n,n);
x = (I - d*G*D)\e;

% Normalize so that sum(x) == 1.

x = x/sum(x);

% Bar graph of page rank.

shg
bar(x)
title('Page Rank Result')
