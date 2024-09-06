int: n = 4;
int: m = 3;
array[1..n, 1..m] of int: A = [|1,2,3|4,5,6|7,8,9|5,5,5|];

% array[1..n] of int: B = [sum(j in 1..m)(A[i,j] = 5) | i in 1..n];
%% or, more elegantly:
array[1..n] of int: B = [count(A[i,..],5) | i in 1..n];

output [show(B)];