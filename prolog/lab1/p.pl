p(10).


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


% wnuk(Wnuk, Babcia/Dziadek)
% rlwrap sicstus -> uruchomi sicstus w trybie, w którym działa strzałka w górę
przodek(X, Y) :- rodzic(X, Y).
przodek(X, Y) :- przodek(X, Z), przodek(Z, Y).

% dobrze: :- rodzic, przodek taka kolejność
/*
zapętlenie predykautu przodek następuje
deklaratwynie w porzadku ale program jest błędny
semantyka operacyjna nie jest najłatwieeszym spsopobem na anliazę progrmau
sld2 rezolucja 
zbió© formuł logicznych, nie procedur
datalog - ograniczon prolog, okołobazodanowe rozwiązania
dekklaratywne i operacyjne sposoby rozumienia programu

sld drzewo historia wykonai aprorgamu prologowego
wykonanie programu wymaga przejścia całego sld drzewa
jeśli jest nieskończone - zapętli się
wężl y to zapytania
krwaeędzie wyznaczone przez klauzule wybranego atomu (pierwszego z lewej atomu)
wybieramy na wszystkie możliwe sposoby klauzulę dla danego atomu

atom - elementy rozdzielone przecinkiem przode(a), przodek(b)

prologowa egułą wyboru wymaga pierwszego atomu w kaluzuli
zamiana kolejności atomów nie zmienia

sld drzewa powinny być skończone

wykona zarówno kaluzulę z rodzicem, jak i z przodkiem - nie istnieje ELSE,
prolog jest niedeterministyczny - sprawdzi obie kaluzule

reguła prologowa wyboru: pierswszy wybór atomu
1=2, wyrz-=true
zwróci false, ponieważ pierwsze false

przodel(jan, jasio), 1=2
porażka w miejscu 1=2 powróß o punktu nawrotu, co sprawia, że pętli się
enter przyjęcie pierszej odpowiedzi - bez pętlenia
punkt nawrotu umożliwia wybrnie nieskończonej gałęzi w sld drzewie

przodek(jan, X), X = 5.
Porażka przy stwierdzeniu jasio == 5
*/
przodek(X, Y) :- przodek(Z, Y), rodzic(X, Z).


nat(0).
% dwukrotne zastosowanie klauzuli reukrenycjnej - rozpakowanie s-ów

/*
od lwe=wewj do prawej drzewo przeierzamy, odpowiedzi zwiąane z węzłami sukceu
nat(N) w kółko wchodzi w s(s(s(0))) reukruencyjnei zwielokratnia s
nieokreślona zmienna - dopasowuje do s(N)

nat(17) porażka - 17 nie uzgnadnia się z 0 ani z s(N)
*/
nat(s(N) :- nat(N).

/*
nat(N), N=17
n=17 PRZECHODZI PORAŻKĘ, ALE nat(N) pętli się

N=17, nat(N)
porażka po prostu
,,przypisaliśmy" najpierw N=17, uruchomiliśmy nat(17)

w pierwszym przyapdku napjpierw dzialaliśmy na NIEokreślonym N, później N=17

PRZECINEK JEST KONIUNKCJĄ

co, jeśli zmienimy koeljnosć klauzul (unarna na koniec)
nat(s(N)) ...
nat(0).
SKRAJNie lewa gałąź nieskońćzona
synowie uporząkdkowani w kolejnoci zapisu w programu

wcześniej: skrajnie prawa gałąź nieskończona
przechodzimy od lewej od prawej, czyli teraz nigdy nie wejdziemy do sukceu

koeljność atomów w treści klauzuli może mieć wpływ na SLD drzewoL czy jest skończone, czy nie
*/
% p1 drzewo od 20 skończone
% p2 dzrzewo od 20 nieskończone
p1(X) :- q(X), r(X).
p2(X) :- r(X), q(X).
q(10).
r(X) :- r(X).

% plus(X, Y, Z) x + y = z wielkie litery wszędzie
plus(0, 0, 0).
plus(s(x), Y, s(z)) :- plus(X, Y, Z)
% niejednoznaczna definicja, chociaż poprawna
plus(x, s(y), s(z)) :- plus(x, y, z)


% poprawnie, jednokrorny sukces
plus(0, N, N)
% pierwszy argument w pełni ustalony - nie zastsujemy równoczęsnie pierwszej i drugiej klauzuli
plus(s(x), Y, s(z)) :-  plus(x, y, z) % zostaw pierwszą z dwóch wersji

% wyniki dla zapytań określonej postaci
plus_nadgorliwy(X, Y, Z) :- nat(X), nat(Y), nat(Z), plus(X, Y, Z)

% pytamy, jaki iks jest sumą 2 + 3
plus(s(s(0)), s(s(s(0))), X).
plus(X, X, s(s(s(0))). % fałsz
plus(X,X,s(s(s(s(0)))). % 4/2
plus(_X, _X, s(s(s(s(0))))). %pytanie o to, czy 4 jest parzyste?

/*
-X, +X 
+ ustalone
- nieustalone
plus(+X, -Y, +Z)
konwencja
? oznacza albo tak, albo tak

dziedzina zapytań, w ktrych predykat działa prawidłowo
plus(s(s(s(0))), X, Y).
% otrzymamy odpowiedź: kolejne wywołąnia reukurencyjne zdjemują jednego s z pierwszego, jednego s z trzeciego
% jeśli dowolny z nich ustalony - zatrzymamy się
% odp.: 3 + X = Y
% odp. Y = s(s(s(0))).
% ogólny opsi wszysktich par x, y dla których ustalona relacja

plus(x, s(s(s(0)))), Y). nieskońćzenie wiele sukcesów; poprawne odpowiedzi, ale zapętlił się
SLD drzewa dla wybranych zapytań powinny być skończone
*/
