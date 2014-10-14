-module(math_functions).
-export([even/1, odd/1, filter/2, split/1]).

even(N) ->
    N rem 2 =:= 0.

odd(N) ->
    N rem 2 =:= 1.

filter(F, List) ->
    [X || X <- List, F(X)].

% split(List) ->
%     Even = filter(fun(X) -> even(X) end, List),
%     Odd = filter(fun(X) -> odd(X) end, List),
%     {Even, Odd}.

split(List) ->
    split(List, [], []).

split([], Even, Odd) ->
    {lists:reverse(Even), lists:reverse(Odd)};

split(List, Even, Odd) ->
    [H|T] = List,
    case even(H) of
        true -> NewEven = [H|Even], split(T, NewEven, Odd);
        false -> NewOdd = [H|Odd], split(T, Even, NewOdd)
    end.

