#!/usr/bin/pl -q -t einstein -s

:- initialization(einstein).

neighbors(X, Y, List) :- nextto(X, Y, List).
neighbors(X, Y, List) :- nextto(Y, X, List).

einstein :-
    Houses = [_,_,_,_,_],
    member([englishman,_,_,_,red], Houses),
    member([swede,dog,_,_,_], Houses),
    member([dane,_,_,tea,_], Houses),
    nextto([_,_,_,_,green], [_,_,_,_,white], Houses),
    member([_,_,_,coffee,green], Houses),
    member([_,bird,pallmall,_,_], Houses),
    nth1(3, Houses, [_,_,_,milk,_]),
    member([_,_,dunhill,_,yellow], Houses),
    nth1(1, Houses, [norwegian,_,_,_,_]),
    neighbors([_,_,marlboro,_,_], [_,cat,_,_,_], Houses),
    member([_,horse,_,_,blue], Houses),
    member([_,_,winfield,beer,_], Houses),
    neighbors([norwegian,_,_,_,_], [_,_,_,_,blue], Houses),
    member([german,_,rothmans,_,_], Houses),
    neighbors([_,_,marlboro,_,_], [_,_,_,water,_], Houses),

	%Who has the fish?
    member([Owner,fish,_,_,_], Houses),

    print("Owner of the fish: "), print(Owner).
	%print('All: '), print(Houses), nl.