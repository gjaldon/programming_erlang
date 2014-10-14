-module(lib_misc).
-export([qsort/1, pythag/1, perms/1, my_tuple_to_list/1, my_time_func/1, my_date_string/0,
    map_search/2]).

qsort([]) -> [];
qsort([Pivot|T]) ->
    qsort([X || X <- T, X < Pivot]) % Create a list of all values less than the Pivot and then sort this list
    ++ [Pivot] ++
    qsort([X || X <- T, X >= Pivot]). % Create a list of all values greater than the Pivot and then sort this list

% Take all values for A,B and C from 1 to N such that A + B + C is less than or equal to N and
% A * A + B * B = C * C
pythag(N) ->
    [{A, B, C} ||
        A <- lists:seq(1, N),
        B <- lists:seq(1, N),
        C <- lists:seq(1, N),
        A + B + C =< N,
        A * A + B * B =:= C * C
    ].

% Removes the head from the string and calculates all permutations then append the head
% back. We repeat the same algo for the succeding characters
perms([]) -> [[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L -- [H])].


my_tuple_to_list(Tuple) ->
    TupleSize = lists:seq(1, size(Tuple)),
    [element(Index, Tuple) || Index <- TupleSize].

my_time_func(F) ->
    Past = now(), erlang:display(F), Present = now(),
    {element(1, Present) - element(1, Past),
     element(2, Present) - element(2, Past),
     element(3, Present) - element(3, Past)}.

my_date_string() ->
    {{Year, Month, Day}, {Hour, Minutes, _}} = erlang:localtime(),
    "The current time and date is " ++ httpd_util:month(Month) ++ "," ++ integer_to_list(Day)
    ++ " " ++ integer_to_list(Year) ++ " " ++ integer_to_list(Hour) ++ ":" ++ format_minutes(Minutes).

format_minutes(Minutes) ->
    Display = integer_to_list(Minutes),
    case length(Display) of
        2 -> Display;
        1 -> "0" ++ Display
    end.

% This works like detect/find in Ruby
map_search(Map, Fun) ->
    Keys = maps:keys(Map),
    map_search(Keys, Map, Fun).

map_search([], _Map, _Fun) ->
    error;

map_search([Key|T], Map, Fun) ->
    Value = maps:get(Key, Map),
    case Fun(Key, Value) of
        true -> {Key, Value};
        false -> map_search(T, Map, Fun)
    end.

% Below code doesn't work yet. Can't use variables as keys just yet
% Map pattern-matching example
% count_characters(Str) ->
%     count_characters(Str, #{}).

% count_characters([H|T], #{ H := N }=X) ->
%     count_characters(T, X#{ H := N + 1 });

% count_characters([H|T], X) ->
%     count_characters(T, X#{H => 1});

% count_characters([], X) -> X.
