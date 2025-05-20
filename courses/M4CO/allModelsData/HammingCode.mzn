% Copyright: Pierre.Flener@it.uu.se, course 1DL451, 2025
include "globals.mzn";
int: n; % number of codewords
int: m; % number of bits per codeword
int: d; % least Hamming distance between any two codewords
array[1..n] of var set of 1..m: Codeword; % Codeword[i] is the i^th codeword, encoded as the set of indices (index 1 is for the least significant bit) of its 1-bits
constraint forall(i, j in 1..n where i < j)(card(Codeword[i] symdiff Codeword[j]) >= d);
solve satisfy;