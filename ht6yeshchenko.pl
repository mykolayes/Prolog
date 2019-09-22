% :- initialization(test).

%Test AVL Tree is: t(t(t(nil/0, 3, nil/0)/1, 7, t(t(nil/0, 9, nil/0)/1, 11, nil/0)/2)/3, 16, t(nil/0, 25, t(nil/0, 40, nil/0)/1)/2)/4

% 1
%travAvl(t(t(t(nil/0, 3, nil/0)/1, 7, t(t(nil/0, 9, nil/0)/1, 11, nil/0)/2)/3, 16, t(nil/0, 25, t(nil/0, 40, nil/0)/1)/2)/4).
travAvl(nil/0) :- !.
travAvl(t(L,V,R)/_) :- travAvl(L), write(V), write(' '), travAvl(R).

% 2
%searchAvl(3,t(t(t(nil/0, 3, nil/0)/1, 7, t(t(nil/0, 9, nil/0)/1, 11, nil/0)/2)/3, 16, t(nil/0, 25, t(nil/0, 40, nil/0)/1)/2)/4). - true
%searchAvl(99,t(t(t(nil/0, 3, nil/0)/1, 7, t(t(nil/0, 9, nil/0)/1, 11, nil/0)/2)/3, 16, t(nil/0, 25, t(nil/0, 40, nil/0)/1)/2)/4). - false

%searchAvl(X, nil/0) :- !.
searchAvl(X, t(_,X,_)/_) :- !.
searchAvl(X, t(L,_,_)/_) :- searchAvl(X, L).
searchAvl(X, t(_,_,R)/_) :- searchAvl(X, R).

% 3
%(assuming given tree is already a self-balancing Binary Search Tree (BST))

%isAvlTree(nil/0). - true
%isAvlTree(t(nil/0, 3, nil/0)/0). - true
%isAvlTree(t(t(t(nil/0, 3, nil/0)/1, 7, t(t(nil/0, 9, nil/0)/1, 11, nil/0)/2)/3, 16, t(nil/0, 25, t(nil/0, 40, nil/0)/1)/2)/4). - true
%isAvlTree(t(t(t(nil/0, 3, nil/0)/1, 7, t(t(nil/0, 9, nil/0)/1, 11, nil/0)/2)/3, 16, t(nil/0, 25, t(nil/0, 40, nil/0)/1)/8)/4). - false
isAvlTree(nil/0).
isAvlTree(t(L, _, R)/_) :- L = nil/0, R = nil/0.
isAvlTree(t(L, _, R)/_) :- L = nil/0, R = t(_, _, _)/HR, abs(HR - 0) =< 1, isAvlTree(R).
isAvlTree(t(L, _, R)/_) :- L = t(_, _, _)/HL, R = nil/0, abs(HL - 0) =< 1, isAvlTree(L).
isAvlTree(t(L, _, R)/_) :- L = t(_, _, _)/HL, R = t(_, _, _)/HR, abs(HL - HR) =< 1, isAvlTree(L), isAvlTree(R).

% 4

%Test BST: bst(bst(bst(nil, 2, nil), 4, bst(nil, 5, nil)), 6, bst(bst(nil, 7, nil), 9, nil)).

%delete_key(99,bst(bst(bst(nil, 2, nil), 4, bst(nil, 5, nil)), 6, bst(bst(nil, 7, nil), 9, nil)),R).
%delete_key(2,bst(bst(bst(nil, 2, nil), 4, bst(nil, 5, nil)), 6, bst(bst(nil, 7, nil), 9, nil)),R).
%delete_key(4,bst(bst(bst(nil, 2, nil), 4, bst(nil, 5, nil)), 6, bst(bst(nil, 7, nil), 9, nil)),R).
delete_key(Key, nil, nil):-write(Key), write(' could not be found.'),!. %Key could not be found
delete_key(Key, bst(L, Key, nil), L):-!. %L can be nil here, too
delete_key(Key, bst(nil, Key, R), R):-!.
delete_key(Key, bst(L, Key, R), bst(NL, Pred, R)):-!, get_pred(L, Pred, NL).
delete_key(Key, bst(L, K, R), bst(NL, K, R)):-Key<K, !, delete_key(Key, L, NL).
delete_key(Key, bst(L, K, R), bst(L, K, NR)):- delete_key(Key, R, NR).

get_pred(bst(L, Pred, nil), Pred, L):-!.
get_pred(bst(L, Key, R), Pred, bst(L, Key, NR)):-get_pred(R, Pred, NR).