% Copyright: Pierre.Flener@it.uu.se, courses 1DL442 and 1DL451, 2023
include "globals.mzn";
enum Warehouses;
enum Shops;
int: maintCost; % each candidate warehouse has the same maintenance cost
array[Warehouses] of int: Capacity; % Capacity[w] = the supply capacity of candidate warehouse w
array[Shops,Warehouses] of int: SupplyCost; % SupplyCost[s,w] = the supply cost to shop s from candidate warehouse w
array[Shops,Warehouses] of var 0..1: Supply; % Supply[s,w] = 1 iff shop s is supplied by candidate warehouse w
array[Warehouses] of var 0..1: Open; % Open[w] = 1 iff candidate warehouse w is actually opened; non-mutually redundant with Supply; needed to express the objective function
constraint forall(s in Shops)(sum(Supply[s,..]) = 1); % constraint (1): each shop is supplied by exactly one actually opened candidate warehouse
%constraint forall(w in Warehouses)(sum(Supply[..,w]) <= Capacity[w]);          % capacity constraint (2), in isolation
%constraint forall(w in Warehouses)(sum(Supply[..,w]) > 0  <->  Open[w] = 1);       % one-way channelling, in isolation: 1st alternative
%constraint forall(w in Warehouses)(forall(s in Shops)(Supply[s,w] <= Open[w]));    % one-way channelling, in isolation: 2nd alternative
constraint forall(w in Warehouses)(sum(Supply[..,w]) <= Capacity[w] * Open[w]); % capacity constraint (2), combined with 1st alternative of one-way channelling
var 0..(maintCost * card(Warehouses) + sum(s in Shops)(max(SupplyCost[s,..]))): cost; % objective variable; non-mutually redundant with Supply and Cost
constraint cost = maintCost * sum(Open) + sum(s in Shops, w in Warehouses)(SupplyCost[s,w] * Supply[s,w]); % one-way channelling; total maintenance + total supply cost
solve minimize cost;
output ["Cost = \(cost)"];