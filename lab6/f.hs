{-
analizator leksykalny - parser?
-}


import IntLambda

import qualified Data.Map as Map

type Evnnvironment = Map.Map String Type

typeInOf :: Environment -> Type
typeInOf _ (Eint _ ) = TInt
typeInOf env (EVar s) =
  case Map.lookup s env of
    Nothing -> error $ "Brak definicji " ++ s
    Just t -> t
-- wtyp wyażenia: funkcyjna, wyniku typu expa
-- komplikacja
typenOf env (ELam s t exp) = t :-> typeInOf env' exp where
-- zmodyfukowane środowisko: doatkowo indofmracja o typie dla s // klucz, wartoć mapa
  env' = Map.insert s t env
-- typ aplikacji funkcji
-- jakie warunki by poprawne pod względem typów?
-- f musi być funckją, która przyjmuje argument typu exp
typeInOf env (EApp f exp) =
  let
    tf = typeInOf env f
    texp = typeInOf env exp
  in
    case tf of
-- t1 jest postaci t2
      t1 :-> t2
-- dodatkowo spełnoiny warunek
         | t1 == texpt -> t2
      otherwise -> error $ "Nie można zaaplikować " ++ show f ++ " do " ++ show exp
typeInOf env (ELet s exp1 exp2) = texp2 where
-- klucz wartość mapa; zmodyfikowane środowisko
   texp2 = typeInOf env' exp2
   env' = Map.insert s texp1 env
   texp1 = typeInOf env exp1
