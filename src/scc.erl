-module(scc).
-define(NODEBUG, true).
-include_lib("eunit/include/eunit.hrl").

%% API exports
-export([calculate_jumps/1]).

%%====================================================================
%% API functions
%%====================================================================
-type value() :: -1000000..1000000.
-type jumps() :: 1..100000.
-spec calculate_jumps(A::nonempty_list(value())) -> { ok, jumps()} | never.
calculate_jumps(A) when length(A) < 1; length(A) > 100000 ->
    erlang:error(badarg);
calculate_jumps(A) ->
    Len_A = length(A),
    if
        Len_A < 10 -> ?debugFmt("~nA: ~p", [A]);
        true -> ?debugFmt("~nA[:10]: ~p, ~p elements omitted",
                          [lists:sublist(A, 10), Len_A - 10])
    end,
    do_calculate_jumps(A, 0, Len_A, 0, gb_sets:new()).


%%====================================================================
%% Internal functions
%%====================================================================
-spec do_calculate_jumps(A::nonempty_list(value()), K::0..99999,
                         Len_A::1..100000, Jumps::0..100001, Seen::any())
    -> {ok, jumps()} | never.

do_calculate_jumps(A, K, Len_A, Jumps, Seen) ->
    ?debugFmt("K: ~p, Next: ~p", [K, K + lists:nth(K+1, A)]),

    % Have we seen this element already? If so, we are in a loop.
    case gb_sets:is_element(K, Seen) of
        true -> never;
        false ->
            Next = K + lists:nth(K+1, A),
            if
                Next >= Len_A; Next < 0 -> {ok, Jumps + 1};
                true ->
                    do_calculate_jumps(A, Next, Len_A, Jumps+1,
                                       gb_sets:add_element(K, Seen))
            end
    end.
