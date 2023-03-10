import Data.Char

-- :: (Integral t, Eq a) => a -> [a] -> Maybe t
indexOf :: Char -> String -> Maybe Int
--indexOf c [] = Nothing
indexOf c (x:xs) = go 0 c (x:xs) where
  go _ _ [] = Nothing
  go n c (x:xs)
    | c == x = (Just n)
    | otherwise = go (n+1) c xs
-- nie musisz pisać c, ponieważ jest widoczne?


positions :: Char -> String -> [Int]
positions c (x:xs) = go 0 c (x:xs) where
  go _ _ [] = []
  go n c (x:xs)
    | c == x = n : go (n + 1) c xs
    | otherwise = go (n + 1) c xs
-- to nie jest rekursja ogonowa

positions' :: Char -> String -> [Int]
positions' c (x:xs) = go 0 (x:xs) [] where
  go _ [] ys = reverse ys -- dodane reverse
  go n (x:xs) ys = go (n + 1) xs ys'
    where ys' = if x == c then n : ys else ys
-- będzie zapisywać odwrotnie
{--
rekursja ogonowa modulo cons
jedyna rzecz po zakończeniu wywołania: doconsowanie wartości
kompilator potrafi to zopytmalizować
wydajniejsza niż klasyczna rekursja ogonowa - nie trzeba obawiać się
--}
--main = putStrln "ech"

--smain :: String -> String
--main = interact smain

--import Data.Char

--showInt :: Int -> String
--showInt a = interact "xd"
-- (chr a) : ""
