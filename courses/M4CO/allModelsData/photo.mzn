% Copyright: Pierre.Flener@it.uu.se, course 1DL451, 2025
include "globals.mzn";
enum Students;
array[_] of record(Students: who, Students: whom, int: bid): Wish; % for a wish w: student w.who bids w.bid in order to stand next to w.whom on the photo
array[Students] of var 1..card(Students): Pos; % Pos[s] = the position, in left-to-right order, of student s on the photo
constraint all_different(Pos); % the students are at distinct positions
var int: obj = sum(w in Wish)(w.bid * (abs(Pos[w.who] - Pos[w.whom]) = 1)); % weighted number of granted wishes; non-mutually redundant with Pos; one-way channelling
solve maximize obj;
output ["Weighted number of granted wishes = \(obj): \(inverse(Pos))"];