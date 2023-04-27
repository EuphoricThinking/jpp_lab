{-
analizator leksykalny - parser?
-}


import IntLambda

import qualified Data.Map as Map

type Evnnvironment = Map.Map String Type

type TypeCheckingMonad a = ExceptT String (Reader Environment) a


--typeOf wszystkie nazwy
typeInOf :: Exp -> TypeCheckingMonad Type
typeInOf (Eint _ ) = return TInt
typeInOf (EVar s) =
  env <- ask
  case Map.lookup s env of
    Nothing -> thowError $ "Brak definicji " ++ s
    Just t -> return t
-- wtyp wyażenia: funkcyjna, wyniku typu expa
-- komplikacja
typenOf (ELam s t exp) =
  --env <- ask
  -- let env' = Map.insert s t env
  -- local podać funkcję przekształcającą środowiwsko w ()
  t' <- local (Map.insert s t) $ typeof exp
  return $ t :-> t'
-- zmodyfukowane środowisko: doatkowo indofmracja o typie dla s // klucz, wartoć mapa
  -- env' = Map.insert s t env
-- typ aplikacji funkcji
-- jakie warunki by poprawne pod względem typów?
-- f musi być funckją, która przyjmuje argument typu exp
typeInOf env (EApp f exp) = do
  --env <- ask
  tf <- typeOf f
  texp <- typeOf exp
-- in wcześniej w nazwie funkcji, ponieważ przekazywaliśmy jawnie środowisko
 {- let
    tf = typeInOf env f
    texp = typeInOf env exp
  in
-} case tf of
-- t1 jest postaci t2
     t1 :-> t2
-- dodatkowo spełnoiny warune
       | t1 == texpt -> t2
     otherwise -> error $ "Nie można zaaplikować " ++ show f ++ " do " ++ show exp
typeInOf (ELet s exp1 exp2) = do
-- klucz wartość mapa; zmodyfikowane środowisko
  -- texp2 = typeInOf env' exp2
   --env' = Map.insert s texp1 env
   texp1 = typeOf exp1
   local (Map.insert s texp1) $ typeOfM exp2

typeOf :: Exp -> Either String Type
typeIf exp =
  let
    tm = typeOfM exp -- reaader za pomocą run reader wykonywan; typ runreader: monada, środowisko
  in
    runReader (runExceptT tm) Map.empty -- środowisko to map emtuu

typeCheck :: Exp -> IO()
typeCheck exp =
  case typeOf exp of
    Left e -> putStrLN E
    Right t -> print t
