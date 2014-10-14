-module(my_file).
-export([read_file/1]).

read_file(File) ->
  case file:read_file(File) of
    {ok, Bin} -> Bin;
    {error, Why} -> error(Why)
  end.
