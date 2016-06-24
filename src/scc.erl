-module(scc).
-include_lib("eunit/include/eunit.hrl").

%% API exports
-export([calculate_jumps/1]).

%%====================================================================
%% API functions
%%====================================================================
calculate_jumps([]) -> erlang:error(badarg);
calculate_jumps(A) -> do_calculate_jumps(A, 0, length(A), 0).


%%====================================================================
%% Internal functions
%%====================================================================
do_calculate_jumps(_, _, Len, Jumps) when Jumps > Len -> never;
do_calculate_jumps(_, Idx, Len, Jumps) when Idx >= Len -> {ok, Jumps};
do_calculate_jumps(A, Idx, Len, Jumps) ->
    Next = Idx + lists:nth(Idx+1, A),
    ?debugFmt("next: ~p~n", [Next]),
    do_calculate_jumps(A, Next, Len, Jumps + 1).
