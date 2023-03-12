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

incAll :: [[Int]] -> [[Int]]
--incAll [[]] = [[]]
--incAll xs = [map (\x -> x + 1) y | y <- xs]
--incAll xs = map (map (\x -> x + 1)) xs
incAll = map (map (+1))

-- silnia n = foldr (*) n [1..(n-1)]
silnia n = foldr (*) 1 [2..n]

suma n = foldr (+) 0 [1..n]

concat' :: [[a]] -> [a]
concat' [] = []
concat' n = foldr (++) [] n

nub :: (Eq a) => [a] -> [a]
nub [] = []
nub (x:xs) = x : nub ( filter (\y -> y /= x) xs)

scalar :: [Int]->[Int]->Int
scalar [] _ = 0
scalar _ [] = 0
scalar xs ys = foldr (+) 0 $ zipWith (*) xs ys


triples :: Int -> [(Int, Int, Int)]
triples n
  | n <= 0 = []
  | otherwise =
      let
        ns = [1..n]
      in [(x, y, z) | x <- ns, y <- ns, z <- ns]

triads :: Int -> [(Int, Int, Int)]
triads n
  | n <= 0 = []
  | otherwise =
      let
        ns = [1..n]
      in
        [(x, y, z) | x <-ns, y <- ns, z<- ns,
                     (x*x) + (y*y) == (z*z),
                     x <= y, y <= z]


triads' :: Int -> [(Int, Int, Int)]
triads' n
  | n <=0 = []
  | otherwise =
      let
--        go [] = []
--        go (x:xs) = x:[go $ filter (\p -> p `mod` x /= 0) xs]
--        ns = 1 : (go [2..n]) where
        go :: [(Int, Int, Int)] -> [(Int, Int, Int)]
        go [] = []
        go ((e, f, g):xs) = (e,f,g):(go $ filter (\(a, b, c) -> not (a `mod` e == 0 && b `mod` f == 0 && c `mod` g == 0)) xs)
--        ns = 1: go([2..n])
        ns = [1..n]
      in
--          [(x,x,x) | x <- ns]
        go [(x,y,z) | x <- ns, y <- ns, z <- ns,
                   (x*x) + (y*y) == (z*z),
                   x <= y, y <= z]

{--
sieve :: [Int] -> [Int]
sieve [] = []
sieve (x:y:xs)
  | y == [] = [x]
  | xs == [] = [x:y]
  | otherwise = x:(sieve $ filter (\p -> p `mod` x /= 0) xs)
--}
