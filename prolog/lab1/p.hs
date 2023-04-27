{-
programowanie w logice - prolog
istnieją również inne języki

dodatkowe zależności, wspierające programowanie imperatywne?
poza paradygmat programowani aw logice nie przejdziemy
kilka ywyjątków: wejście-wyjście

bardzo niska ocena, nawet jeśli w prologu napiszemy]
tylko programowanie w logice do zastosowaniad

2 implementacje prologu na students
nie wszystkie dobrej jakości
czasem implementacja jezyka, który prologiem nie jest
nie sięgaj po cokolwiek, co nazywa się prolog
swi sixtus dwie implementacje na students

swi można na sowim okomptereze, darmowa
sixtus - komerycjny
sizxtus impleemntcjae wszystkiego, co jest ważne w optymalizacji

procedura := predykat

X wielką literą - idetyfikator wielką literą - nazwa zmiennych
małe litery - stałe i symbole funkcyjne

4=2*2
4 całkowita liczba
2*2 wyrażenie fukncyjne z gwiązdką joko gł owne coś tam, coś tam
X*y=3*7 sukces
spytałem prolog, czy SPEŁNIALNE dla X=3 i Y=7
enter := koniec odpowiedzi
; := prolog szuka kolejnych wartościowań

, := koniunkcja
; := alternatywa
X*Y=Z*5, (Z=7; Z=9)
no, kiedy wyczerpią się
sukces wilokrotny, z każdym sukcesem związana obliczona odpowiedź
-}
{-
swipl nowy prolog
jeśli bez innych odpowiedzi - be zmoślżliwosci wciśnięcia średnika
sicstus umożliwiał wciśnięcie ś©ednika nawet w przyapdku braku dodatkowych odpowiedz

?= [user]
p(10) perdyjar o nazwie p
realcja p zachodzi dla 10
p(x*y):-q(x), q(y)
dwie klauzule definiujące
:-    szczątkowa strzałka; zapis implikacji
krropkami kończymy

q(1)
q(2) odpowiedzi true/false
q(X) dla jakich X zachodzi

X to nie jest zmienna, żadnych zmiennych w prologu nie deklarujemy
czasem niektóre rozwiązania podobne  w haskellu i prolou

w prologu trzeba napracować się, by nie przeszedł kompilacji

listing(p)
wypisanie definicji predykatu P

lab1.pl

?- [lab1]. w nawiasach klamrowych ładowanie

/* */ komentarz
% do konca wiersza

argument, który naturalnym wynikiem - powinien być na końcu
dziecko(Dziecko, Matka, Ojciec)
pierwszy arguemtn na koniec, aby uzyskać dziecko dla dancyh rodziców

dziecko(ja, X, Y)
X = zofia
Y = adam

otrzymujemy wartościowania dka danego dziecka
dziecko(X,X,X)
false jako odpowiedź - nie istnieje
Pytamy, czy istnieje X, któy jest swoimi rodzicami

podkreślenie _ oznacza zmienną, w przypadku której mówimy, że nie intetresuje nas wartościowanie
dizecko(_, ewa, jan)
true - pytanie, czy Ewa i Jan mają jakieś dzieci
-}
