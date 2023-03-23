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
