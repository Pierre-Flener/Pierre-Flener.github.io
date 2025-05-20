% Copyright: Pierre.Flener@it.uu.se, course 1DL451, 2025
include "globals.mzn";
int: m; % number of rows
int: n; % number of columns
int: h; % length of longest hint
array[1..m,1..h] of opt int: RowHint; % row    hints
array[1..n,1..h] of opt int: ColHint; % column hints
enum Colour = {b,w};
function string: regExp(array[int] of opt int: Hint) % convert a hint into a regular expression
  = "w* " ++ concat(["b{\(Hint[k])}" ++ if k = h \/ Hint[k+1] = <> then " " else " w+ " endif | k in 1..h where Hint[k] != <>]) ++ "w*";
array[1..m,1..n] of var Colour: Nonogram; % Nonogram[r,c] = the colour of the cell in row r and column c of the nonogram
constraint forall(r in 1..m)(regular(Nonogram[r,..],regExp(RowHint[r,..]))); % enforce row    hints
constraint forall(c in 1..n)(regular(Nonogram[..,c],regExp(ColHint[c,..]))); % enforce column hints
solve satisfy;