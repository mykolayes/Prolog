:- initialization(test).

%Функції, елементарні за Кальманом. За допомогою 0-функції та функції слідування s(x)=x+1 можна визначати інші арифметичні функції.
%Функція слідування
s(X,Y):-Y is X+1.
%Визначення функції dec1(x)=x-1
dec1(X,Y):-s(0,T1),dd(X,0,T1,Y).
dd(X,Y,Z,Y):-X=Z,!.
dd(X,Y,Z,V):-s(Y,Y1),s(Z,Z1),dd(X,Y1,Z1,V).
%Визначення функції обчислення суми двох чисел
summa(X,0,X):-!.
summa(X,Y,Z):-s(X,X1),dec1(Y,Y1),summa(X1,Y1,Z).
%Різниця двох чисел
minus(X,Y,0):-X=<Y,!.
minus(X,Y,Z):-mn(X,Y,0,Z).
mn(X,Y,Z,Z):-summa(Y,Z,X1),X1=X,!.
mn(X,Y,Z,V):-s(Z,Z1),mn(X,Y,Z1,V).
%Множення
mult(_,0,0):-!.
mult(0,_,0):-!.
mult(X,Y,Z):-ml(X,X,Y,Z).
ml(_,Y,Z,Y):-s(0,Z1),Z1=Z,!.
ml(X,Y,Z,V):-dec1(Z,Z1),summa(X,Y,Y1),ml(X,Y1,Z1,V).

/* HOMEWORK */

% Division / D - ціла частина, M - остача
divx(X,Y,D,M):-dv(X,Y,D,M,0).
dv(X,Y,C,X,C):-X<Y,!.
dv(X,Y,D,M,C):-minus(X,Y,X1),s(C,C1),dv(X1,Y,D,M,C1).

% Factorial
fac(0,1):-!.
fac(N,RES):- N1 is N-1, fac(N1,RES1), RES is N*RES1.

% Power
pow(_,0,1):-!.
pow(X,Y,RES):-Y1 is Y-1, pow(X,Y1,RES1), RES is RES1*X.

%LogPower
logpow(_,0,1):-!.
logpow(X,1,X):-!.
logpow(X,Y,RES):-mod(Y,2)=0,Y1 is Y/2, X1 is X*X, logpow(X1,Y1,RES).
logpow(X,Y,RES):-Y1 is Y-1, logpow(X,Y1,RES1), RES is RES1 * X.
		
fib(0, 1) :- !.
fib(1, 1) :- !.
fib(N, Result) :- N > 1, N1 is N - 1, N2 is N - 2, fib(N1, Result1), fib(N2, Result2), Result is Result1 + Result2.

brute_force_factors( N , Fs ) :-
  integer(N) ,
  N > 0 ,  
  setof( F , ( between(1,N,F) , N mod F =:= 0 ) , Fs )
  .	

% FactorialFractionSum
facfrac(0,_):-!.
% facfrac(N,RES):- N1 is N-1, RES2 is fac(N,RES2), RES1 is RES+(1/RES2), facfrac(N1,RES1).
%facfrac(N,RES):- N1 is N-1, facfrac(N1,RES1), RES is N*(1/RES1).
facfrac(N,RES):- fsum(N,0,RES1), RES is RES1.
%summa
fsum(0,CURRSUM,RES):- RES is CURRSUM, !.
fsum(N, CURRSUM, RES) :- fac(N,RES1), CURRSUM1 is CURRSUM + 1/RES1, N1 is N-1, fsum(N1, CURRSUM1, RES).


%N1 is N-1, CURRSUM1 is CURRSUM + 1/fac(N1,RES2), RES is CURRSUM1.
% facfrac(N, R) :- facfrac(N, 1, R).
% facfrac(0, R, R) :- !.
% facfrac(N, Acc, R) :-
    % NewN is N - 1,
    % NewAcc is Acc * N,
    % facfrac(NewN, (1/NewAcc), R).
	
divisible(X,Y) :- 0 is X mod Y, !.

divisible(X,Y) :- X > Y+1, divisible(X, Y+1).

isPrime(2) :- true,!.
isPrime(X) :- X < 2,!,false.
isPrime(X) :- not(divisible(X, 2)).

prime_multipliers(N, Fs) :- 
  integer(N) ,
  N > 0 ,  
  setof( F , ( between(1,N,F) , N mod F =:= 0, isPrime(F) ) , Fs ).

%usual sum of 1s for test
usum(0,_):-!.
usum(N,RES) :- usumtmp(N,0,RES1), RES is RES1.

usumtmp(0,TMPSUM,RES):- RES is TMPSUM, !.
usumtmp(N,TMPSUM,RES) :- N1 is N-1, TMPSUM1 is TMPSUM + 1, usumtmp(N1,TMPSUM1,RES).

test :- divx(20, 3, RESFR, RESRM), write('20/3 with fraction: ' ), tab(1), write(RESFR), write(' and remainder: ' ), tab(1), write(RESRM), nl,
pow(3, 10, RESPWR), write('3^10: ' ), tab(1), write(RESPWR), nl,
logpow(3, 10, RESLOGPWR), write('3^10 (logarithmic): ' ), tab(1), write(RESLOGPWR), nl,
fib(7, RESFIB), write('The 7th numbers in Fibonacci sequence are: ' ), tab(1), write(RESFIB), nl,
prime_multipliers(10, RESPRIMES), write('Prime multipliers of 10 are: ' ), tab(1), write(RESPRIMES), nl,
facfrac(5,RESFACS), write('Sum of first 5 members in the series of 1/n!: ' ), tab(1), write(RESFACS), nl, fail;true.