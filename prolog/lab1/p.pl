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
% S jest wynikiem scalenia wyniku sortowania listy pustej z S
insort([], S, S).
% prawa: jeśli S jest wynikiem posortowania listy S z A1, to S jest również wynikime scalenia
% X | L z listą A
% myśleć o kodzie jak o pętli, w której w kolejnych obrotach
insort([X | L], A, S) :- insert(A, X, A1), insort(L, A1, S).


% testując ozwiązanie, sprawdzamy wszystkie odpowiedzi - nie satysfakcjonuje nas, że pierwsza poprawna - wszystkie powinny być poprawne
% jeśłi tylko jedna jest poprawna - powinien być jednokrotny sukces z daną odpowiedzią
% bez większej liczby sukcesów w SLD drzewie

% ostatnie zadanie ze scenariusza
% predykat środek, nienaturalna kolejność argumentów, drugi argument (lista) ustalony

% środokowy element z drugim argumentem uzgodnij
% na siłę: policz długość listy L, upewnij się, że nieparzysta, podziel przez 2, wynik + 1 (nieparzysta) wyznacza pozycję środkową, szukamy elementu na środkowej pozycji
% term o reprezentacji liczby bez sensu - wartośc liczby liczbą wystąpień?
% liczenie wystąpień consa w liście reprezentującej liczbę
% przyjmujemy na potrzeby zadania - lista reprezentacją, wartość reprezentowana to długość liczby
% wówczas możemy posłużyć się listą L jako reprezeentacją jej wałasnej długości
% lista sama swoją długość reprezentuje

% Agata's idea in C: turtle and hare
% co drugi element bierzemy do listy
% element E bierzemy, by uzgodnić arguemnt
% drugi i trzeci argument - dwa wskaźniki, za pomcą których przechodzimy po liście

% środek(?E, +L)
srodek(E, L) :- srodek(E, L, L).
srodek(E, [E | _], [_]).
% klauzula unarna: 
% kiedy na trzecim argumencie mamy jeden element(nieparzysta długość, co drugi zabieramy) - środkowy element zostaje
srodek(E, [_ | L1], [_, _ | L2]) :- srodek(E, L1, L2).
% porównaj rozwiązanie prawa strona


% X is 2*2
% X is W* Y błąð drugi argument MUSI być ustalony. Mogą być zmienne, jednak nie mogą mieć nieustalonej wartości
% is uzgadia wartość wyrażenia z praway arguemtem
% liczy wartości praweog argumentu
% 2+2 is 2*2 // lub 4 porażka; zwykłe uzgadnianie
% 2+2 = 4 false, ponieważ po lewej mamy dodawanie dwóch liczb, a po prawej tylko czwórkę

% ;iczy wartość prawego, uzgadnai z leweym
% 4 is 2 + 2 true


% porównywanie nie za pomocą =, tylko =:=
% =:= liczy wartość obu wyrażeń, następnie próbuje uzgodnić wartości obu
% =\= nie równa się

% technika z akumultaorem - na początek bez akumulatora

