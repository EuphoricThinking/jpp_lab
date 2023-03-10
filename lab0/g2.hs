f xs = let
    len [] = 0
    len (x:xs) = 1 + len xs
  in len xs

splitBy:: Int -> [Int] -> ([Int], [Int])
splitBy n [] = ([], [])
{-
splitBy n (x:xs) = let (ys, zs) = splitBy n xs in
  if x <= n then (x:ys, zs) else (ys, x:zs)
-}

{-
splitBy n (x:xs)
  | x <= n = let (ys, zs) = splitBy n  xs in (x:ys, zs)
  | otherwise = let (ys, zs) = splitBy n xs in (ys, x:zs)
-}
splitBy n (x:xs)
  | x <= n = (x:ys, zs)
  | otherwise = (ys, x:zs)
  where (ys, zs) = splitBy n xs
