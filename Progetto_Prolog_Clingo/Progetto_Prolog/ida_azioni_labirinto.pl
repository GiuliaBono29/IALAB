%FUNZIONI PER APPLICABILITA' E TRASFORMAZIONE
applicabile(nord,pos(R,C)) :-
    R>1,
    R1 is R-1,
    \+ occupata(pos(R1,C)).

applicabile(sud,pos(R,C)) :-
    num_righe(NR), R<NR,
    R1 is R+1,
    \+ occupata(pos(R1,C)).

applicabile(ovest,pos(R,C)) :-
    C>1,
    C1 is C-1,
    \+ occupata(pos(R,C1)).

applicabile(est,pos(R,C)) :-
    num_col(NC), C<NC,
    C1 is C+1,
    \+ occupata(pos(R,C1)).

trasforma(est,pos(R,C),pos(R,C1)) :- C1 is C+1.
trasforma(ovest,pos(R,C),pos(R,C1)) :- C1 is C-1.
trasforma(sud,pos(R,C),pos(R1,C)) :- R1 is R+1.
trasforma(nord,pos(R,C),pos(R1,C)) :- R1 is R-1.

path_iniz(P):-
    iniziale(S0),
    P = [[start,S0]].

%C=numero passi fatti
espandi(S,Path,C,StatiConEuristiche):-
    apri(S,Path,NuoviNodi),                          %creo la lista di stati aperti a partire da S
    calcola_euristiche(NuoviNodi, C, StatiConEuristiche).   %calcolo le euristiche per gli stati aperti

apri(S,Path,NuoviNodi):-   %ritorno tutta la lista aperta
    findall([_, SNuovo, NuovoPath], (       %genera una lista di stati aperti indicando il percorso per raggiungerlo
        applicabile(Azione, S),                     %verifica se l'azione è applicabile
        trasforma(Azione, S, SNuovo),               %calcola il nuovo stato
        append(Path, [[Azione,SNuovo]], NuovoPath)           %aggiunge lo stato al cammino
    ), NuoviNodi).

calcola_euristiche(NuoviNodi, C, StatiConEuristiche) :-
    maplist(aggiorna_euristica(C), NuoviNodi, StatiConEuristiche).   %maplist applica il predicato aggiorna_euristica a ciascun elemento di NuoviNodi

aggiorna_euristica(C, [_, S, P], [H, S, P]) :-
    euristica(S, F),
    H is C + F.

euristica(S, DistanzaMin):-   %calcolo lista distanze di Manhattan
    S=pos(R,C),
    findall(Distanza,(
        finale(pos(RT,CT)),
        Distanza is abs(RT-R) + abs(CT-C)
    ), HList),
    min_member(DistanzaMin, HList).
