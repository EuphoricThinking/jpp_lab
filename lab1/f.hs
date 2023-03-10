incAll :: [[Int]] -> [[Int]]
incAll [] = []
incAll (x : xs) = f x : incAll xs where
  f [] = []
  f (y : ys) = (y + 1) : f ys

iA :: [[Int]] -> [[Int]]
iA [] = []
iA (x : xs) = (map (+1) x) : iA xs

iA' :: [[Int]] -> [[Int]]
iA' xs :: map (\ys -> map (+1) ys) xs

iA'' :: [[Int]] -> [[Int]]
iA'' xs :: map (map (+1)) xs  -- częściowa aplikacja funkcji

iA''' :: [[Int]] -> [[Int]]
iA''' = map (map (+1)) xs
-- map $ map (+1) -- częściowa aplikacja map

--foldl :: (b->a->b) -> b -> [a] -> b
{--
wielokrotnie aplikują funkcję
wartość początkową ustal
--}

silnia n = foldr (*) 1 [2..n]

-- concat xs = foldr (++) [] xs
-- przekornie foldl zapisane

-- :set +s   // ghci będzie informować o koszcie wykonania każdego wyrażenia

-- replicate buduje listę będącą powieleniem

nub [] = []
nub (x:xs) = x : nub $ filter (\y -> y /= x) xs -- ?

-- iloczyn skalarny do domu

-- generowanie trójek - wstęp do zadania trzeciego

triples :: Int -> [(Int,Int,Int)]
triples n =
  let
    ns = [1..n]
  in
    [(x, y, z) | x <- ns, y <- ns, z <- ns] -- x /= y, y /= z, z/=x aby tylko różne

-- triads do domu

incMaybe :: Maybe Int -> Maybe Int
incMaybe Nothing = Nothing
incMaybe (Just x) = Just(x + 1) -- JUst $ x + 1

addMaybe :: Maybe Int -> Maybe Int -> Maybe Int
addMaybe Nothing _ = Nothing
addMaybe _ Nothing = Nothing
addMaybe (Just x) (Just y) = Just $ x + y -- (x + y)
 {--
alternatywnie: just, just
 _ _ = Nothing, gdyż nie załapaliśmy się na pierwszy
--}

-- rekursji ogonowej nie odpuszczamy
{--
wywolanie rekurencyjne ostatnią czynnością wykonaną w funkcji

silnia n = n* silnia(n-1) to nie jest rekursja ogonowa, oniweważ po wyjściu
z rekursji wykonujemy jeszcze czynność - mnożymy razy n

akumulator - wynik pośredni obliczenia podajmey dodatkowo
--}


silnian :: Int -> Int
-- INteggral t => t -> t
-- go jako funkcja zanieżdżona pomocnicza
silnian n = go n 1 where
  go 1 w = w
  go k w = go (k - 1) (w*k)


-- reverse' (x:xs) reverse' xs ++ [x]  // niewdajne
-- reverse' [] = []
