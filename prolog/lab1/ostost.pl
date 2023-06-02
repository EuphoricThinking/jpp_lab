rowne+ebez_negacji(K, L) :- zawarte(K, L), zawarte(L, K).
zawarte([], _).
zawarte([X|K], L) :- member(X, L), zawarte(K, L).

rowne_z_negacja(K, L) :- \+nie_zawarte(K, L), \+nie_Zawarte(L, K).
niew_Zawarte(K, L) :- member(X, K), \+member(X, L).
% za pomcą formuły logicznej zapisalibyśmy: dla każdego elemenu z listy K spełniony jest warunek
% w tym zpisie zamiast dla każdego X: nieprawda, że istnieje X, dla którego nieprawda, że spełniony jest dany warunek - dwukrotne przejście przez negację pozwala skrócić kod
