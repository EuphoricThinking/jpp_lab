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


{-
opcjonalne
włay odpowiednik maybe
tram instancja klasy show
pooprzez definicję funcji showprec
showprec jako doatkowy pierwszy argument: inofirmacja o konteśkcie, w którym wystąpi
tekstowa reprezentacja będą wynikiem dhowprec, co pozwala warunkowo otoczyc nawiasami
(priortyet jako arguemtn)

3. ROZWAŻ DO JUTRA; typ drzew uporządkowanych
-}

merge [] ys = ys
merge xs [] = xs
merge p@(x:xs) q@(y:ys)
  | x < y = x : (merge xs q)
  | otherwise = y : (merge p ys)

{-
merge (x:xs) (y:ys)
  | x < y = x : (merge xs (y:ys))
  | otherwise = y : (merge (x:xs) ys)
-}

newtype OrderedLista a = OL [a]
  deriving Show

-- powinn zachować niezmiennik uporządkowainia

-- uporządkowanie
instance Ord a => Semigroup (OrderedList a) where
  -- OL x <> OL y = OL (x ++ y)
  OL x <> OL y = OL $ merge x y


{--
z definicji monodiu wynika ograniczenie typu a - musi istnieć instancja grupy semigroup

,,klasa monoid dziedziczy z grupy semigroup
--}
instance Ord a => Monoid (OrderedList a) where
  mempty = OL []

-- uporządkowana, zatem przyglądamy się tylkko pierwszym dwóm elementom
-- removeDuplicates [] = []
-- niekompletna definicja
removeDuplicates (x: y: ys)
  | x == y = r
  | otherwise = x : r
  where
    r = removeDuplicates (y:xs)
-- removeDuplicated niekompletena definicja dla krótzych list
removeDuplicates xs = xs


nubOrdered :: Ord a => OrderedList a -> OrderedList a
nubOrdered (OL xs) = OL $ removeDuplicates xs

-- czwarte dobrze ilustruje moc deklaracji? funkcji
-- arguemnt: maybe A: just a, nothing, wynikiem jest c
elimMaybe :: c -> (a -> c) -> Maybe a -> c
elimMaybe x _ Nothing = x
elimMaybe x f (Just x) = f x
-- eliMaubye 10 (+20) NOthing // (Jus 30)


fromMaybe :: a -> Maybe a -> a
fromMaybe x Nothing = x
fromMaybe _ (Just x) = x

-- id funkcja identyczność
-- fromMaybe = elimMaybe x (\(Just y) -> y) z
-- fromMaybe = elimMaybe x id y

mapMaybe :: (a -> b) -> Maybe a -> Maybe b
mapMaybe _ Nothing = Nothing
mapMaybe f (Just a) = (Just $ f a)


maybeHead :: [a] -> Maybe a
maybeHead [] = Nothing
maybeHead (x : _) = (Just x)

{-
jako 3. arguemnet wartość a b
wartość typu c bierze jako wynik funkcji przekazanej jako pierwszy lub drugi argument
wartość typu a ukryta pod konstrukttorem wartości Left
-}
elimEither :: (a  -> c) -> (b -> c) -> Either a b -> c
elimEither f _ (Left x) = f x
elimEither _ f (Right x) = f x
-- elimEither (+1) length (Left 10) // (Right "ala")

mapEither :: (a1 -> a2) -> (b1 -> b2) -> Either a1 b1 -> Either a2 b2
mapEither f _ (Left x) = Left $ f x
mapEither _ f (Right x) = Right $ f x

{-
często prawdziwy wynik funkcji po RIGTH,
w LEFT - KOMUNIKAT O BŁĘDZIE
-}
mapRight ::  (b1 -> b2) -> Either a b1 -> Either a b2
mapRight f (Left x) = Left x -- wartość ta sama, ale INNE TYPY po obu stronach
-- mapRight f p@(Left x) = p -- nie kompiluje się TYPY nie zgadzają się b1 i b2 to inne typy
mapRight f (Right x) = Right $ f x
--mapRight (+1) $ Left "Nie udalo sie"


{-
either konstuktor TYPU
left/i=right: konstrutory WARTOŚCI
either konstruktor typu dwuargumentowy
maybe - jednoarguemtnowy
wartości postaci left albo rght
sumujemy dwa typy: typ, któty jest sumą dwóch typów
wartości typów muszą być rozróżnione, dlatego left i right decydują, którego typu (perwszy czy drugi)
wartością zajmujemy się

Left 10 :: Either Int String
Left "ala" :: Either Int String
left funckja opuściła obliczenie i zwróciła wartość dla right


-}


fromEither :: Either a a -> a
fromEither (Left x) = x
fromEither (Right x) = x

-- odwróć wartość siedzącą pod right, dowolnego typu pierwszy argument e
reverseRight :: Either e [a] -> Either e [a]
reverseRight x = mapRight reverse x

-- zadanie 5; w najbliższym czasie będzie nas coraz bardziej interesować 
data Exp
  = EInt Int             -- stała całkowita
  | EAdd Exp Exp         -- e1 + e2
  | ESub Exp Exp         -- e1 - e2
  | EMul Exp Exp         -- e1 * e2
  | EVar String          -- zmienna
  | ELet String Exp Exp  -- let var = e1 in e2
--  deriving Show

example :: Exp
example = ELet "x" (EAdd (EInt 1) (EInt 2)) (EMul (EVar "x") (ESub ((Eint 0) (EVar "x"))))

instance Show Exp where
  show (EInt n) = show n             -- stała całkowita
  show (EAdd e1 e2) = "(" ++ show e1 ++ " + " ++ show e2 ++ ")"         -- e1 + e2
  show (ESub e1 e2) = "(" ++ show e1 ++ " - " ++ show e2 ++ ")"          -- e1 - e2
  show (EMul e1 e2) = "(" ++ show e1 ++ " * " ++ show e2 ++ ")"          -- e1 * e2
  show (EVar s) = show s          -- zmienna
  show (ELet s e1 e2) = "(let " ++ s ++ " in " ++ show e1 ++ " " ++ show e2 ++ ")"


instance Eq Exp where
  (EInt n) == (EInt a) = n == a            -- stała całkowita
  (EAdd e1 e2) == (EAdd e1' e2') = (e1 == e1') && (e2 == e2') --"(" ++ show e1 ++ " + " ++ show e2 ++ ")"         -- e1 + e2
  (ESub e1 e2) == (ESub e1' e2') = (e1 == e1') && (e2 == e2') --show (ESub e1 e2) = "(" ++ show e1 ++ " - " ++ show e2 ++ ")"          -- e1 - e2
  (EMul e1 e2) == (EMul e1' e2') = (e1 == e1') && (e2 == e2')         -- e1 * e2
  (EVar s) == (EVar s') = (s == s')
  (ELet s e1 e2) == (ELet s e1 e2) = (s == s') && (e1 == e1') && (e2 == e2')

instance Num Exp where
--  (+) :: a-> a -> a
  e1 + e2 = EAdd e1 e2
-- (-)
  e1 - e2 = ESub e1 e2
  e1 * e2 = EMul e1 e2
  abs = undefined
  signum = undefined
  fromInteger x = EInt $ fromIntegral x
-- ( 2 + 2)*3 :: Exp ---> chcemy otrzymac typ Expr
-- INgegral klasa typów całkowitych
-- bez negate -- sprawdź, co minimal
-- example zmodyfikuj tak, by zostawić ELet i EVar=

simpl x = x
simpl (EMul (EInt 1) x) = x

-- do domu można punkt c oraz d
