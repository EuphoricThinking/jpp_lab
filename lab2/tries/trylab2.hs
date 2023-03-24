data Tree a = Empty | Node a (Tree a) (Tree a)

instance Show a => Show (Tree a) where
  show Empty = "Empty"
  show (Node a b c) = p b ++ " " ++ show a ++ " " ++ show c where
    p Empty = "Empty"
    p t = "(" ++ show t ++ ")"

instance Eq a => Eq (Tree a) where
  Empty == Empty = True
  Node x t1 t2 == Node y t1' t2' = (x == y) && (t1 == t1') && (t2 == t2')
  _ == _ = False

toList :: Tree a -> [a]
toList Empty = []
--toList (Node x t1 t2) = (toList t1) ++ (x : toList t2)
toList t = go t [] where
  go Empty xs = xs
  go (Node x t1 t2) xs = go t1 $ x : go t2 xs

example = Node 20 (Node 10 Empty Empty) (Node 30 (Node 25 Empty Empty) Empty)

insert :: (Ord a) => a -> Tree a -> Tree a
insert a Empty = Node a Empty Empty
insert x (Node y t1 t2)
  | x < y = Node y (insert x t1) t2
  | otherwise = Node y t1 (insert x t2)

member :: (Ord a) => a -> Tree a -> Bool
member _ Empty = False
member x (Node y t1 t2)
  | x < y = member x t1
  | x == y = True
  | otherwise = member x t2


fromList :: (Ord a) => [a] -> Tree a
fromList [] = Empty
fromList (x : xs) = go xs Empty where
  go [] t = t
  go (y:ys) t = go ys $ insert y t



