module BST where

{--
DEFINIOWANIE TYPÓW I INSTANCJI - ZALICZENIOWE

1 konstruktor typu

stałą empty, konsturktor Node, lewe i prawe poddrzewo

tylko show trzeba zdefniować, co da nam kompletną instancję show
minimalna wersja show - showPrec albo show, zajmiemiy się show, gdyż prostsza

nie możemy autoamtycznie wygenerować instancji klasy EQ dla naszego typu
w przypadku typów algebraicznych
instancja Eq poróœnuje ze sobą wartości przechowywane w węzłąch za pomocą rónwości

jeśli elementami drzewa sa funkcje, to automatycznie nie możemy wygenerować instancji klasy Eq
poodobnie show
nie można funkcji porównywać za pomocą równości ani wypisywać-

tree równosc bez porównywania wartości
--}

data Tree =
  Empty
  | Node a (Tree a) (Tree a)
-- deriving (Eq, Show)
-- Node 20 (Noxe 10 Empty Empty) Empty
-- Empty == Node 1 Empty Empty

example1 =  Node 10 (Node 20 Empty (Node 30 Empty Empty)) (Node 40 Empty Empty)


{-
Na lewo lewe poddrzewo, na prawo - prawe poddrzewo
Arti daje znak "=" jako puste
na najwyższym poziomie brak nawiasów, tylko w poddrzewach
-}
instance Show a => Show (Tree a) where
  show Empty = "EmptY"
  show (Node x t1 t2) = p t1 ++ " " ++ show x ++ " " ++ p t2 where
    p Empty = "EmptY"
    p t = "(" ++ show t ++ ")"

instance Eq a => Eq (Tree a) where
  Empty == Empty = True
  (Node x t1 t2) == (Node y t1' t2') = (x == y) && (t1 == t1') && (t2 == t2')
  _ == _ = False
 -- usunąc (x == y) -> porównujemy KSZTAŁTY drzew; możemy również tworzyć drzzewa funkcji
-- porównuje kształto

-- koszt: rekurencja nieogonowa; koszt: kwadratowy względem liczby węzłów drzewa
toList :: Tree a -> [a]
toList Empty = []
-- toList (Node x t1 t2) = toList t1 ++ [x] : toList t2
-- lepiej: przekazywać listę jako akumulator
-- cons cczas stały, konkatenacja: linoiwa
toList t = go t [] where
  go Empty xs = xs
  go (Node x t1 t2) xs = go t1 $ x : go t2 xs
-- żeby było od lewej do prawej, trzeba zrobić od prawej do lewej
-- akumulator bardzo bezpośrednio przekłada się na czas działąnia 

zdeg :: Int -> Tree Int
zdeg 0 = Empty
zdeg n = Node 1 (zdeg (n-1)) Empty


-- implementacja BST

empty :: Tree a
empty = Empty

insert :: (Ord a) => a -> Tree a -> Tree a
insert a Empty = Node a Empty Empty
insert a (Node b t1 t2)
  | a < b = Node b (insert a t1) t2
  | otherwise = Node b t1 (insert a t2)


member :: (Ord a) => a -> Tree a -> Bool
member a Empty = False
member a (Node b t1 t2)
  | a == b = True
  | a < b = member a t1
  | otherwise = member a t2


fromList :: (Ord a) => [a] -> Tree a
fromList [] = Empty
fromList (x:xs) = insert x $ fromList xs
-- w korzeniu ostatania wartość z listy - od końc wstawiane wartości
-- możemy alternatywną wersję, która wstawia od początku - AKUMULATOR

fromList' :: (Ord a) => [a] -> Tree a
fromList' xs = go xs Empty where
  go [] t = t
  go (y : ys) t = go ys $ insert y t

-- Mozna foldami zastąpić - krótszy kod, niekoniecznie czytelny

{-
Jak podzielic program na moduły?
Definicje do modułu
-}
