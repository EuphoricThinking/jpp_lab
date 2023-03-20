--module Main where  -- nie jest potrzebne

import Sorter

main :: IO ()
main = print $ sort [3,2,5.1.4]

-- Działa na dowolnych poóównywalnych, "alamakota" również zadziałą"
-- trzy moduły: BST, Sorter, przyszkła
