:- initialization(test).

% 1
%findNegs([1,-2,-3,4,-5],R).
findNegs(Nums,Resx) :- findNegsLogic(0,Nums,Res), delete(Res,-1,Resx).

%findNegsLogic(0,[1,-2,-3,4,-5],R).
findNegsLogic(_, [], []) :- !.
findNegsLogic(N,[NumsHead|Nums],[NR|Res]) :- NumsHead < 0, N1 is N+1, NR is N, findNegsLogic(N1, Nums, Res); NumsHead >= 0, N1 is N+1, NR is -1, findNegsLogic(N1, Nums, Res),!.
%findNegsLogic(N,[_|Nums],[Res]) :- N1 is N+1, findNegsLogic(N1, Nums, Res),!.

% 2
%chDone(3,[4,3,5,3,7],R).
chDone(_,[],[]) :- !.
chDone(Ch,[H|T],[Rh|Rt]) :- Ch =:= H, Rh = change_done, chDone(Ch, T, Rt); Rh = H, chDone(Ch,T,Rt),!.

% 3
%convertToRoman([1,12,15,121,52],R).

%returns a list of Roman numbers-strings in order of appearance; concatenate the list for the final result.

% transform(X,[Rh|Rt]) :- X >= 1000, Rh = "M",  Y=X-1000,  transform(Y,Rt),!.
% transform(X,[Rh|Rt]) :- X >=  900, Rh = "CM", Y=X-900,   transform(Y,Rt),!.
% transform(X,[Rh|Rt]) :- X >=  500, Rh = "D",  Y=X-500,   transform(Y,Rt),!.
% transform(X,[Rh|Rt]) :- X >=  400, Rh = "CD", Y=X-400,   transform(Y,Rt),!.
% transform(X,[Rh|Rt]) :- X >=  100, Rh = "C",  Y=X-100,   transform(Y,Rt),!.
% transform(X,[Rh|Rt]) :- X >=   50, Rh = "L",  Y=X-50,    transform(Y,Rt),!.
transform(X,[Rh|Rt]) :- X >=   40, Rh = "XL", Y=X-40,    transform(Y,Rt),!.
transform(X,[Rh|Rt]) :- X >     9, Rh = "X",  Y=X-10,    transform(Y,Rt),!.
transform(X,[Rh|[]]) :- X =:=   9, Rh = "IX",!.
transform(X,[Rh|Rt]) :- X >     4, Rh = "V",  Y=X-5,     transform(Y,Rt),!.
transform(X,[Rh|[]]) :- X =:=   4, Rh = "IV",!.
transform(X,[Rh|Rt]) :- X >=    1, Rh = "I",  Y=X-1,     transform(Y,Rt),!.
transform(X,[]) :- X =:=   0, !.
transform(X,[Rh|Rt]) :- X <     0, Rh = "-", Y=(-X), transform(Y,Rt),!.

convertToRoman([],[]) :- !.
convertToRoman([H|T],[RESSTR|Rt]) :- transform(H,RES), atomsToString(RES,RESSTR), convertToRoman(T,Rt).

%helper function for converting a list of strings into one string.
atomsToString(List,X):- atomics_to_string(List,X).

% 4
%switchRight([1,2,3,4,5],RES).
switchRight(List,ResList) :- length(List,ListLen), switchRightLogic(List,ListLen-1,0,ResListx), last(List,Lst),append([Lst],ResListx,ResListxx), ResList = ResListxx.

switchRightLogic([_|[]],_,_,[]) :- !.
switchRightLogic([H|T],Len,N,[H|Tr]) :- N < Len, N1 is N+1, switchRightLogic(T,Len,N1,Tr).

% 5
%mulMatVect([[1,2,3],[4,5,6]],[1,2,3],RES).
%mulMatVect([[2,4,0],[-2,1,3],[-1,0,1]],[1,2,-1],X).
mulMatVect([],_,[]) :- !.
mulMatVect([Hm|Tm],Vec,[Hr|Tr]) :- mulVectVect(Hm,Vec,0,Hr), mulMatVect(Tm,Vec,Tr).

%mulVectVect([1,2,3],[4,5,6],0).

%mulVectVect([],[],R) :- write(R), !.
mulVectVect([],[],Total,Res) :- Res = Total, !.
mulVectVect([Hv1|Tv1],[Hv2|Tv2],Total,Res) :- Total1 is Total + (Hv1 * Hv2), mulVectVect(Tv1,Tv2,Total1,Res),!.

%additional Prolog logic test functions (NOT USED IN HOMEWORK)---------------------------------

%sumEl(0,[1,2,3]).
sumEl(SUM,[]) :- write(SUM),!.
sumEl(SUM, [H|ELS]) :- SUM1 is SUM + H, sumEl(SUM1,ELS).

%newEls([1,2,3],R).
newEls([],[]) :- !.
newEls([H|ELS],[H1|NELS]) :- H1 is H+5, newEls(ELS,NELS). %H < 2, 
%newEls([_|ELS],[NELS]) :- newEls(ELS,NELS).

%writes all the elements of list of lists.
%showAll([[2,4,0],[-2,1,3],[-1,0,1]]).
showAll([]) :- !.
showAll([Hm|Tm]) :- showOne(Hm), showAll(Tm).
%helper function for one list.
showOne([]) :- !.
showOne([Hv|Tv]) :- write(Hv), showOne(Tv).

%copies one list to another.
copyLists([],[]) :- !.
copyLists([H|T],[H|Tr]) :- copyLists(T,Tr).

test :- findNegs([1,-2,-3,4,-5],RNegs), write('Task 1.'), nl, write('Initial list is as follows: '), write([1,-2,-3,4,-5]), nl, write('Negative nums indices are as follows: ' ), write(RNegs), nl,
		chDone(3,[4,3,5,3,7],RChanges), write('Task 2.'), nl, write('Initial list is as follows: '), write([4,3,5,3,7]), nl,
write('Element to be changed is: '), write(3), nl,
write('Resulting list is as follows: ' ), write(RChanges), nl,
		convertToRoman([1,12,15,121,52], RRomanNums), write('Task 3.'), nl, write('Initial list is as follows: '), write([1,12,15,121,52]), nl, write('Allowed Roman numbers are 1-49. The resulting list is: ' ), write(RRomanNums), nl,
		switchRight([1,2,3,4,5],RSwitch), write('Task 4.'), nl, write('Initial list is as follows: '), write([1,2,3,4,5]), nl, write('Resulting list (after every element was switched to the right) is as follows: ' ), write(RSwitch), nl,
		mulMatVect([[2,4,0],[-2,1,3],[-1,0,1]],[1,2,-1],ResMulMV), write('Task 5.'), nl, write('Initial matrix is as follows: '), write([[2,4,0],[-2,1,3],[-1,0,1]]), nl, write('Initial vector is as follows: '), write([1,2,-1]), nl, write('Resulting list (after multiplying the matrix by given vector) is as follows: ' ), write(ResMulMV), nl;true.