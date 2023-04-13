import Control.Monad
import Control.Monad.State

{-
ooblczineein deteerministyczne, którego obliczenie być 5 lub 7

mplus
jak interpretować listę jako monadę

argumetny: listami wartości typu a, interperetacja: reprezentacja oblcizenia, którego wynikiem może być każda z wartośic występująych na liście

dwuelementowa lista, któ©ej pierwzy element wynikiem obliczenia xs, drugi - oblczienia ys
-}

allPairs :: [a] -> [a] -> [[a]]

allPairs xs ys = do
  x <- xs
  y <- ys
  return [x, y]
{-
łląćzeni eze sobą dwoch niedeterministycznych? czy deter ibliczeń
-}


{-
n-elementow ls
da listę n-elemntowych list

jeśli return intepretujemy jako listę elementów danego typu, to tak zostanie zinterpretowany
-}
allComb :: [[a]] -> [[a]]
allComb [] = [[]] -- albo return [], ale dla sameo [] nie działa
allComb (xs : xss) = do
  x <- xs -- kombinacje ogona lsisty?
  ys <- allComb xss
  return $ x : ys
-- dostajemy lisę pustą przy liście pustej,. ponieważ wyniekim powinna być lista list o tej własności że i-y element takiej listy będącej elementemwyniku allCOmb jest elementem i-te listy przekazanej jako agrgument
-- trzeci argument bez takiej listy, zatem wynik pusty
-- notacja monadyczna do zapisu list
-- poznaliśmy nową monadę :>
-- MONADA STATE BĘDZIE POTRZEBNA

{-
klasa oblcizeń ze stanów  - monada state
może mylić się z monadreaer
skojarzenie słuszen: w jenym i drugim przypadku w obliczeniu dostęþ o watrtości
w monad reader tylko odczyt
w mona state ODCZYT + ZAPIS
używamy dlatego śroodwisko i stan
monadreader olczienia w S©ODOWISKU
monad stae w STANIE
środowiska nie mogązmienić, stan można zmienić

monad.state
get i put
get - wynik: obliczenie, którego wynikiem jest aktualny stan
put - obliczenie, któer dla zdanej wartości daje oblczienie z wynikiem unit m()
put zmieni aktualny stan - przypisanie
mamy JEDNĄ zmienną tylko; moze być lista, mapa itp. - coś, co przechowuje wiele wartości

instancja monad state: wartości typu stateT - transformator monad, nie zjamujemy się na razie

monad reader: dwie instancje: wartosć typu reader i instancja dla onady funkcyjnej (funkcjaomże być oblcizeniem w środowiksu)
rozzerzenie włączone - poolimordiczna funkcja, da obliczenie klasy onad reader

wcześniej środowisko jako dodatkowy argument - wówdczas bez monad reader mozna
w monad state podobnie mozna zaimplementować coś podobnego

zmienić typ wyniku funkcji, by adała parę wartości jako wynikiem: rzeczywisty wynik obliczenia oraz nowy stan

przenumerowanie drzewa - niemonadycznie:
zdefiniuj funkcję, która dostaje jako arguemtn drzewo i pierwszy wolny wnumer, jako wynik: para wynikdrzewo i pierwszy wolny wynik po zakońćzeniu numerowania w danym drzewie
-}


data Tree a
  = Empty a
  | Node a (Tree a.. z zadania

renumberTreeIn :: Tree a -> Int -> (Tree Int, Int)
reunumberTreeIn Empty n = (Empty n)
renumberTreeIn (Node x t1 t2) n =
  let
    (t1', n') = renumberTreeIn t1 n
    (t2', n'') = renumberTreeIn t2 (n' + 1)
  in
    (Node n' t1' t2', n'')
-- fst snd pierwszy i drgi element z pary
{-
czysto funkcyjnie można wyknać przypisanie, gdyż wynikie może być własciwy wynik oraz zieniony stan

teraz za pomocą klasy monad state
pomocnicza funckja, której wynikiem obliczenie polegające na przenumerowaniu drzewa

evalState - zadanie obliczenie ze stanem typu s i wynikiem typu a, zadany stan oczątkowy - daje wynik obliczenia
execstate -daje stan końcowy
odpowiednio: first i second to evalState i execState
-}

--renumberTreeM :: (MonadState Int m) => Tree a -> m (Tree Int)
-- problem z flexible context
-- na n nadajemy ograniczenie za pomocą MoandState, dla którego określamy wartość
-- co musiałaby miec konkretna sygnatura
renumTM Epmty = return Empty
renumTM (Node _ t1 t2) = do
  t1' <- renumTM t1
-- teraz chcemy odczytać stan
-- chcemy zmienic stan
  n' <- get
  put (n' + 1)
  t2' <- renumTM t2
  return $ Node n' t1' t2'

-- evalState chce drzewo i stan początkowy
renumberTree' t = evalState $ (renumberTreeM t) 1
