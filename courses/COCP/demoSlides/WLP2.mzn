include "globals.mzn";
enum Warehouses;
enum Shops;
% Each warehouse has the same maintenance cost:
int: maintCost;
% Capacity[w] = supply capacity of warehouse w:
array[Warehouses] of int: Capacity;
% SupplyCost[s,w] = supply cost to s from w:
array[Shops,Warehouses] of int: SupplyCost;
% Supplier[s] = the supplier warehouse for s:
array[Shops] of var Warehouses: Supplier;
%% non-mutually redundant variables with Supplier, needed to express the maximal-regret search strategy:
% Cost[s] = actually incurred supply cost for s:
array[Shops] of var 0..max(SupplyCost): Cost;
constraint forall(s in Shops) % 1way channelling
  (Cost[s] = SupplyCost[s,Supplier[s]]);
% capacity constraint:
constraint global_cardinality_low_up_closed
  (Supplier, Warehouses,
   [0 | w in Warehouses], Capacity)
  :: domain_propagation;
% objective variable, non-mutually redundant with Supplier and Cost:
var 0..(maintCost*card(Warehouses) +            sum(s in Shops)(max(SupplyCost[s,..]))): cost; 
constraint cost = % one-way channelling:
  maintCost * nvalue(Supplier) %   total maint.
  + sum(Cost);                 % + total supply
% objective and search:
solve
 :: seq_search([
     int_search(Cost,max_regret,indomain_min),
     int_search(Supplier,input_order,indomain_min)
    ])
  minimize cost;
output ["Cost = \(cost) for Supplier = \(Supplier)"];