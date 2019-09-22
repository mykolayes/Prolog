:- initialization(test).

%tree example (empty one): nil.
%tree example: tree(tree(nil,b,nil), a, tree(tree(nil,d,nil), c, nil)).

%search BT (check if elem X is in a given tree).
search(X, tree(_,X,_)):-!.
search(X, tree(L,_,_)):- search(X,L).
search(X, tree(_,_,R)):- search(X,R).

% 1
%travlnr(tree(tree(nil,b,nil), a, tree(tree(nil,d,nil), c, nil))).
%travlnr(nil).
travlnr(nil):-!.
travlnr(tree(L,N,R)):-travlnr(L),write(N),write(' '),travlnr(R). %write('->'),travlnr(R).

% 2
%numOfLeaves(tree(tree(nil,b,nil), a, tree(tree(nil,d,nil), c, nil)),R).
%numOfLeaves(tree(tree(nil,b,nil), a, nil),R).
%numOfLeaves(nil,R).
numOfLeaves(nil, RES) :- RES is 1,!.
numOfLeaves(tree(L,_,R),RES) :- numOfLeaves(L,RES1), numOfLeaves(R,RES2), RES is RES1 + RES2.

% 3
%treeHeight(tree(tree(nil,b,nil), a, tree(tree(nil,d,nil), c, nil)),R).
treeHeight(nil, RES) :- RES is 0,!.
treeHeight(tree(L,_,R), RES) :- treeHeight(L,RES1), treeHeight(R,RES2), RES is (1 + max(RES1,RES2)). %RESX is RES - 1.

% 4
%numOfNodes(tree(tree(nil,b,nil), a, tree(tree(nil,d,nil), c, nil)),R).
numOfNodes(nil, RES) :- RES is 0,!.
numOfNodes(tree(L,_,R), RES) :- numOfNodes(L, RES1), numOfNodes(R, RES2), RES is (1 + RES1 + RES2).

% 5
% trav23(l(5)).
% trav23(v2(l(5),8,l(8))).
% trav23(v3(l(5),7,l(7),8,l(8))).
% trav23(v2(v2(l(5),7,l(7)),8,v2(l(8),13,l(13)))).
trav23(nil):- !.
trav23(l(V)):- write(V), write(' '),!.
trav23(v2(T1,_,T2)):- trav23(T1), trav23(T2).
trav23(v3(T1,_,T2,_,T3)):- trav23(T1), trav23(T2), trav23(T3).

%6
%search23(8,v2(l(5),8,l(8))). - true
%search23(4,v2(l(5),8,l(8))). - false
%search23(99,v2(v2(l(5),7,l(7)),8,v2(l(8),13,l(13)))). - false
%search23(7,v2(v2(l(5),7,l(7)),8,v2(l(8),13,l(13)))). - true

%search23(nil):- !.
search23(X, l(X)) :- write('true'), !.
search23(X, v2(T1,_,_)) :- search23(X,T1).
search23(X, v2(_,_,T2)) :- search23(X,T2).
search23(X, v3(T1,_,_,_,_)):- search23(X,T1).
search23(X, v3(_,_,T2,_,_)):- search23(X,T2).
search23(X, v3(_,_,_,_,T3)):- search23(X,T3).

%7
%check if a tree is a binary tree
%checkBT(tree(tree(nil,4,nil),3,nil,4)). - false
%checkBT(tree(tree(nil,4,nil),3,nil)). - true
checkBT(nil):-!.
checkBT(tree(L,N,R)):-checkBT(L), N \= nil, checkBT(R).

%check if a tree is a 2-3 tree
% check23(l(V)):- !.
% check23(v2(T1,_,T2)):- check23(T1), check23(T2).
% check23(v3(T1,_,T2,_,T3)):- check23(T1), check23(T2), check23(T3).

test :- write('Task 1.'), nl, write('Traverse a BT in LnR order. Given tree: '), write(tree(tree(nil,b,nil), a, tree(tree(nil,d,nil), c, nil))), nl, write('Result: ' ), travlnr(tree(tree(nil,b,nil), a, tree(tree(nil,d,nil), c, nil))), nl,
		numOfLeaves(tree(tree(nil,b,nil), a, tree(tree(nil,d,nil), c, nil)),RESLEAVES), write('Task 2.'), nl, write('Number of leaves in the same tree is: '), write(RESLEAVES), nl,
		treeHeight(tree(tree(nil,b,nil), a, tree(tree(nil,d,nil), c, nil)),RESHEIGHT), write('Task 3.'), nl, write('Height of the same tree is: '), write(RESHEIGHT), nl,
		numOfNodes(tree(tree(nil,b,nil), a, tree(tree(nil,d,nil), c, nil)),RESNODES), write('Task 4.'), nl, write('Number of nodes in the same tree is: '), write(RESNODES), nl,
		write('Task 5.'), nl, write('Traverse a 2-3 Tree in LnR order. Given tree: '), write(v2(v2(l(5),7,l(7)),8,v2(l(8),13,l(13)))), nl, write('Result: '), trav23(v2(v2(l(5),7,l(7)),8,v2(l(8),13,l(13)))), nl, write('Task 6.'), nl, write('Find 7 in the same 2-3 tree: ' ), write('Result: ' ), 
		search23(7,v2(v2(l(5),7,l(7)),8,v2(l(8),13,l(13)))), nl,
		write('Task 7.'), nl, write('Check if a tree is a binary tree. Given tree: '), write(tree(tree(nil,4,nil),3,nil)), nl, write('Result (is true): '), checkBT(tree(tree(nil,4,nil),3,nil)),
		nl;true.