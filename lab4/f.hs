import Control.Monad.Reader

{-# LANGUAGE FlexibleContexts #-}

data Tree a
  = Empty
  | Node a (Tree a) (Tree a)
  deriving (Eq, Ord, Show)

ex1 :: Tree Int
ex1 = Node 1 (Node 2 Empty Empty) (Node 3 (Node 4 Empty Empty) Empty)

-- renumber zmodyfikuje drzewo, wyrzucając wartości, zachowując kształt, ale w poszczególnych węzłach zapisując głębokość węzła
-- dwie wersje: z monadami i bez monad
-- IO wbudowe
-- pomcnicza funkcja: na jakiej głębokości
renumberAt :: Tree a -> Int -> Tree Int
renumberAt Empty _ = Empty
renumberAt (Node _ t1 t2) g = -- depth = g
  let
    g' = g + 1
  in
    Node g (renumberAt t1 g') (renumberAt t2 g')

renumber :: Tree a -> Tree Int
renumber t = renumbert t 0


-- monady w środowisku środowisko zawiera informację o głębokości, na któ©ej znajdujemy się
-- rozwiązanie z monadadmi ReadAt monad
{-
MOnadReader podklasa klasy monad
klasa obliczeń w środowiksu typu r
my mówimy, jakie warunki powinno spełniać obliczenie m
(m jest monadą, obliczeniem)
jakie warunki powino spełniać oblczienie, aby bylo obliczeniem wartości w środowisku typu r,
żeby spełniało definicję klasy monadReader
ask - stała, której wartością jest obliczenie typu r
ask służy do odczytania środowiska
zajmujemy się oblczeniami w środowisko
za pomocą ask możemy odczytać środowisko

local = dostaje jako argument pierwszy argument funckję przekstałacaąco środowsiko, drugi - obliczenie, daje obliczenie

wykonać obliczenie w zmodyfikowanym obliczeniu
za pomocą local możemy zmienić środowisko
-}

-- napiszmy funckję, której wartośią oblczenie w środowsiku
-- warto odznaczać dunkchje, których ynikiem onliczenie - np. poprzez duże M
-- renumberM: arguemntem drzewo, da nam obliczenie powodujące przenumerowanie drzewa

-- dla drzewa pustego obliczenie jest postaci return Empty - ioblczienie, którego wynikiem jest drzewo puste
renumberM Empty = return Empty -- obliczenie przenumerowujące drzewo
renumberM (Node _ t1 t2) = do
-- do przekłada się na użycie bind
-- musi przenumerować t1, t2 i dać jako wynik drzewo, którego wartość w korzeniu głębokość aktualna oraz dwa poddrzewa: wyniki przeumerowań t1 i t2
-- 1. odczytaj aktyalne środowisko
-- cecha oblcizeń w środowisku: ask
  g <- ask
  -- obczlienia powinny nastąpić w zmodyfiowanym środowisku - local funckja
  t1' <- local (+1) $ renumberM t1 -- local (const g + 1)
  t2' <- local (+1) $ renumberM t2 -- dadzą przenumerowane poddrzewa
  return $ Node g t1' t2'


-- wynikiem obliczenie skłąda się z 4 części: renumebrM lewe i prawe rekuerncyne wywołania
-- czyste obliczenie retruan
-- czwarta składowa - ask: cecha obliczeń w środowisku
{-
w klasie monad, w naszym języku
monada definiuje język
return i średnik - to cały nasz język (bind to średnik
podklasami klasy monad dokładamy nowe instrukcje
monadReader dokłada instrukcję ask
-- import
haskell kompilator chce, żeby jeśli istnieje ograniczenie na typ m, to poiwnna isnień zmienna

wynik: obliczenie, którego
NA TYP M istnieje ograniczenie na typ obliczeń:
typ onbliczeń powinein być klasy MOnadReader Int
obliczenie w środowisku, które to środowsiko ma wartośc typu int
renumberM jest polimorficzna, jej wynikiem moga być różne repreentację środowiska
od czego zależy, któ©a reprezentajcę otryzmay?
od tego, w jaki sposób uruchomimy to środowisko
MonadReader Int m => Tree a -> m (Tree Int)
trzeba dodac pragmę na początku
typ wartości środowisko jako Int
ograniczenie (Num a) wcześniej

jest zdefuniowa
konstruktor ReaderT, dwa aguemnty: typ wartości środowiska i monada

ReaderT za pomocą newtype
nazwa konsturktora typu, po = nazwa rekordu jedno pole, runReaderT, wartością funkcja z środowisko w obliczenie
funkcja do uruchamiania obliczenia, wyciągania wyniku obliczenia

potzrzebujemy funkcji która uruchomi nam oblicenie
-}
renumber' :: Tree a -> Tree Int
renumber' t = runReader (renumberM t) 0 -- otrzymuemy obliczenie, chcemy wyciągnąć wynik
{-
runReader bierze Reader
transforamtoowór nie byłon aywkładzie? były tego obawiałe się

za pomocą transforamtora możemy uzuepłnić typ obliczeń o nowe cechy, przekształicć monadę
wiele typów w Haksellu zdefiniwanych za omocą transforamtorów monad

reader - typ obliczeń w środowisu typu r?
typ reader konstruujemy z monady identyczonosciowej Data. Fucnto.Identity
readerT do monady identycznościowej w rezultacie: monada, która posiada cechy obliczenia w środowusu r
:i Reader

wartością tyou Reader It jest obliczenie w środowisku Int
renumberM t
później obliczenie mżemy wykonać za pomocą funkcji runReader, któ©a dostaje obliczenie w środowisku typu r z wynikeim typu a - przekażemy wynik renumberM
jako drugi argument - wartość środowiska

dodatkow instancja monadReader: obliczenie w środowusku typu r może być reprezentowane z a omocą funcji, która daje w wyniu wartość typu r

częściowa aplikacja

MOnadrReader cześciowa aplikacja
pragma dlaczego


drugiego argumentu nie podajemy, częściowa aplikacja strzalłki
funkcja jest obliczeniem

return 5 $ 7 -- działa
wrtością return 5 jest obliczenie
:t return 5

head $ return 5
skonkretyzowało się do typu lista wartości typu Int
return 5 jest klasy monad, a dla funckji istnieje instancja klasy monad, zatem można uzywać notacji monadycznej do zapisu funkcji
((+1) >>= (*)) 7
lewy argument - monada; (+1) jest monadą, poineważ istnieje isntancaja klasy monad
MOnad ((->) r)
częściowa aplikacja strzałki 
klasa monad klasą konstruktorową, czyliinstancjami są jednoargumetnowe konstruktory typu
strzałka zaaplikowana fdo typu r jest jednoargumentowym konstruktorem typu
:i Monad

(*) jest operatorem dwuargumentowym, jednka jednym z arguemntów jest wynik obliczenia (+1) - stworzymy wówczas funckję jednoargumentową, zaapllilkujemy do jedneog argumetnu
wiemy, że to jest legalna monada
może być warotścią całego (...)
funkcje również można bindować

r strzał…a jest monadą obliczeń w środowisku r
jeśli chcemy to oblcizenie wykonać w danym środowisku, to tę funkcję, która repzrezentuje obliczenie, moglibyśmy zastosować do (wartości?) środowiska

można również:
renumberM t = (renumberM t) 0

renmnber jest polimorficzna: daje jako wynik dfunkcję albo Reader

z runReader daje w yniku Reader, bez runReader - funkcję zwraca

so=konkretyzwać renumberM ponownie:
Tree a -> Reader Int (Tree Int)

dlaczgo nie konrektyzujemy typu
zwraca funckję: poprawna deklaaracja
Tree a -> (Int -> Tree Int)
daje nam monadę funkcyjnąint jako arguemtnt, wynik tree it

MOnadReader sgnatura polimorficzna, pozostałe dwie - konretne
renumberM - otrzymujemy funcję (bez instanjci Shwo) albo reader (również bez instancji Show), zatem renumberM w konsoli powoduje błędy
renumberM example1 :: Reader Int (Tree Int)
typ środowiska jest Int, typ wyniku jest typu Tree Int


Reader to tylko rekord zawierający funkcję, nie mamy instancji SHow dla funkcji, nie mozęmy wypisąć wypisać oblicenia niezaleznie od wybranej reprezentacji
renumber '' t = renumberM t 0 -- nawiasy zbędne, dlaczego?

Tree a -> Int -> Tree Int - z tą sygnaturą renumberM zamienia się w renumberAt

notajacja monadyczna, by zapisać kod imperatywnie
-}


{-
następne: zaimplementować licznei wartości wyrażeń

stałe, zmienne, let, operacje = dodawanie, monożenie lub odejmowanie
potrzbeujemy evalExp któ©e policzy wartość wyrażenia

moglibyśmy funkcyjnie zapisać
-}

type Var = String
data Exp = EInt Int
     | EOp  Op Exp Exp
     | EVar Var
     | ELet Var Exp Exp  -- let var = e1 in e2

data Op = OpAdd | OpMul | OpSub

{-
napisz eval, korzystając z monady Reader
-}

-- pomonicza
-- dla danego wyrażenia -> obliczenie wartości wyrażnia
-- otrzymuje drzewo
-- musimy zdecyodwoać odnośnie reprezentacji środowiska: może mapa? tak, jak poprzednio
type Env = Map.Map String Int

evalExpM (Eint x)
evalExpM (EOp Op Exp Exp)
evalExpM (EVar Var)
evalExpM (ELet Let?)


wyjmij (Just x) = x
wyjmij Nothing = error "Zmienna nie została zdefiniowana"
-- obliczenie czyste, którew=go wynieim warotść stałej
evalExpM (Eint x) = return x
evalExpM (EOp f e1 e2) = do
  v1 <- evalExpM e1
  v2 <- evalExpM e2
  return $ f v1 v2
evalExpM (EVar s) = do
  env <- ask
--- wjmiemy z środowiska wartość zmiennej
  -- :m Data.Map :t> Data.Map.lookup
  return $ wyjmij $ Map.lookup s env -- pod kluczem s w mapie? środ env
-- wynikeim jest maybe, a checmy konkretną wartość
-- Arti na razie bez pomysłu, na razie errorem przerwiemy obliczenia

evalExpM (ELet s e1 e2) = do
  v1 <- evalExpM e1
  local (Map.Insert s v1) $ evalExpM e2



-- co dzieje się?
evalExp :: Exp -> Int
evalExp e = evalExpM e $ Map Empty-- chcemy obiczenie, które następnie wykonamy w pustym środowisku
-- w EOp mamy nie funkcję, tylko stała, zatem potrzebujemy funkcji, która stworzy funkcję
operacja OpAdd = (+) -- resztę podobnie
-- wydzieliiliśmy z obliczenia wyrażnei funkcję, która daje obliczenie
-- uruchomiliśmy monadę funkcyjną
-- za pomocą monadReader
-- błędy, nie kompiluje się
