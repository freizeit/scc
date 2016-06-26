-module(scc_test).
-include_lib("eunit/include/eunit.hrl").


scc_empty_list_test() ->
    ?assertError(badarg, scc:calculate_jumps([])).

scc_never_test() ->
    ?assertEqual(never, scc:calculate_jumps([1, 1, -1, 1])).

scc_4out_right_test() ->
    ?assertEqual({ok, 4}, scc:calculate_jumps([2, 3, -1, 1, 3])).

scc_never_lower_boundary_test() ->
    ?assertEqual(never, scc:calculate_jumps([0])).

scc_never_upper_boundary_test() ->
    ?assertEqual(never, scc:calculate_jumps([1, 1, 1, -3])).

scc_4out_left_test() ->
    ?assertEqual({ok, 4}, scc:calculate_jumps([2, 3, -1, 1, -5])).

scc_1out_lower_boundary_right_test() ->
    ?assertEqual({ok, 1}, scc:calculate_jumps([1])).

scc_1out_lower_boundary_left_test() ->
    ?assertEqual({ok, 1}, scc:calculate_jumps([-1])).

scc_4out_upper_boundary_right_test() ->
    ?assertEqual({ok, 5}, scc:calculate_jumps([1, 1, 1, 1, 1])).
