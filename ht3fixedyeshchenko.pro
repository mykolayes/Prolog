:- initialization(test).

% 1
findNums(RES) :- findNumsLogic(100,[],RES1), RES = RES1.

findNumsLogic(1000,LISTRES,RES) :- RES = LISTRES, !.
findNumsLogic(N,LISTRES,RES) :- number_codes(N,X1), maplist(plus(48),Y1,X1), 
								 nth0(0,Y1,First), not(divisible(First,2)), nth0(1,Y1,Second), not(divisible(Second,2)), nth0(2,Y1,Third), not(divisible(Third,2)),
								 number_chars(N,X2),format('~s',[X2]), nth0(0,X2,FirstChar), nth0(2,X2,ThirdChar), atom_concat(FirstChar, ThirdChar, FinalAtom), atom_number(FinalAtom, FinalAtomNum), divisible(N,FinalAtomNum),
								 append(LISTRES, [N], Z), N1 is N+1, findNumsLogic(N1, Z, RES).
findNumsLogic(N,LISTRES,RES) :- N1 is N+1, findNumsLogic(N1, LISTRES, RES).

% 2

findNum(RES) :- findNumLogic(1000,RES1), RES is RES1.

findNumLogic(10000,RES) :- RES is -1, !.
findNumLogic(N,RES) :- number_codes(N,X1), maplist(plus(48),Y1,X1),
						nth0(0,Y1,First), nth0(1,Y1,Second), First =:= Second, 
						nth0(2,Y1,Third), nth0(3,Y1,Fourth), Third =:= Fourth,
						Z is round(sqrt(N)), Z*Z =:= N, RES is N.
findNumLogic(N,RES) :- N1 is N+1, findNumLogic(N1,RES).

% 3

%check if 2nd int is the divider of the 1st one.
divisible(Y,X) :-
    Y mod X =:= 0.

isPrime(2) :- true,!.
isPrime(X) :- X < 2,!,false.
isPrime(X) :- not(divisible(X, 2)).

notDivs(RES) :- notDivsLogic(1998,0,RES1), RES is RES1.

notDivsLogic(0,TOTAL,RES) :- RES is TOTAL, !.
notDivsLogic(N,TOTAL,RES) :- not(divisible(N, 6)), not(divisible(N, 10)), not(divisible(N, 15)), N1 is N-1, TOTAL1 is TOTAL+1, notDivsLogic(N1,TOTAL1,RES).
notDivsLogic(N,TOTAL,RES) :- N1 is N-1, notDivsLogic(N1,TOTAL,RES).

% 4

findM(RES) :- findMLogic(1,RES1), RES is RES1.

findMLogic(N,RES):- pow(N,2,R), pow((N+1),2,R1), pow((N+2),2,R2), pow((N+3),2,R3), pow((N+4),2,R4), pow((N+5),2,R5), pow((N+6),2,R6), pow((N+7),2,R7), pow((N+8),2,R8), pow((N+9),2,R9), pow((N+10),2,R10), X is R + R1 + R2 + R3 + R4 + R5 + R6 + R7 + R8 + R9 + R10, Z is round(sqrt(X)), Z*Z =:= X, RES is N.
findMLogic(N,RES):-N1 is N+1, findMLogic(N1,RES).

%5

findPeriod(RES):- findPeriodLogic(1,9,9,8,0,RES1), RES is RES1.

my_last(X,[X]).
my_last(X, [_|L]) :- my_last(X, L).

findPeriodLogic(1,9,9,8,P,RES1):- P > 0, RES1 is P, !.
findPeriodLogic(N1,N2,N3,N4,P,RES1):- P1 is P+1, N is (N1 + N2 + N3 + N4), number_codes(N,X1), maplist(plus(48),Y1,X1), my_last(NNEW,Y1), findPeriodLogic(N2,N3,N4,NNEW,P1,RES1).
% print(Y1),

% 6

% Factorial
fac(N, 1) :- N<2.
fac(N, RES) :- N1 is N-1, fac(N1,RES1), RES is RES1*N.

% Timetable

ttable(RES) :- fac(10,RES10), fac((10-6),RES106), RES is (RES10/RES106).

% Test function (main).

%findNum(RES). - 2
%findNums(RES). - 1
test :- findNums(RESNUMS), write('\n\nAll such three-digit numbers are as follows : ' ), tab(1), write(RESNUMS), nl,
		findNum(RESNUM), write('The sought four-digit number is : ' ), tab(1), write(RESNUM), nl,
		notDivs(RESDIVS), write('Total amount of numbers ranging 1-1998, which do not divide by 6, 10 and 15 is: ' ), tab(1), write(RESDIVS), nl,
		findM(RESM), write('First integer with the defined characteristic is : ' ), tab(1), write(RESM), nl,
		findPeriod(RESPERIOD), write('The period in the numerical sequence (1998737...) is: ' ), tab(1), write(RESPERIOD), nl,
		ttable(RESTTABLE), write('Number of possible timetables is: ' ), tab(1), write(RESTTABLE), nl;true.