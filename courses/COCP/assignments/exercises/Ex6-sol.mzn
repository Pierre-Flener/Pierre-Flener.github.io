int: n = 4;

array[int,int] of int: A = array2d(1..(n*(n-1) div 2), 1..3, [[f,s,f*n+s][i] | f,s in 1..n where f<s, i in 1..3 ]);

output [show2d(A)];