% suma(+L, ?S)
% nieogonowo
suma([], 0).
% ważna kolejnośc- wpp. komunikat o błeðzie: niewystarczająco ustalone argumenty (S0 jeszcze nieustalone, gdyby zamienić po przecinku i przed przecinkiem
suma([X | L], S) :- suma(L, S0), S is S0 + X. 

% ogonowo
suma(L, S) :- suma(L, 0, S).
suma([], S, S).
% A1 jako następnik A, nowy akumulator liczę, dodając do starego wartość X
suma([X | L], A, S) :- A1 is A + X, suma(L, A1, S).

% dla jakiej trójki argumentów zachodzi suma(X, Y, Z)?
% suma([3,1,2], 50, ??) ?? to 56 deklaratywne znaczenie predykatu suma(...) trójargumentowego
% S jejst sumą elementów listy L, jeśli S jest sumą elementów listy L i 0

% długość(+L, ?K)
% nieogonowo
dlugosc([], 0).
dlugosc([_|L], K) :- dlugosc(L, K0), K is K0 + 1.

% istnieje predykat length, tak samo działający

% ogonowo
dlugosc_list(L, K) ;- dlugosc_listy(L, 0, K).
dlugosc_listy([], K, K).
dlugosc_listy([_ | L], A, K) :- A1 is A + 1, dlugosc_listy(L, A1, K).

% dlugsoc_list -> pelna nazwa
% dlugosc(L, 5) SLD nieskończone
% standardowy lenfth daje jednokrotny sukces - drzewo skońćzone

% dlaczego nasze z pierwszym nieustalonym nie sprawuje się?
% length rozpoznaje, z jakim stopniem ukonkertnienia został wywołany
% var(X) -- true, jeśli X nieustalone

% predykat lista o długości: ustalonadługość K, uzgadnia] drugi argumetn z listą o długości takiej, jak pierwszy argument
% lodl(+K, ?L)
% lista_o_dlugosci 
lodl(0, []).
% PĘTLI SIĘ: lodl(K, [_ | L]) :- K1 is K - 1, lodl(K1, L).
% wciąż zapętlenie, ponieważ zawsze możemy rekurencyną klauzulę możemy wybrać
% kiedy nie powinniśmy jej wybrać?
% jeśli K większe od zera - wtedy powinniśmy zastosować; dopiszemy warunek do klauzuli
lodl(K, [_ | L]) :- K > 0, K1 is K - 1, lodl(K1, L).

% wersja z var
dlugosc(L, K) :- nonvar(K), lodl(K, L).
dlugosc(L, K) :- var(K), dluosc_listy(L, L).

% teraz działa jak length
% uniwersalny predykat, uniwersanie trzeba sprawdzić ręcznie - spradzamy, z kßórym pobrlmem walczymy i decydujemy, które rozwiązanie

% swojskiego var(...) stwrzymy, jesli wprawdzimy przecięcie

% min(L, M)
% sukces wtw., jeśli argumentem lista niepusata
% nieogonowo
minng([X], X]).
minng([X | L], M) :- minng(L, M0), min(X, M0, M).
% potrzebujemy predykatu min trójargumentowego, który liczy wartość minimalną z dwóch i uzgadnia z trzecim
min(A, B, A) :- A<B.
min(A, B, B) :- A>= B.

% wersja ogonowa

% min(L, M)
min([X | L], M) :- min_pomoc(L, X, M).
min_pomoc([], M, M).
min_pomoc([X | L], A, M) :- min(X, A, A1), min_pomoc(L, A1, M).

% zwróć uwagę na predykat min - minimum z dwóch liczb; pozostanie pnunkt nawrotu, który pogarsza efektywność programu
% odcięcie zastosuemy - usuwamy punkt nawroty; akceptjmey wybór aktualnej klauzuli i usuwamy punkt nawrotu

min(A, B, A) :- A<B, !.
min(A, B, B) :- A>= B.

% wykrzyknik to odcięcie; nic wspólnego z negacją
% odcięcie jest prawdą - można zadać zapytanie
/*
ŹLE: myślimy, że po wybraiu pierwszej odcięcie zatryzma, natomaist jeśli pierwsza niespełniona - musi być druga
niekiedy miin udzieli błędnje odpowiedzi
możliwy wybór drugiej kklauzuli w chiwli, kiedy A < B
odcięcie w treści klauzuli, trzeba najpierw wybrać kauzulę, trzeba uzgodnić atom z nagłówkiem klauzuli
jeśli przekażemy jako trzeci argument wartość ustaloną
przekaż na trzecim argumencie cos innego, niż na pierwszym
dobrze: drga klauzula potwierdza słuszność
min(A, B, A) :- A<B, !.
min(A, B, B).
*/

