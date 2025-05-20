% Copyright: Pierre.Flener@it.uu.se, course 1DL451, 2025
include "globals.mzn";
int: nGroups; % number of groups per week
int: nSlots;  % number of players per group
int: nWeeks;  % number of weeks
set of int: Groups  = 1..nGroups;
set of int: Slots   = 1..nSlots;
set of int: Weeks   = 1..nWeeks;
set of int: Players = 1..(nGroups*nSlots);
array[Weeks,Groups] of var set of Players: Group; % Group[w,g] = the set of players of group g in week w
constraint forall(w in Weeks, g in Groups)(card(Group[w,g]) = nSlots); % each group has nSlots players
constraint forall(w in Weeks)(partition_set(Group[w,..],Players)); % each week: the groups partition the players
constraint forall(w1,w2 in Weeks where w1<w2)(forall(g1,g2 in Groups)(card(Group[w1,g1] intersect Group[w2,g2]) <= 1)); % any two groups of distinct weeks have at most one player in common: this implies that any two players meet at most once
solve satisfy;