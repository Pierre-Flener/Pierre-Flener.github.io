% Copyright: Pierre.Flener@it.uu.se, courses 1DL442 and 1DL451, 2023
include "globals.mzn";
int: n; % length of X
enum Alphabet = {s,t};  enum State = {a,b,c,d,e};
array[State,Alphabet] of opt State: Transition = [| b,c | d,<> | e,<> | <>,b | c,e |];
array[1..n] of var Alphabet: X; % X[i] = the symbol at position i in the string
%% The following are three alternative formulations, but the 3rd one is hardwired for n = 4:
constraint regular(X,Transition,a,{d,e});                % X denotes a string in the regular language of the given DFA
% constraint regular(X,"s s (t s)* | t s (t | s s)*");   % X denotes a string in the regular language of the given RE 
% constraint table(X,[| s,s,t,s | t,s,s,s | t,s,t,t |]); % X denotes one of the length-4 strings in the regular language of the DFA and RE above 
solve satisfy;