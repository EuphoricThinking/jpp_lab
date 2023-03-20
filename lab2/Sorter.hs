module Sorter where

import BST

--do eksportu
sort :: Ord a => [a] -> [a]
sort xs = toList $ fromList xs

-- Złożenie funkcji
sort' :: Ord a => [a] -> [a]
sort' = toList . fromLists

-- ghc Przykład.hs -> ./przykład
