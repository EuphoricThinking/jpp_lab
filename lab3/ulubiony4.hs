main :: IO()
-- potrzebujemy obliczenia IO, k
--- getLine wynik: obliczenie z wynikiem typu String
main = do
  putStrLn "nAPISZ haskell"
  w <- getLine -- wczytamy wiersz w; to nie jest przypisanie
-- spradzamy , zczy to jest napis haskel
  if w == "Haskell" -- dlaczego nie mamy ==? ponieważ mkiedyś uczyliśmy się pascala. Mu sę uczyliśmy, nie państwo
    then return()
    else do
       putStrLn "Bledna odp"
       main -- rekurencyjny main


{-
zamiast srrzałki
strzałka nie jest przypisaniem
zamiast strzałki w poprzednich przykładach
strza…ła  - wprowadza nazwę dla wyniku onbliczenia
do sugeruje, że robimy, a nic nie roibimy
NIE LICZY WARTOŚCI WYRAŻENIA, TYLKO OBLICZENIE, KTÓRE W PRZYSZŁOŚCI MOŻE ZOSTAC WYKORZYSTANE
lukier do pozwala zapisać obliczen  w takiej poskati: pokdajmey skłądowe oblicznia, mamy możliwość nazwania wyniku obliczenia

eval (Sub x y) = eval x >>= (\n -> (eval y >>= (\m -> return $ n + m)))

n <- eval x   -- wynik obliczeni x nazywamy n
return $ n + m -- własciwe obliczenie
-}


-- pkt c
