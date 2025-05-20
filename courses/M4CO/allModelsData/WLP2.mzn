% Copyright: Pierre.Flener@it.uu.se, course 1DL451, 2025
include "globals.mzn";
enum Warehouses;
enum Shops;
int: maintCost; % each candidate warehouse has the same maintenance cost
array[Warehouses] of int: Capacity; % Capacity[w] = the supply capacity of candidate warehouse w
array[Shops,Warehouses] of int: SupplyCost; % SupplyCost[s,w] = the supply cost to shop s from candidate warehouse w
array[Shops] of var Warehouses: Supplier; % Supplier[s] = the supplier warehouse for shop s; enforces constraint (1)
array[Shops] of var 0..max(SupplyCost): Cost; % Cost[s] = the actually incurred supply cost for shop s; non-mutually redundant with Supplier; needed to express the maximal-regret search strategy
constraint forall(s in Shops)(Cost[s] = SupplyCost[s,Supplier[s]]); % one-way channelling
constraint global_cardinality_closed(Supplier, Warehouses, [0 | w in Warehouses], Capacity) :: domain_propagation; % capacity constraint (2)
var 0..(maintCost * card(Warehouses) + sum(s in Shops)(max(SupplyCost[s,..]))): cost; % objective variable, non-mutually redundant with Supplier and Cost
constraint cost = maintCost * nvalue(Supplier) + sum(Cost); % one-way channelling; total maintenance + total supply cost
% constraint cost = maintCost * sum(w in Warehouses)(exists(s in Shops)(Supplier[s]=w)) + sum(Cost); % alternative one-way channelling; total maintenance + total supply cost
solve
  :: seq_search([
       int_search(Cost,max_regret,indomain_min),
       int_search(Supplier,input_order,indomain_min)
     ])
  minimize cost;
output ["Cost = \(cost) for Supplier = \(Supplier)"];