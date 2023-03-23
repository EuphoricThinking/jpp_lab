import Data.Char

readInts :: String -> [Int]

--{- mine
--readInts "" = []
--readInts ss = map $ filter (\x -> isDigit x ) $ words ss
readInts s = map read (filter (all isDigit) (word s))

-- . złożenie funkcji
-- readInts' = map read . filter (all isDigit) . word
-- isDigit jak działa

-- map read $ filter(all isDigit) $ words s
--readInts s = words s

{-
krok w kierunku parsowania danych - teraz nie ignoduejmy błędów
-}

readInts2 :: String Either String [Int]
readInts2 :: go [] $ words s where
  go ns  [] = Right $ reverse ns
  go ns (w : ws)
    | all isDigit w = go (read w : ns) ws
    | otherwise = Left $ "Nie liczba" ++ w

sumInts :: String -> String
sumInts s =
  case readInts2 s of
    Left e -> e
    Right ns -> show $ sum ns
