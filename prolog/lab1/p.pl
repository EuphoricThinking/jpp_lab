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

/*
Predykatów takich jak minus nie definiuje się
*/
% minus wtw gdy x-y=z
minus(X,YX,X) :- plus(Y,Z,X).

% fib(K, N) wtw, N to K-ta liczba Fibo
% najpierw rekurencyjnie
fib(0, 0).
fib(s(0), s(0))
fib(1, 1).
fib(s(s(N)), F) :- 
fib(s(N), F1), 
% pierwszy argument nieustalony? będzie pętlić się
fib(N, F2), 
plus(F1, F2, F).

% alt
% deterministyczny ze względu na pirwszy argument w pierwszej wersji
% wdrugiej wersji fibrec0 cośtam fibrec(s(0), cośtam uzgodnią się
fibrec(N, F) :-
minus(N, s(0), N1),
minus(N1, s(0), N2),
fibrec(N1, F1),
fibrec(N2, F2),
plus(F1, F2, F).

% wersja rekurencyjna wcześniej, teraz iteracyjnie
% pętla, w której przechodzimy po kolejnych parach wartości sąsiadującyhc w ciągu

% akumulator, pomocnicza funkcja
% predykat plus o arności 3? pełna nazwa predykatu
% teraz ujrzymy, jak NIE programować
/*
predykat fibiter o arności 4
*/
fibiter(N, F) :-fibiter(N, 0, s(0), F).
fibiter(0, A, _, A).
% zmienną F ciągniemy za sobą
% pierwszy argument ile wywołań reukrenycjych, dwa i trzy - dwie kolejne liczbyFibo
% dwie zmienne, na których zapamiętujemy liczby
% czwarty argument - zmienna, którą powinien uzgodnić z N-tą liczbą Fibonacciego
% przekazujemy zmienną w głąb ciągu wywołań rekurenycnch
% zmienną na czawartym uzgadniamy z drugim?
% fibiter(+N, -F)
fibiter(s(N), A, B, F) :- plus(A,B,C), fibiter(N, B, C, F).


/*
klauzule unarne nie wygenerują nieskończonej gałęzi
jedynie niebezpieczeństwo w rekurencyjnej klauzuli

fibiter i fibrec z nieustalonym pierwszym argumentem - nieskończone SLD drzewo - błąd, zapętlenie
*/

// prolog ma własną reprezentację list?
// zdefiniuj predykat lista, jeśli L jest listą
% co jest potrzeben do reprezentacji list? potrzebumey listy pustej i dokładania elemetów (const)
nasza_lista(pusta)
% _ zamiast X, by uniknąć ostrzeżeiń o singletpnoe
%nasza_lista
nasza_lista(para(_, L)) :- nasza_lista(L)


% predykat element - tak, by działał na anszej reprezentacji listy
% nie zaczynaj od predykatu porównującego z pustą listą, ponieważ nasz program powinien niczego wóœczas nie zwracać prawdziwego
nasz_element(E, para(E, L)).
nasz_element(E, para(_, L)) :- nasz_element(E, L).

/*
listy w progologu:
[] pusta
bez consa (cons jest ukryty?)
% [10, 20] =.. L.
% =.. predykat o=do spłaszcznani termu
L = ['[|]', 10, [20]]
/*
=.. powoduje uzgodnienie prawego argumentu z listą, któ©ej pierwszym argumentem jest główny symbol funkcyjny
2+3*4=..L.
L = [+, 2, 3*4]
=.. predykat unit

sicstus '.' tak nazywa cons
swi nazwało '[|]'
ukrytwa kropkę, czyli: nie pozwala na jej zastosowanie
w obu mplementacjach ten symbol jest ukryty
aazwczyaj nie potrzebujemy cons, tylko stosujemy lukier syntaktyczny
[10,20,30]=L.
[10,20,30] = L, K = [50 | L]
przed kreską pionową podajemy, co podajemy przed ogonem listy
*/

% prologowa lsta
lista([]).
lista([_ | L]) :- lista(L).
% lista([10,20,30|40]) porażka, gdyż obcinamy elementy z poćżatu listy. Docieramy do 40, której nie mozemy z niczym dopasować

/*
lista(L).
nieustalone elemnty
L =[_1645] wygenerowana anonimowa zmienna
element(X, [10,20,30])
*/

% pierwszy - weź klauzulę unarną predykatu element; E jest pierwszym argumentem consa, za pomocą ktrego została zbudowana
pierwszy(E, [E | _]).

% ostatni
ostatni(E, [E]).
ostatni(E, [_ | L]) :- ostatni(E, L).
% dla ustalonego drugiego argumentu jest deterministycnzy, jednak z nagłowka klauzul to nie wynika,
% ponieważ RÓWNIEŻ dla jednoelementowej listy - wówczas dla listy pustej jako L uruchmoimunie i nie zadziała
% POPRAWNE:
ostatni(E, [_, X | L]) :- ostatni(E, [X | L]).
% nie można uzgodnić drugiego argumentu




/*
podziel(Lista, Nieparz, Parz).
bierzemy dwa pierwsze elementy i dołączamy do elementów parzystych i nieparzystych
*/
podziel([], [], []).
podziel([X], [], [X]). % jednoelementowa lista, numerujemy od zera
% jak powinna wystąpić tutaj lista pusta?
% błąd - myśleliśmy operacyjnie
% długości listy nie zgadzają się - otrzymujemy dłuższą listę
% x, y powinny być w nagłówku
podziel([X, Y | L], N, P) :- podziel(L, [Y | N], [X | P]).

% przenosimy do nagłówka
% zgadza się suma długości list
% jeśli którykolwiek argumetn ustalony - nie zapętli się, gdyż dotrzemy do listy pustej
podziel([X, Y | L], [Y | N\, [X | P]) :- podziel(L, N, P).
% podziel(L, [10, 20], K).

% połączenie dwóch pierwszych klauzul w jedną
% podziel(X,Y,Z) :- member((X,Y,Z), [([],[],[]), ([V], [], [V])]
/*
predykat scal
L3 może być nieystalone
+ ustalone - nieustalone
+ + +
+ + -
*/
scal([], L, L). % scalamy tę samą
scal([X | L], K, [X | M]) :- scal(L, K, M). % tutaj sprawdzamy, czy podane listy są scalone

% element -> member
% scal -> append
% istnieje x, które należy do obu list
% pierwszy predykat member - generator, drugi - tester
% intersect(L1, L2) :- member(X, L1), member(X, L2).

/*
NOWE podziel
*/
podziel([], [], []). % druga okzała się być redundantna, generowała podwójne wyniki
podziel([X|L], N, [X|P]) :- podziel(L, P, N).0


prefiks(P, L) :- append(P, _, L).
sufiks(S, L) :- append(_, S, L).

% wycinek listy - spójny
podlista(P, L) :- append(_, S, L), append(P, _, S).

% niekoniecznie jeden po drugim - podciąg
% podciag(P, L)
podciag([], _).
% ładniej zamiast powyższej podciag([], []) zablokujemy powtórki
podciag([X|P], [X|L]) :- podciag(P, L).
% jeśli nie występuje teraz na liście - musi występować dalej
podciag(P, [_|L]) :- podciag(P, L).


% insertion sort
% pomocniczy predykat insert
% zadana lista, zadany element - wstawia

% lista K z listy L poprzez wstawienie X - posortowane
% insert(L, X, K).
insert([], X, [X]). % na koniec wstawiamy?
insert([Y | L], X, [X, Y | L]) :- X =< Y.
insert([Y | L], X, [Y | K]) :- X > Y, insert(L,X,K).

% rekursja nieogonowa, napismy ogonową
inesrtion_sort([], []).
insertion_sort([X | L], S) :- insertion_sort(L, S0), insert(S0, X, S).

% mniejsze równe z nieustaloną wartością - komunikat o błędzie
% potrzebujmey dodatkowego predykatu w roli akumulatora
insort(L, S) :- inosort(L, [], S).
insort([], S, S).
insort([X | L], A, S) :- insert(A, X, A1), insort(L, A1, S).
