-module(scc).

%% API exports
-export([calculate_jumps/1]).

%%====================================================================
%% API functions
%%====================================================================
calculate_jumps([]) -> erlang:error(badarg);
calculate_jumps(_A) -> nil.


%%====================================================================
%% Internal functions
%%====================================================================
