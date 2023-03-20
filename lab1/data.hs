import qualified Data.Map as Map
import qualified Data.Set as Set

{--
Data.Map niekoniecznie rzyda się przy zaliczeniowym, ale Arti nie jest pewien
Data.Map - implementacja mapy

Tylko Prelude standardowo importowane

inna definicja empty w data.set i data.map

import Data.Map
import Data.Set <- konflikt między definicjami empty

również niektóre pozostałe definicje w konflikcie
problem można rozwiązać kwalifikatorem qualified

import qualified Data.Map
co wymusi kwalifikację wszystkich odwołań do eksportów modułów,
czyli POPRZEDZENIE NAZWĄ MODUŁU; jednak wówczas za każdym razem musimy poprzedzać nazwę
może być niewygodne - wówczas podajemy alias kwalifikacji -> as Map

Map.empty :: Map.Map k a
Map.Map konstruktorem typu, który aplikujemy do klucza i wartości:
w rezultacie

insert zwraca jako wynik mapę

Maybe lookup NOthing albo Just

Set empty :: zbiór wartosci typu a dla dowolnego a; podobnie w mapie wartością zwracaną jest mapa
--}

testSet :: Int -> Int -> Bool
testSet x y = Set.member y $ Set.insert x Set.empty

-- lookup inset
-- 
{-- testSet 10 10
testMap 1 1 2
--}
