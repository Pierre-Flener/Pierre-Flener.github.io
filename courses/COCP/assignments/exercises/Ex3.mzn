int: n = 4;
int: m = 3;
array[1..n, 1..m] of int: A = [|1,2,3|4,5,6|7,8,9|5,5,5|];

array[1..n] of int: B = [ ... | ... ];

constraint assert(B = [0,1,0,3], "B does not match the expected value");
output [show(B)];