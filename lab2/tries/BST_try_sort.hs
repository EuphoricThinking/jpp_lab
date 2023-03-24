module BST_try_sort where

import BST_try

sort :: (Ord a) => [a] -> [a]
sort xs = toList $ fromList xs

