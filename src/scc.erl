-module(scc).
-include_lib("eunit/include/eunit.hrl").

%% API exports
-export([calculate_jumps/1]).

%%====================================================================
%% API functions
%%====================================================================
-type value() :: -1000000..1000000.
-type jumps() :: 1..100001.
-spec calculate_jumps(A::nonempty_list(value())) -> { ok, jumps()} | never.
calculate_jumps(A) when length(A) < 1; length(A) > 100000 -> erlang:error(badarg);
calculate_jumps(A) ->
    ?debugFmt("~nA: ~p", [A]),
    do_calculate_jumps(A, 0, length(A), 0).


%%====================================================================
%% Internal functions
%%====================================================================
-spec do_calculate_jumps(A::nonempty_list(value()), K::0..99999,
                         Len_A::1..100000, Jumps::0..100001) -> { ok, jumps()}
                                                                | never.

do_calculate_jumps(_, _, Len_A, Jumps) when Jumps > Len_A -> never;
do_calculate_jumps(_, K, Len_A, Jumps) when K >= Len_A; K < 0 -> {ok, Jumps};
do_calculate_jumps(A, K, Len_A, Jumps) ->
    N = K + lists:nth(K+1, A),
    ?debugFmt("K: ~p, N: ~p", [K, N]),
    do_calculate_jumps(A, N, Len_A, Jumps+1).