% należy uważać na odcięcie, nie intepretować naiwnie, proceduralnie
% ocięcie powinno być stosowane do poprawy efektywności programu, o którym juz wiemy, że jest poprawny
% odcięcie zielone - odcięceie, które nie zmienai znaczenia proramu; po suunięciu ptgram działa tak samo
% w noramlnych okolciznościach - odcięcia zielone sa dobre; stylistycznie właściwe
% odcięcie czerwone
% nie używamy odcięć czerwonych (raczej)
% pisząc definicję musimy zagwarantować, że predykat będzie działać tak samo dobrze po usunięciu odcięcia
% dodanie wykrzyknika nie zmienia, że napisalusmy błędną defeinicję
% odcięcie to jedynie OPTYMALIZACJA - optymalizacja to JEDYNE własciwe
% powoduje odcięciei fragmentów SLD drzewa - fragmentów, o któ©ych wiemy, że zbędne, gdyż bez żadnego sukcesu

% moj var - uzgandnianie dwóch różnych ,,dziwnych" rzeczy
% jednak Arti wycofał się z zadania :c


% odwroc(+L, ?R). oba ustalone lub drugi nieustalony
% nieogonowo
odwrocng([], []).
odwrocn([X | L], R) :- odwrocng(L, R0), append(R0, [X], R).

% na każdy element listy doklejamy na koniec - kwadratowo
% append jst zaimplementowany tak, jak scal - liniowy wzglęðem długości listy będącej pierwszym argumentem


% ogonowo
odwroc(L, R) :- odwroc(L, [], R).
odwroc([], R, R).
odwroc([X| L], A, R) :- odwroc(L, [X|A], R).
% liniowy koszt - tyle uzgodnień
% niektóre rozwiązania w prologu - ten sm schemat, co w haskellu

% palindrom(Slowo)
palindrom(Slowo) :- odwroc(Slowo, Slowo).


% odwrocng drzewo nie jest skończone; wybór dla R - gałąź (tragedia), jeśli w drugiej części wywołamy z parą argumentóœ nieustalonych
% da odpowiedź, później pętli się
% w odwroc również nieskończone


% var próbujemmy uzgdoić arguemtn ze stałą Ala i stałą kot
% jeśli oba zakońćzone powodzeniem - jest zmienną
% wykorzystamy odcięcie *.*

nie_ala(ala) :- !, fail.
% fail standardowy predykat, ktory zawsze odnosi porażkę
nie_ala(_).
% nie ala sprawda, czy argument nie uzgadnia się ze stałą ala
% efekt ywkrzyknika możemy poróœnać do negacji
% negację ala(...) implementuje nie_ala(...)

nie_kot(kot) :- !, fail.
nie_kot(_).

moj_var(X) :- nie_ala(X), !, fail. % ni uzgadnia się: odcięciem usuwamy resztę, jeśli nie uzgadnia się
% nie_ala odniosło porażkę i NIE doszło do odcięcia, próbuemy dopasować z kotem
moj_var(X) :- nie_kot(X), !, fail.
% ani jedno, ani drugie
moj_var(_).


% kot i ala to stałe (zmienne wieką literą zapisywane). Uniwersum Herbtandta. Wiemy, ze kot i ala to stałe, ale nie wiemy, CZYM są
% w prologu definiujemy PREDYKATY, żadnych zmiennych czy stałych

% definicje nie_ala i nie_kot bardzo podobne, możemy połączyć w jedną

% nie(X) % da sukces, jeśli prób udowodnienia atomu zakończy się porażką

nie(X) :- X, !, fail.
nie(_).

mojvar2(X) :- nie(X = ala), !, fail.
mojvar2(X) :- nie(X = kot), !, fail.
mojvar2(_).

% nie p©óbuje udowodnić X
% dowód X odniesie sukces - ucinamy klauzulę, po czym generujemy oprażkę
% za pomocą odcięćia zdefiniowaliiśmy negację
% \+ negacja w prologu -> dziwny znaczek

% to jest alternatywa (niezalecana)

% alterantywa; dopsuje pierwsze nie(X) do ali, alternatywa prawdziwa, do nie(x) przechodzi sukces
mojvar3(X) :- nie(nie(X=ala); nie(X = kot)).
% mojvar3 odniesie sukces, jeśli odniesie porażkę proba uzgodnienia z X z ala lub próba uzgodnienia X z kot
% nie(X) sprawdza, czy X można udowodnić
% swi not albo \+

