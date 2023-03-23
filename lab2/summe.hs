import f

-- NAZWA MODUŁU WIELKĄ LITERĄ

{-
interact fdal funkcji obliczenie IO
-}

main :: IO ()
-- runhaskell summe.hs
main = interact $ (++ "\n") . sumInts
