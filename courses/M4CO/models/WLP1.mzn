% Copyright: Pierre.Flener@it.uu.se, courses 1DL442 and 1DL451, 2023
include "globals.mzn";
enum Warehouses;
enum Shops;
int: maintCost; % each candidate warehouse has the same maintenance cost
array[Warehouses] of int: Capacity; % Capacity[w] = the supply capacity of candidate warehouse w
array[Shops,Warehouses] of int: SupplyCost; % SupplyCost[s,w] = the supply cost to shop s from candidate warehouse w
array[Shops] of var Warehouses: Supplier; % Supplier[s] = the supplier warehouse for shop s; enforces constraint (1)
array[Warehouses] of var 0..1: Open; % Open[w] = 1 iff candidate warehouse w is actually opened; non-mutually redundant with Supplier; needed to express the objective function
constraint forall(s in Shops)(Open[Supplier[s]] = 1); % one-way channelling
% constraint forall(w in Warehouses)(Open[w] = (exists(s in Shops)(Supplier[s]=w))); % alternative one-way channelling
array[Shops] of var 0..max(SupplyCost): Cost; % Cost[s] = the actually incurred supply cost for shop s; non-mutually redundant with Supplier; needed to express the maximal-regret search strategy
constraint forall(s in Shops)(Cost[s] = SupplyCost[s,Supplier[s]]); % one-way channelling
constraint global_cardinality_closed(Supplier, Warehouses, [0 | w in Warehouses], Capacity) :: domain_propagation; % capacity constraint (2); crucial annotation
var 0..(maintCost * card(Warehouses) + sum(s in Shops)(max(SupplyCost[s,..]))): cost; % objective variable; non-mutually redundant with Supplier and Cost
constraint cost = maintCost * sum(Open) + sum(Cost); % one-way channelling; total maintenance + total supply cost
solve
  :: seq_search([
       int_search(Cost,max_regret,indomain_min),
       int_search(Supplier,input_order,indomain_min),
       int_search(Open,input_order,indomain_min)
     ])
  minimize cost;
output ["Cost = \(cost) for Supplier = \(Supplier)"];