mojvar4 :- nie(nie(X = ala)), nie(nie(X = kot)).

% nie działa:
mojvar_zle(X) :- X=ala, X=kot. % zawsze odnosi porażkę

% srawdzi, czy argument jest listą stałych? 
% na siłę: policz, ile sztuk A, poilciz, ile sztuk B
% bez arytmetyki, ponieważ wówczas prostszy

% reprezentacja liczby jako lista
% akumuluje stałe a
slowo(Slowo) :- slowo(Slowo, []).
slowo([a | L], A) :- slowo(L, [a | A]).
% slowo([b | L], A) :- rowna_dlugosc([b | L], A).
slowo([b | L], A) :- rowna_dlab([b | L], A).

rowna_dlugosc([], []).
rowna_dlugosc([ _ | L], [b | K]) :- rowna_dlugosc(L, K).
% z _ zamiast b przechodziły testy aaaba np.
rowna_dlab([], []).
rowna_dlab([a | L], [b | K]) :- rowna_dlab(L, K).


% złożonosć w prologu liczymy, stierdzając, ile jest uzgodnień
slowo2(Slowo) :- slowo2(Slowo, []).
slowo2([a | L], A) :- slowo2(L, [b | A]).
%slowo2([b | L], A) :- [b | L] = A.
slowo2([b | L], [b | L]). %uzgadniamy

% slowor(Zdanie, Reszta) sukces, jeśli a^nb^n opłączone z Resztą; Zdanie = Słowo*Reszta
slowor([a|L], A) :- slowor(L, [b|A]).
slowor([a, b | L], L). % Co najmniej jedno a, b

slowor2([a, a|L], A) :- slowor2([a|L], [b|A]).
slowor2([a, b | L], L). % Co najmniej jedno a, b

slowo_akbkanbn(L) :- slowo_reszta(L, L1), slowo_reszta(L1, []).
% mozna również słowo zamiast durgiego
% slowor := slowo_reszta
% Jak myślec o działnu?
% otzyamlismy wjeści,e które chcemy sprasować
% w wywołujemy slowo_reeszta, jeśli poprwany perefiks - uzgadnia drugi arguemnt z tym, co za tym prefiksem
% parsowanie analizy składniwej, omnada state - skojarzenie
% pierwszy argument to wejście, drugi - wyjście w slow_allah_akbar
% monada: wejście jako argument, wyikiem - wyjście?

% bardzo łądne parsery w prologu
% notacaja dcg

% quick sort
% partiotn otrzymuje listę licz, otrzymuje liczbę, ponwinein uzgodnić rzeci arguemt zl listą elemntów listy l, która 
part(+L, +P, -M, -D).
partition([], _, [], []).
part([X | L], P, [X| M], D) :- X < P, !, part(L, P, M D). % wczęsniej bez !
part([X | L], P, M, [X|D]) :- X >= P, part(L, P. M, D).
% istnieje punkt nawrotu

% przed dodaniem odcięcia chciało szuakć dlaje
% odcięcie można zastąpić ładniejszym mechanizmiem, który  ostatecznie sprowadz a się do zstosowania odcięcia 
% if w prologu istnieje
partition2([], _, [], []).
part2([X | L], P, M1, D1) :-
  (
  X < P
    ->
  M1 = [X | M],
  D1 = D
  ;
  M1 = M,
  D1 = [X | D]
  ),
 part2(L,P.M,).

  part(L, P, M D). % wczęsniej bez !
part2([X | L], P, M, [X|D]) :- X >= P, part(L, P. M, D).


mininaczej(A, B, C) :- A < B -> C = A; C = B.
% jeśli A < B odniesie suckes, trzeba dowieść C=A, wpp. dowiedź C = B

% Lepszy styl programowania, jeślil zastąpimy odcięcie ifem strzałeczka i średnik - if else
