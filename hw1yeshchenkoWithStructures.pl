:- initialization(test).

% Facts

drugstore(1, tsytadelna15, '0442008080').
drugstore(2, pavlova3, '0443500550').
drugstore(3, randomna77, '0441234567').
drugstore(4, phantaziyna9, '0445005050').
drugstore(5, ostannya10, '0444444444').

drug(1,'Humer','group1').
drug(2,'Orasept','group2').
drug(3,'No-Sol','group1').
drug(4,'Sinupret','group3').
drug(5,'Bronhopret','group3').

storeHasDrug(1,1,45,110,2020-10-10).
storeHasDrug(1,2,33,270,2019-07-05).
storeHasDrug(2,1,20,100,2019-06-11).
storeHasDrug(3,4,9,110,2018-10-03).
storeHasDrug(4,5,60,110,2022-15-12).

storeHasDrugStruct(drug(1,'Humer','group1'),drugstore(1, tsytadelna15, '0442008080'),45,2022-15-12).
storeHasDrugStruct(drug(3,'No-Sol','group1'),drugstore(4, phantaziyna9, '0445005050'),9,2018-10-03).
storeHasDrugStruct(drug(6,'Enupret','group3'),drugstore(5, ostannya10, '0444444444'),65,2022-16-12).

% Rules

%call example: ds_hasdrug_phone('Humer',PHONE).
ds_hasdrug_phone(DRUGNAME, DSPHONE) :- drugstore(DSNUM, _, DSPHONE), drug(DSNUM, DRUGNAME, _).

%call example (1 address): ds_cheaper_drug('Humer',105,A).
% + gives 2 addresses: ds_cheaper_drug('Humer',120,A).
ds_cheaper_drug(DRUGNAME, TOPPRICE, DSADDRESS) :- drugstore(DSNUM, DSADDRESS,_), drug(DRUGNUM,DRUGNAME,_), storeHasDrug(DSNUM,DRUGNUM,_,PRICE,_), PRICE < TOPPRICE.

%call example: ds_hasdrug_address('Orasept', A).
ds_hasdrug_address(DRUGNAME, DSADDRESS) :- drugstore(DSNUM, DSADDRESS, _), drug(DSNUM, DRUGNAME, _).

%call example: drug_from_group('group3', D).
drug_from_group(DRUGGRP, DRUGNAME) :- drug(_, DRUGNAME, DRUGGRP).

%call example: drug_date_not_valid(2019-X-Y,'Sinupret',A).
% And: drug_date_not_valid(2019-X-Y,DRUGNAME,A).
drug_date_not_valid(DATENOW, DRUGNAME, DSADDRESS) :- drugstore(DSNUM, DSADDRESS, _), storeHasDrug(DSNUM,DRNUM,_,_,DATEUNTIL), drug(DRNUM,DRUGNAME,_), DATENOW @> DATEUNTIL.

%call example: ds_hasdrug_struct('Humer',DSDETAILS).
%returns the drugstore, which has the specified drug (amount of which is > 0 in stock).
ds_hasdrug_struct(DRUGNAME, DS) :- storeHasDrugStruct(drug(_, DRUGNAME, _),DS,DRUG_AMOUNT,_), DRUG_AMOUNT > 0.
/* queries */




test :- ds_hasdrug_phone('Humer',PHONE), write('Drugstore phone number, which has the specified drug (Humer): ' ), tab(1), write(PHONE), nl,
		ds_cheaper_drug('Humer',105,A), write('Drugstore address, which has the specified drug under given price (Humer, 105): ' ), tab(1), write(A), nl,
		drug_date_not_valid(2019-01-28,DRUGNAME1,A1), write('Drugstore address, which has the drug which has expired (date is 2019-01-28): ' ), tab(1), write(DRUGNAME1), tab(1), write(A1), nl,
		ds_hasdrug_address('Orasept', A2), write('Drugstore address, which has the specified drug: ' ), tab(1), write(A2), nl,
		drug_from_group('group3', D), write('Drugs from the given group: ' ), tab(1), write(D), nl,fail;
		
		ds_hasdrug_struct('Enupret',DSDETAILS), write('Drugstore, which has the specified drug (Enupret): ' ), tab(1), write(DSDETAILS), nl,fail;true.
