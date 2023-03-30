import System.Environment -- getArgs

putStrLnAll :: [String] -> IO()
putStrLnAll [] = return () -- return unit
putStrLnAll (s : ss) = do
  putStrLn s
  putStrnAll ss

{-
inna wesja (poprawna); prawym arguemnte funkcja
putStrLnAll (s : ss) = putStrLn s >>= (\_ -> putsStrnAll ss)

wariant binda: obliczenie otrzymuje zamiast ufunckji; oczekuje, że argumentem prawym jest monada; pawdziwy średnik: instrukcja lewa, instrcja prawa
pputStrLn s >> putsStrnAll ss


błędne - prawy argument binda hjest FUNKCJA z unit w IO unit, a otrzymuemy IO unit
powinna być funkcja, jest monada
pputStrLn s >>= putsStrnAll ss
pputStrLn - unit, brak pożytku, ignorunjmey


-}
putStrLnAll' :: [String] -> IO()
putStrLnAll' ss =  mapM_ puStrLn ss


main :: IO()
-- z getargs wyciągmy wynik obliczenia, zapuszcamy petlę, która wypisze wszystkie wartości
main = getArgs >>= putStrLnAll

{--
rozwiązanie z wykorzystaniem KOMBINAOTORA MONADYCZNEGO
main :: IO()
main = getArgs >>= mapM_ puStrLn

-}
-- bez argumentu dla putStrnAll - to jest FUNKCJA, niw ynik

{-
kombinator monadyczny - przekształcenia monad
:t mapM_
podkreślenie występuje
dostje funkcję z wartośi c typu A w monadę z wynikiem typu B, jako arguemtn lista wartości typu A, wynik: monada typu unit
-}
{-
nie ma inneg wyjścia - musimy przeczytać komunikat
-}
