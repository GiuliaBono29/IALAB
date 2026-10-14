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

%FUNZIONI PER LA RICERCA
chiudi([H,S,Path,aperto], SNuovi, StatiNuovi):-            %segno lo stato s come chiuso
    select([H,S,Path,aperto], SNuovi, [H,S,Path,chiuso], StatiNuovi).

%C=numero passi fatti
espandi(S,Path, Stati, C, StatiAgg):-
    apri(S,Path,Stati, NuoviNodi),                          %creo la lista di stati aperti a partire da S
    calcola_euristiche(NuoviNodi, C, StatiConEuristiche),   %calcolo le euristiche per gli stati aperti
    nodichiusi(S,Path,Stati, NodiChiusi),                   %cerco i nodi chiusi raggiungibili da S
    calcola_euristica_chiusi(NodiChiusi, C, StatiConEuristicheChiusi),  %se sono ragg con H minore li riapro
    append(StatiConEuristiche, StatiConEuristicheChiusi, StatiNuovi),   %unisco le due liste di statinuovi
    append(Stati, StatiNuovi, StatiAgg). %aggiungo alla lista degli stati

apri(S, Path, Stati, NuoviNodi):-   %ritorno tutta la lista aperta
    findall([_, SNuovo, NuovoPath, aperto], (       %genera una lista di stati aperti indicando il percorso per raggiungerlo
        applicabile(Azione, S),                     %verifica se l'azione è applicabile
        trasforma(Azione, S, SNuovo),               %calcola il nuovo stato
        \+ member([_,SNuovo, _,_], Stati),     %inserisce solo se non è già presente chiuso
        append(Path, [[Azione,SNuovo]], NuovoPath)           %aggiunge lo stato al cammino
    ), NuoviNodi).

nodichiusi(S, Path, Stati, NodiChiusi):-    %ritorno tutta la lista di nodi chiusi raggiungibili
    findall([H, SNuovo, NuovoPath, aperto], (
        applicabile(Azione, S),
        trasforma(Azione, S, SNuovo),
        member([H,SNuovo, _,chiuso], Stati),    %inserisce solo se è già presente chiuso
        append(Path, [[Azione,SNuovo]], NuovoPath)
    ), NodiChiusi).

visita(Stati, [HMin,SMin,PMin,AperturaMin]):-
    include(aperto, Stati, NodiAperti),
    min_member([HMin, SMin, PMin, AperturaMin], NodiAperti).

aperto([_,_,_, aperto]). %controllo se lo stato è aperto

calcola_euristiche(NuoviNodi, C, StatiConEuristiche) :-
    maplist(aggiorna_euristica(C), NuoviNodi, StatiConEuristiche).
    %maplist applica il predicato aggiorna_euristica a ciascun elemento di NuoviNodi

aggiorna_euristica(C, [_, S, P, Apertura], [H, S, P, Apertura]) :-
    euristica(S, F),
    H is C + F.

calcola_euristica_chiusi(NodiChiusi, C, StatiConEuristicheChiusi) :-
    findall([H,S,_,aperto],(
        member([HVecchio,S,_,chiuso], NodiChiusi),
        euristica(S,F),
        H is C + F,
        HVecchio > H,        %controllo se l'euristica è minore di quella già calcolata
        \+ member([_,S,_,aperto], StatiConEuristicheChiusi) %controllo se non è già presente
    ), StatiConEuristicheChiusi).

euristica(S, DistanzaMin):-   %calcolo lista distanze di Manhattan
    S=pos(R,C),
    findall(Distanza,(
        finale(pos(RT,CT)),
        Distanza is abs(RT-R) + abs(CT-C)
    ), HList),
    min_member(DistanzaMin, HList).
