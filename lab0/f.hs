fact1 :: (Integral a) => a -> a
fact1 0 = 1
fact1 x = x * fact1(x-1)

fact3 :: (Integral a) => a -> a
fact3 n | n <= 1 = 1
	| otherwise = n*fact3(n-1)

myzip :: [a] -> [b] -> [(a,b)]
myzip (a:aa) (b:bb) = (a, b):myzip aa bb
myzip _ _ = []

safeHead :: [Int] -> Maybe Int
safeHead [] = Nothing
safeHead (x:_) = Just x

countdown :: Int-> [Int]
countdown x | x <= 0 = [0]
            | otherwise = x : countdown(x-1)

{-
collatz :: Int -> [Int]
collatz x | x <= 1 = [1]
	  | (x:_) = case x of {mod x 2 == 0 -> x : collatz(0.5*x); mod x 2 == 1 -> x : collatz(3*x + 1)}
-}

collatz :: Int -> [Int]
collatz 1 = [1]
collatz n | mod n 2 == 0 = n : collatz(n `div` 2)
          | otherwise = n : collatz(3*n + 1)


col n = n : col (f n) where
  f n
   | mod n 2 == 0 = n `div` 2
   | otherwise = 3*n + 1

{-
co n = n : co nastepny wheer
	nastepny
	n zostaje
-}

last1 :: [a] -> a
last1 [] = error "Lista pusta bez ostatniego elementu"
last1 [a] = a
last1 (_ : x : xs) = last(x : xs)
-- last1 (_:x) = last(x)

head' :: [a] -> a
head' [] = undefined
head' (x:_) = x

tail' :: [a] -> [a]
tail' [] = undefined
tail' (_:xs) = xs

{-
+++ [a]->[a]->[a]
+++ [] x = x
+++ x [] = x
-}

[] +++ [] = []
[] +++ xs = xs
xs +++ [] = xs
(x:xs) +++ ys = x : (xs +++ ys)

{-
take' :: Int -> [a] -> [a]
take' n [] = []
-}

filter' :: (a->Bool) -> [a] -> [a]
filter' _ [] = [] -- bez znaczenia  predykat dla listy pustej
filter' f (x : xs)
    | f x = x:r
    | otherwise = r
    where r = filter' f xs

map' :: (a->b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

concat' :: [[a]] -> [a]
concat' [] = []
concat' (x:xs) = x ++ concat' xs

-- inits :: [a] -> [[a]] lista prefiksów listy, która została przekazana jako argument

inits :: [a] -> [[a]]
inits [] = [[]] -- lista pusta nie może być: błąd czasu wykonania; bez pełnej listy w wyniku
inits (x : xs) = []:[ (x : ys) | ys <- inits xs] -- pierwsza próba
-- bez pustej listy
-- alternative = [] : (map (x :) (inits xs))

{--
l = [1,2,3]
init [1,2,3]
init [2, 3]
init [3]
init [] -> [[]]
        -> init 3:[] = [] : [3]         	-> [[], [3]]
        -> init 2:3  = [] : [[], [3]]   	-> [[], [2], [2, 3]]
        -> init 1:23 = [] : [[], [2], [2,3]]	-> [[], [1], [1, 2], [1, 2, 3]]
--}

{--
odwrócić listę, wziąć prefiksry odwrócenia, odwrócić ponownie
--}

partitions :: [a] -> [([a], [a])]
partitions xs =
  let
    prefixes = init xs
    suffixes = reverse $ map reverse $ inits $  reverse xs
-- :i zip lista par,
-- będzie potrzebe reverse na początku
  in zip prefixes suffixes

{--
xs = [1,2,3]
reverse xs [3, 2, 1]
inits [3, 2, 1] = [[], [3], [3, 2], [3, 2, 1]]
map reverse = [[], [3], [2, 3], [3, 2, 1]]
	zip [[], [1], [1, 2], [1, 2, 3]] [[], [3], [2, 3], [3, 2, 1]]:
		[[], []], [[1], [3]], [[1,2], [2, 3]] ...
reverse = [[3, 2, 1], [2, 3], [3], []]
	zip [[3, 2, 1], [2, 3], [3], []] [[], [1], [1, 2], [1, 2, 3]]
		[[3, 2, 1], []], [[2, 3], [1]] // zamień kolejność podanych list, zacznij od inits
--}

{--
prościej: schemat z inits
potrzebujemy reverse, ponieważ jedno rosnące, drugie malejące
--}
{--
permutations powinni umieć samodzielnie po partitions
rekurencja: permutacja listy dłuższej na podstawie listy krótszej
dwa algorytmy: analogicznie do inits - obliczamy permutacje ogona,
następnie głowę wstawić do każdej permutacji ogona na każdą możliwą pozycję
drugi: skróć listę przez wyjęcie dowolnego elementu (pierwszy, drugi, trzeci, w sensie - każdego) To, co zostanie po wyjęciu - elementy wyjęte
doczepiamy na początek permutacji, które uzyskaliśmy
--}

-- nub :: [a] -> [a]
nub:: Eq a => [a] -> [a]
nub [] = []
-- nub (x : xs) = x : [y | y <- xs, y /= x]
nub (x:xs) = x : (nub $ filter (/=x) xs)
-- filter (\x -> x `mod` 2 /=0) [1..10]\

-- jeśli zostawię zdefiniowaną równosć - brak Eq dla klasy a
-- pootrzeba istnienia wynika z operatora /=
-- rozwiązanie: dodaie kontekstu - ograniczenia na typ a,
-- wymuszające, by istniała instancja Eq a
