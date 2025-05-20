% Copyright: Pierre.Flener@it.uu.se, course 1DL451, 2025
include "globals.mzn";
array[1..9,1..9] of var 1..9: Sudoku; % Sudoku[r,c] = the number in row r and column c
constraint Sudoku =
  [|8,_,_,_,_,_,_,_,_
   |_,_,3,6,_,_,_,_,_
   |_,7,_,_,9,_,2,_,_
   |_,5,_,_,_,7,_,_,_
   |_,_,_,_,4,5,7,_,_
   |_,_,_,1,_,_,_,3,_
   |_,_,1,_,_,_,_,6,8
   |_,_,8,5,_,_,_,1,_
   |_,9,_,_,_,_,4,_,_
   |];
constraint forall(row in 1..9)   (all_different(Sudoku[row     ,..      ])); % the elements in each row          are all different
constraint forall(col in 1..9)   (all_different(Sudoku[..      ,col     ])); % the elements in each column       are all different
constraint forall(i,j in {0,3,6})(all_different(Sudoku[i+1..i+3,j+1..j+3])); % the elements in each 3-by-3 block are all different
solve satisfy;