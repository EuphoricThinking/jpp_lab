main :: IO ()
--main = putStrLn "ech"
main = interact reverse


{--
main = interact $ show . positions 'a'
./pozycje_a <lab.hs
częściowa aplikacja positions przekształca napis z istą intów
skłądam z fnckją show
dla listy liczb całkowitych jest zdefiniowana instancja show
czyli jest zdefinoiwa afunkcaj show, która przeskztałaca wartość danego typu w napis

main = interact $ (\s -> show $ positions 'a' s)
interactowi przekazałem FUNKCJĘ, któ©a przekształca napis, wynik przekazuje show i wynik show
przekazuje jako wynik wyrażenia lambda

najpierw do wejścia aplikowana POSITONS 'A' (częściowa)

--}
{--
w programie stała main o typie IO unit - obliczenie wejścia-wyjścia, które nie daje żadnego
wyniku. Obliczenie realizuje efekt wejścia-wyjścia, które powinien był mieć program
efektem ubocznym jest wypisanie napisu, samo w sobie nie daje wyniku (wynikiem jest unit,
czyli para nawiasów

Data MojTyp = Ala | Ma | Kota
  deriving Show

nie można wypisać, pponieważ brakuje instancji
funkcje nie są wypisywalne

oblliczeinia w haskellu są leniwe
--}
{--
./p <p.hs
wejście przekształaca za pomocą reverse, wynik przekazuje na wyjście
--}
{--
ghc kompilator
ghci interpreter
alternatywnie: runhaskell, nie trzeba wówczas kompilować
runhaskell ./p.hs <p.hs
--}
{--
showInt za dużo pracy
czyta tekst,
instance Show a => Show [a]
isntieje instancja show dla listy wartości typu a, jeśli istnieje instncja Show dla a
--}
