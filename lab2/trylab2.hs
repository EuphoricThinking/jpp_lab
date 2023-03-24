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
