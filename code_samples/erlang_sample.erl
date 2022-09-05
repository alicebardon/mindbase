-module (send_recv).
-compile([export_all]).


%$ beginning of a block of code
serve() ->
    receive
        Request ->
            io:format("Handling: ~s~n", [Request]),
            serve()
    end.
%$$ End of block



math() -> %$ This is how you define a function in Erlang $$
    receive
        {add, X, Y} -> %$ This is how you define a lambda function $$
            io:format("~p + ~p = ~p~n", [X,Y,X+Y]),
            math();
        {sub, X, Y} ->
            io:format("~p - ~p = ~p~n", [X,Y,X-Y]),
            math()
    end. % I do NOT want to see this comment in Mindbase



make_request(ServerId, Msg) ->
    ServerId ! Msg.

%$ Run a process
run() ->
    Pid = spawn(?MODULE, serve, []),
    make_request(Pid, request1),
    make_request(Pid, request2),
% $$ End capture
    timer:sleep(10),

    Pid2 = spawn(?MODULE, math, []),
    Pid2 ! {add, 1, 2},
    Pid2 ! {sub, 3, 2},
    ok.
