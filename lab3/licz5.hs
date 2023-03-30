import System.Environment
-- pkt c
-- nazwa pliku albo brak arguementów

--wczytaj wguent

main : IO ()
main = do
  argumenty <- getArgs
  case argumenty of
    [] ->
-- wartością stałej getConetns jest obliczenie IO, które daje jako wynik całą zawartość standardowego wejścia
    --nazwa pliku - jeden arguemtn; chcemy odczytać zawartość
   -- otrzymuemy obczlienie IO, które złożymy z funckją przetwó©z 
   [s] -> readFile s >>= przetworz
    _ -> putStrLn "Program oczekuje 0 lub 1 args"

przetworz :: String -> IO()
przetworz s = putStrLn $ show $ lenfght s

{-
inna wersja
przetworz = putStrLn . show . lenfght

obliczenia są leniwe
-- na azie liczy tylko znaki;
zadanie o heksach - zadanie trzecie warto zrealizować
zajrzyjmy do scenariusza czwartego przed zajęcimi
-}
