-module(geometry).
-export([area/1]).

area({rectangle, Width, Height}) -> Width * Height;
area({triangle, Width, Height}) -> 0.5 * area({rectangle, Width, Height});
area({square, Side}) -> Side * Side;
area({circle, Radius}) -> 3.14159 * Radius * Radius.

