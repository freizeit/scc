-module(scc_test).
-include_lib("eunit/include/eunit.hrl").


%%====================================================================
%% error cases
%%====================================================================
scc_empty_list_test() ->
    ?assertError(badarg, scc:calculate_jumps([])).

scc_list_too_big_test() ->
    ?assertError(badarg, scc:calculate_jumps(lists:seq(1,100001))).

%%====================================================================
%% test cases resulting in never
%%====================================================================
scc_never_case_from_doc_test() ->
    ?assertEqual(never, scc:calculate_jumps([1, 1, -1, 1])).

scc_never_lower_boundary_test() ->
    ?assertEqual(never, scc:calculate_jumps([0])).

scc_never_upper_boundary_test() ->
    ?assertEqual(never, scc:calculate_jumps([1, 1, 1, -3])).

scc_most_inefficient_never_case_test() ->
    ?assertEqual(never, scc:calculate_jumps([0|lists:seq(1,10000)])).

%%====================================================================
%% test cases resulting in {ok, N}
%%====================================================================
scc_4_and_out_case_from_doc_test() ->
    ?assertEqual({ok, 4}, scc:calculate_jumps([2, 3, -1, 1, 3])).

scc_1_and_out_lower_boundary_right_test() ->
    ?assertEqual({ok, 1}, scc:calculate_jumps([1])).

scc_1_and_out_lower_boundary_left_test() ->
    ?assertEqual({ok, 1}, scc:calculate_jumps([-1])).

scc_5_and_out_upper_boundary_left_test() ->
    ?assertEqual({ok, 5}, scc:calculate_jumps([1, 1, 1, 1, -5])).

scc_5_and_out_upper_boundary_right_test() ->
    ?assertEqual({ok, 5}, scc:calculate_jumps([1, 1, 1, 1, 1])).
