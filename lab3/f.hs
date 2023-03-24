{-# LANGUAGE FlexibleContexts #-}

import Control.Monad.Error.Class
-- import Control.Monad.Except
-- import Control.Monad.Error


-- monada - reprezentacja obliczenia

{-
monada
dodatkowy poziom abstrakcji
wczęnsiej funkccja i wartość - wynik

wyniikiem teraz obliczenie, którego wynikiem ta wartość
nie tylko algortym liczący wartość, lecz również inne czynności, np. efekt wyjścia wyjscia
zmiana środowiska - dodatkowe rzeczy mozęmy zakodowc, oprócz obliczenia samej wartości
brak przełożenia na cokolwiek, czymkolwiek wczesniej zamowaliśmy się

mogliśmy ignorować fakt, że obliczenia wykonywane leniwie?

dotychczas wykprystywane mechaniki miały swoje odpowiedniki wcześniej

nie ma haskella bez monad
bez sensu programowniae niemonadyczne

paradygmat programowania proceduralnego, imperatywnego

samodzielna implemetnacja przypisania w Haskellu z wykrozystaniem monad
-}

-- notacja monadyczna przy readIns
{-
wynikiem obliczenie wartości - M przy nazwie funkcji, żeby odróżnić,
jeśli wynikiem monada
-}


-- wynikiem obliczenie
{-
nie zmienia się typ funkcji, tylko typ notacji
Either String [Int] jest teraz monadą
Either jest monadą
klasa monad jest klasą, której instankcjami jednoargumentowe konstruktory typu
either dwuargumentowy - zatem częściowa aplikacja
MOnad (Either e)
częściowa aplikacja jest elementem klasy monad
-}

--

{-
f :: Int -> Int
f x = x + 1
zwraca wynik, wwartość

zwraca OBLICZENIE
return zmienai znaczeniefunkkcji
fM 10 -> Just 11

zwraca monadę liczącą inta
nie wiadomo, co jest reprezentajcę tego obliczenia
fM :: Monad m => Int -> m Int
-- fM :: Int ->  Maybe Int
-- fM x = Just $ x + 1
fM x = return $ x + 1
wynikiem reprezentacja, która będie wynikać z kontekstu
fm x 10 :: Maybe Int wpisane w terminal - wynik JUst 11

fm 10 :: Either tring Int
fm 10 :: [Int]

dzięki notacji monadycznej
wyabstrahowaliśmy reprezentację wyniku funkcji
wynik funkcji może być dowolnego typu, dla którego istnieje instancja klasy MOnad
oszustwo: Monada konstruktory typów

-}
readInts2M :: String -> Either String [Int]
readInts2M :: go [] $ words s where
  go ns  [] = return $ reverse ns
  go ns (w : ws)
    | all isDigit w = go (read w : ns) ws
    | otherwise = throwError $ "Nie liczba" ++ w -- Left również możemyb podmienić tak, by nie odwoływac się do szczegóółów reprezentacji
-- zamiast Left: throwError
-- zamiast Right: return
-- tutaj jest błąd, ale jutro wrócimy do tego
{-
problem dotyczy sygnatury go, której nie napisaliśmy sami - pozostawiona
w niemonadycznej wersji
sam wygenerował sygnaturę, następnie stwierdził, że sygnatura nie podoba się
MonadError [Char] m
m - jednoargumentoy kosntruktor typu, ma dla niego istneić instancja częściowe j aplikacji
monadError do typu String - tu jest problem, ponieważ standard haskella
nie pozwala na umieszczenie w tym miejscu? konkretnego typu
2 definicje haskella: standad i ghc
ghc implementuej język, który jest rozszerzeniem standardu haskella
standard powstał dawno temu
musimy z niestandardowego rozszerzenia skorzystać
uży pragmy FlexibleCOntext i poprosimy o włączenie rozzerzenia, kßóre umożliwi kompilację kodu
pragma - komentarz dla kompilatora, na początku pliku

ograniczmy zmienną typową w sygnaturze za pomocą nie klasy, a częściowego ukonkretnienia klasy

Arti słowami nie potrafi wyrazić :c
czasem trzeba sobie dać spokój z tłumaczenia kodu linijka po linijce,
co dla Artiego jest problemem, ponieważ lubi tłumaczyć linjka po linijsce

peoblem wynika z ograncizeń standadu haskella
ghc nie ma tych ograniczeń, ale domyślnie stosuej, aby zachować zgodność ze standardem

błędu w kodzie nie popełniliśµy, jednak nie jest zgodny ze standardem haskella,
jednak ghc nie potrafi sobie poradzić
-}

sumInts :: String -> String
sumInts s =
  case readInts2 s of
    Left e -> e
    Right ns -> show $ sum ns

{-
podklaa klasy monad: MOnadError

monady mają dwie rzeczy:
return i bind
return daje cyte oblicenie o wyniku takim jak arguent returan

>>= bind składa ze sobą dwa obliczenie 1 arg obliczenie coś tam, coś tam
najlepiej przeanalizować sygnaturę
:i Monad

fM 10 >>= (\x -> return x * 2)
fM 10 >>= fM

fM 10 wynikeim obliczenie 10
za pomocą binda możemy z złożyć z innym obliczeniem
prawy arrgument to nie po prostu obliczenie, tylko funckaj, która dostanie jako argument wynik lwewgo argumetnu binda, da nam jako wynik obliczenie
:t (fM 10 >>= fM)
:: Monad m => m Int

dooprecyzował typ obliczenia, robiąc z niego monadę obliczenia wejścia-wyjścia
?

fM 10 >>= fM :: Wther String Int

bind jest konstrukcją umożliwiająca skłądanie obliczeń w bardziej skomplikowane
,,średnik"

MOnadError
możliwość zbudowania obliczenia, które jest reprezentacją obliczenia porażki
analogia do wyjątów, ale metodą ,,zrób to sam"

wyjątki w haskellu za pomocą monad można zaimplementować
na razie tylko korzystamy z nich
-}


{-
readIntsM - kopia poprzedniej funkcji, zastąþiliśmy RIght przez return ai left przez throwerror
-}


readIntM :: String -> Either String Int
readIntM w
  | all isDigit w = return $ read w  -- chcemy dac obliczenie, którego wynikiem wartość w
  | otherwise = throwError $ "Nie liczba " ++ w

-- chcemy oblczenie wykorzyrać jako skladową obliczenia dla całego napisu
--readInts M :: String -> Either String [Int]
--readInts M
readIntsFromListM :: [String] -> Either String [Int]
readIntsFromListM [] = return []
readIntsFromListM (x:xs) =
  readIntM w >>= (\n -> (readIntsFromListM ws >>= (\ns -> return $ n:ns)))
-- daje nam onlicznie listy wartości liczb, które są dziesiętnie w argumencie zapisane

{-alt równoważne
readIntsFromListM (w:ws) = do
  n <- readIntM w -- ewentualnie? 	n <- readEither w
  ns <- readIntsFromListM' ws
  return $ n : ns

lukier syntaktyczny do to ukryte użycie operatora bind

Traversable t -l lista
-}

q :: String -> Either String String
q s = mapRigth (show . sum) $ readIntsFromListM $ words s

q s = catchError (mapRigth (show . sum) (readIntsFromListM $ words s)) r where
  r s = return $ "Błąd"

-- łącznie jako wartość: oblicenie zakońcone sukcesem, wunikiem obliczenia tekstowa reprexetnacja sumy
-- albo kpńczy się porażką, za pomocą catchError własny napis dodaję
{-
moandy w haskellu potrzben, by uzyskać IO - jedyna rzecz, któa bez monad nieosiągalna
można czysto funkcyjny kod na monadyczną notację przekształcić
Arti nie widzi uproszenia kodu w do oraz return
w czysto funkcyjnym języku brak IO, co rozwiązuje monada IO
styl programownia monadycznego
-}

--catchError (readIntsFromListM $ words s) r where
--  r s = return $ "Błąd"
-- tworzy obliczenie dla listy słów, dla wyniku obliczenia aplikuje złożenie funkji show i sum


sumInts s = f $ q s where
  f (Left e) = "Błąd" ++ e
  f (Right x) = x
{-
sumInts :: String -> String
sumInts s = catchError (ReadIntsFromListM $ words s) f where
  f (Left e) = Right e
-}
--  g (Right x)

{-
  case ReadIntsFromListM $ words s of
    Left e -> e
    Right ns -> show $ sum ns
-}


readIntsDromList' ws = mapM readEither ws
-- skąd map

{-
definicja wyrażeń arytemtycznych, dla których chcemy zdefiniować operacje onliczenia wartoci BEZPIECZNĄ,
która uwzględnia możliwość wystąpienia błędu - dzielenia przez zero

trzeba uzupełnić o inne operacje arytmetyczne
-}

data Exp = Val Int | Div Exp Exp
safediv :: Int -> Int -> Maybe Int
safediv _ 0 = Nothing
safediv x y = Just (div x y)


-- jako wynik: obliczenie wartości wyrażenia
eval :: Exp -> Maybe Int
eval (Val n)   = return n
eval (Div x y) = do
  n <- eval x
  m <- eval y
  safediv n m
-- skłąda z obliczenia lewego i prawego argumentu, z wyniku funkcji safediv
-- naalogicznei można poozstąłe przypadki


evalList :: Exp -> Maybe [Int]
evalList [] = []
evalList (e:es) = do
  x <- eval e
  xs ,- evalList es
  return $ x : xs


evalLuist' :: [Exp] -> [Maybe Int]

