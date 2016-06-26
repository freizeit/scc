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
do_calculate_jumps(_, _, Len_A, Jumps) when Jumps > Len_A -> never;
do_calculate_jumps(_, K, Len_A, Jumps) when K >= Len_A; K < 0 -> {ok, Jumps};
do_calculate_jumps(A, K, Len_A, Jumps) ->
    N = K + lists:nth(K+1, A),
    ?debugFmt("A: ~p, K: ~p, N: ~p~n", [A, K, N]),
    do_calculate_jumps(A, N, Len_A, Jumps+1).
