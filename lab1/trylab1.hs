indexOf :: Char -> String -> Maybe Int
--indexOf c [] = Nothing
indexOf c (x:xs) = go 0 c (x:xs) where
  go _ _ [] = Nothing
  go n c (x:xs)
    | c == x = (Just n)
    | otherwise = go (n+1) c xs
