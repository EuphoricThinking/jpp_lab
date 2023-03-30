
type Env = Data.Map.Map String Int
type EvalMonad = Either String


-- monada klasy eval.error
eval :: Env -> Exp -> EvalMonad Int
eval _ (Val n) = return n
eval env (Var s) = undefined
eval env (Add x y) = do
  n <- eval env x
  m <- eval enc y
  return $ n + m

eval env (Var s) =
  case Data.Map lookup s env of
    Nothing -> thorwError  $ "niezfdef zmiennia" ++ s
    Just x -> return x

--eval (Daata.Map.insert "x" 5 DATA.Map.empty) example3
evalLis :: Env -> [Exp] -> [Evalmonad Int]
evalList _ [] = []
evalList env (e:es) = (eval env e : evalList env es)

{-
rzoszerza środowisko o wartościowanie nowej zmiennej
-}
  | Let String Exp Exp

ex = Let "y" (Add (Var "x") (Var 1)) (Mul (Var "y") (Var "y"))

eval env (Let s e1 e2) = do
-- wprowadzamy dośrodowsika wartościowanie zmiennej s
  x <- eval env e1
  let env' = Data.Map.insert s x env -- nowe środowisko budujemy
  -- w do możemy lokalnie let wprowadzić
  eval env' e2


-- zad. 3
--dzielenie:
catchError (safediv' n m) (throwError . (("w wyrazeniu" ++ show w) ++ ))

-- może kiedy będzie wolna chwila - nie będzie
-- zadanie 3 dla nas
-- zadanie 4 - monada innego rodzaju, IO
