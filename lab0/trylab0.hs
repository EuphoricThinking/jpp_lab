countdown:: Int -> [Int]
countdown 0 = [0]
countdown n = n:countdown(n-1)

collatz:: Int -> [Int]
collatz n
  | n == 0 = [0]
  | n == 1 = [1]
  | n `mod` 2 == 0 = n:collatz(n `div` 2)
  | otherwise = n:collatz(3*n + 1)

last':: [a] -> a
last' [x] = x
last' (_:x) = last' x

head':: [a] -> a
head' [x] = x
head' (x:_)= x


tail':: [a]->[a]
tail' [] = []
tail' [x] = []
tail' (x:xs) = xs

(+++):: [a]->[a]->[a]
(+++) [] [] = []
(+++) [] x = x
(+++) x [] = x
(+++) (x:xs) ys = x:(+++) xs ys

take':: Int -> [a] -> [a]
take' n x
  | n <= 0 = []
take' n [] = []
take' n (x:xs) = x:take'(n-1) xs

drop':: Int -> [a] -> [a]
drop' 0 x = x
drop' n [] = []
drop' n (x:xs) = drop' (n-1) xs

filter':: (a->Bool)->[a]->[a]
filter' a [] = []
filter' a xs = [x | x <- xs, a x]

map':: (a->b)->[a]->[b]
map' a [] = []
map' a xs = [a x | x <- xs]

concat':: [[a]] -> [a]
concat' [] = []
concat' [[]] = []
concat' [x] = x
concat' [x, y] = x++concat' [y]

inits:: [a] -> [[a]]
inits [] = [[]]
inits (x:xs) = []:[x:ys | ys <- inits xs]

partitions :: [a] -> [([a], [a])]
partitions n =
  let
    pref = inits n
    suff = reverse $ map reverse $ inits $ reverse n
  in
    zip pref suff

-- part :: [a] -> [([a], [a])]
-- part [] = [[], []]

nub :: (Eq a) => [a] -> [a]
nub [] = []
nub (x:xs) = x:[y | y <- nub xs, y /= x]



























part :: [a] -> [([a], [a])]
part [] = [([], [])]
part (x:xs) = ([], x:xs) : [(x:a, b) | (a, b) <- part xs]


perm :: (Eq a) => [a]->[[a]]
perm [] = [[]]
perm xs = [x : ys | x <- xs, ys <- perm $ filter (/= x) xs]
{--
[([a], [a])]
partitions [] -> [([], [])]
x : xs
(a, b) <- partitions xs
el <- partitions xs
(a, b) <- el

[1,2,3]
paritions x:xs
1  23
   2   3        ->
       3 : []   -> [([], [])]  // ([3], []), ([], [3])

23

([], 23), ([2], [3]), (23, [])
([], xs), (x:a, b), (x:c, d)
--}

{--
123
132
312
231
213
321

123
213

231
321

132
312

perm :: [a] -> [a]
perm [] = []

-----> x: xs ---> perm xs  ----> []
123

3: [] ---> []
----->[3]
filter (/= x) xs
perm [] = []
perm (xs) = [x : perm $ filter (/=x) xs | x <- xs]


2
23 32
--}
