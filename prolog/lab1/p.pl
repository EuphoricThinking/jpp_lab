p(10)


%ojciec(Ojciec, Dziecko)
ojciec(X,Y) :- dziecko(Y, _, X).
/*
jeśli Z zamiast _ ostrzeżenie otrzymujemy
ostrzeżenie ważniejsze
implementacja prologu niewiele zdziała w kwestii wskazywania błędów w kodziee, kßóre mmoże zauważyć, np. literowki w nazwie zmiennych

singleton: zmienne, które są singletoanmi - zmienne w klauzuli, które wytępują tylko razo
oznacza brak znaczenia danej zmiennej wówczas
*/
ojciec(Ojciec, Dziecko) :- dziecko(Dziecko, _, Ojciec).
% matka analogicznie

/*

*/
% rodzic(Rodzic, Dziecko)
% ŹLE
% rodzic(X, Y) :- matka(X, Y); ojciec(X, Y).

/*
niezgodnie z regułąmi sztuki
ŚREDNIK TO ZŁY STYL PROGRAMOWANIA
TRZEBA ZDEFINIOWAĆ ZA POMOCĄ DWÓCH KLAUZUL
*/
% WŁAŚCIWY SPOSÓB
rodzic(X, Y) :- matka(X, Y).
rodzic(X, Y) :- ojciec(X, Y).

% babica(Dziecko, Babcia) włąsciwa kolejność arguemtnóœ - odpowiedź istatnim argumenem, jest dobrze
babcia(X, Y) :- rodzic(Z, X), matka(Y, Z).
