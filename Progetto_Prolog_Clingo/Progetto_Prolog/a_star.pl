astar(Cammino):-
    iniziale(S0),   %stato iniziale
    euristica(S0, F0),  %calcolo l'euristica
    path_iniz(P),
    ricerca([F0,S0,[P],aperto],[[F0,S0,[P],aperto]],1,Cammino).    %segno S0 come aperto e avvio la ricerca
%primo arg:(costo, stato, cammino, stato aperto/chiuso)
%secondo arg: lista degli stati già espansi

ricerca([_,S,Path,_],_,_,Path):-                                    %controllo se lo stato è uno stato goal
    finale(S).

ricerca([H,S,Path,_], Stati, C, Cammino):-
    espandi(S,Path,Stati, C, SNuovi),                               %espando lo stato S e calcolo le euristiche
    chiudi([H,S,_,aperto], SNuovi, StatiNuovi),                     %segno S come chiuso
    visita(StatiNuovi, [HMin,SMin,PMin,aperto]),                    %trovo il nuovo stato da visitare
    CStar is C + 1,                                                 % incremento il numero di passi
    ricerca([HMin,SMin,PMin,aperto], StatiNuovi, CStar, Cammino).   %continuo la ricerca ricorsivamente