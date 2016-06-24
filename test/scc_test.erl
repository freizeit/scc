-module(scc_test).
-include_lib("eunit/include/eunit.hrl").


scc_0_test() ->
    ?assertError(badarg, scc:calculate_jumps([])).

scc_1_test() ->
    ?assertEqual(never, scc:calculate_jumps([1, 1, -1, 1])).

scc_2_test() ->
    ?assertEqual({ok, 4}, scc:calculate_jumps([2, 3, -1, 1, 3])).
