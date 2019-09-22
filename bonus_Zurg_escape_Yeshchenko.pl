:- initialization(test).

timeToCross(buzz,5).
timeToCross(woody,10).
timeToCross(rex,20).
timeToCross(hamm,25).

toysList([buzz,woody,rex,hamm]).

cost([],0) :- !.
cost([X|L],C) :- timeToCross(X,S), cost(L,D), C is max(S,D).

split(L,[X,Y],M) :- member(X,L), member(Y,L), compare(<,X,Y), subtract(L,[X,Y],M).

move(st(l,L1),st(r,L2),r(M),D) :- split(L1,M,L2), cost(M,D).
move(st(r,L1),st(l,L2),l(X),D) :- toysList(T), subtract(T,L1,R), member(X,R), merge_set([X],L1,L2), timeToCross(X,D).

trans(st(r,[]),st(r,[]),[],0).
trans(S,U,L,D) :- move(S,T,M,X), trans(T,U,N,Y), append([M],N,L),D is X + Y.

cross(M,D) :- toysList(T), trans(st(l,T),st(r,[]),M,D0), D0 =< D.

solution(M) :- cross(M,60).

test :- solution(M), write(M), nl, fail, !.