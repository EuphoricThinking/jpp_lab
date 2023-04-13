import qualifies Data.Map as Map
import Control.Monad.State

data Exp
 = EVar String
  | EInt Int
  | EAdd Int Int
-- ...

data BExp -- wartość liogiczna
  = BEq Exp Exp
  | BLt Exp Exp


data Stmt
  = Skip
  | SAssign String Exp
  | SNext Stmt Stmt
  | SIf BExp Stmt Stmt
  | SWhile BExp Stmt


type IntState = Map.Map String Int
-- cel: zapisz interpreter tego języka
-- InterpreterMonad
type IM a = State IntState a


-- lookupem zaglądamy do stanu klucz, mapa -> Maybe
evalExp :: IntState -> Exp -> Int
evalExp environment (EVar s) =
  case Map.lookup s env of
    Nothing -> 0 -- początkowa wartość (albo error, ale nie tutaj)
    ust x -> x
evalExp (EInt n) = n
evalExp (EAdd e1 e2) = evalExp env e1 + evalExp env e2
-- env -> environment

--interpreter state
evalBool :: IntState -> BExp -> Bool
evalBool state (BEq e1 e2) =
  let
    e1' = evalExp state e1
    e2' = evalExp state e2
  in
    e1' == e2'
evalBool state (BEq e1 e2) =
  let
    e1' = evalExp state e1
    e2' = evalExp state e2
  in
    e1' < e2'

-- trzeba przekząć pocżątkwy stan
-- zmienne bez wartości początkowych
próba odwołania do zmiennych, którym nie nadaliśmy wartosci, jest błędem
execStmtM :: Stmt -> InterpreterMonad ()
execStmtM Skip = return ()
execStmtM (SAssign s e) = do
  state <- get -- nasz stan
-- evalExpr dla zadanego wartościowania zienych s i wyrażenia e da nam wartosć
  let e' <- evalExp state e
-- put zmienia stan czyli: stanem zmieniona mapa, zmieniona za pomcą inserta
-- insertowi prezekązemy klucz (s), wartość (e')
  put $ Map.insert s e' state -- good
  return () -- przypisanie bez żadnej wartości
-- załózmy, że w przypadku niezainicjalizowanje zmienej błąd albo wartość zero
-- bład, czyli wyjątek, wywołanie fukcji error

execStmtM (SNext s1 s2) = execStmtM s1 >> execStmtM s2

-- policz wartość wyrażenia
-- ewaluujemy s1, jeśli b
execStmtM SIf (be s1 s1) = do
  state <- get
  let b = evalBool state be
  execStmtM $ if b then s1 else s2
execStmt p@(SWhile be s) = do
  state <- get
  let b = evalBool state be
  if b then (SNext s p) else return ()
-- najpierw s, później pętla, zamiast return () może być SSkip, nawiasy może niepotrzebne
{-
next wykkonaj s1, następnie s2
ddwa oblcizenia mozemy złżycć bindem
prawym arugemntem funckaj, która otrzymuje  tutaj podpisywałam się xd

next
nie ignoruejemy wybiku ubocznego s1, a teraz ignorujemy pierwzy element z pary
zaktualizowany stan przy Next
CHCĘ zignorować unit
>> \_ ->
-}
execStmt :: Stmt -> IO ()
execStmt s = print $ execState (execStmtM s) Map.empty

-- wynik: obliczenie IO, powodujące wypisanie końcowych wartości zmiennych
-- dodawanie zamiast silni, która planował Arti
example
  = SNext
     (SAssign "a" (EInt 10))
     (SNext
        SAssign "b" (EInt 1))
        (SWhile
           (BLt (EInt 1) (EVar "a"))
           (SNext
              (SAssign "b" (EAdd (EVar "b") (EVar "a")))
              (SAssign "a" (EAdd (EVar "a") (EInt (-1))))))) --?? ile nawiasów
