%FUNZIONI PER APPLICABILITA' E TRASFORMAZIONE
%applicabile controlla in che posizioni si possono spostare le caselle
applicabile(nord,S) :-
    member([pos(R,_),nil], S),
    R>1.

applicabile(sud,S) :-
    member([pos(R,_),nil], S),
    num_righe(NR),
    R<NR.

applicabile(ovest,S) :-
    member([pos(_,C),nil], S),
    C>1.

applicabile(est,S) :-
    member([pos(_,C),nil], S),
    num_col(NC),
    C<NC.

%sposta la casella nella direzione X nella posizione libera e cambia il valore della posizione libera
%valori(azione, poszione libera, [posizione occupata, valore], nuova posizione libera)
trasforma(est,S, [pos(R,C),Val], pos(R,C1)) :-
    member([pos(R,C),nil], S),          %ricavo la casella libera
    C1 is C+1,                          %calcolo la casella da spostare
    member([pos(R,C1),Val],S).          %trovo il valore nella casella da spostare

trasforma(ovest,S, [pos(R,C),Val], pos(R,C1)) :-
    member([pos(R,C),nil], S),
    C1 is C-1,
    member([pos(R,C1),Val],S).

trasforma(sud,S, [pos(R,C),Val], pos(R1,C)) :-
    member([pos(R,C),nil], S),
    R1 is R+1,
    member([pos(R1,C),Val],S).
    
trasforma(nord,S, [pos(R,C),Val], pos(R1,C)) :-
    member([pos(R,C),nil], S),
    R1 is R-1,
    member([pos(R1,C),Val],S).

path_iniz(P):-
    iniziale(S0),
    member([pos(R,C),nil], S0),
    P = [[start,pos(R,C)]].

%FUNZIONI PER LA RICERCA
chiudi([H,S,Path,aperto], SNuovi, StatiNuovi):-            %segno lo stato s come chiuso
    select([H,S,Path,aperto], SNuovi, [H,S,Path,chiuso], StatiNuovi).

espandi(S,Path, Stati, C, StatiAgg):-
    apri(S,Path,Stati, NuoviNodi),                          %creo la lista di stati aperti considerando lo stato S
    calcola_euristiche(NuoviNodi, C, StatiConEuristiche),   %calcolo le euristiche per gli stati aperti
    nodichiusi(S,Path,Stati, NodiChiusi),                   %cerco i nodi chiusi raggiungibili da S
    calcola_euristica_chiusi(NodiChiusi, C, StatiConEuristicheChiusi),  %se sono ragg con H minore li riapro
    append(StatiConEuristiche, StatiConEuristicheChiusi, StatiNuovi),   %unisco le due liste di statinuovi
    append(Stati, StatiNuovi, StatiAgg). %aggiungo alla lista degli stati

apri(S, Path, Stati, NuoviNodi):-   %ritorno tutta la lista aperta
    findall([_, SNuovo, NuovoPath, aperto], (
        applicabile(Azione, S),                     %verifica se l'azione è applicabile nella pos libera
        trasforma(Azione, S, [SOcc, Val], SLib),    %calcolo la nuova pos libera e occupata
        sostituisci_valori(S,  SOcc, SLib, Val, SNuovo),
        \+ member([_,SNuovo, _, chiuso], Stati),     %inserisce solo se non è già presente (in generale, anche se ho un path diverso)
        append(Path, [[Azione,SLib]], NuovoPath)           %aggiunge lo stato al cammino
    ), NuoviNodi).

nodichiusi(S, Path, Stati, NodiChiusi):-    %ritorno tutta la lista di nodi chiusi raggiungibili
    findall([H, SNuovo, NuovoPath, aperto], (
        applicabile(Azione, S),
        trasforma(Azione, S, [SOcc, Val], SLib),
        sostituisci_valori(S, SOcc, SLib, Val, SNuovo),
        member([H,SNuovo, _,chiuso], Stati),    %inserisce solo se è già presente chiuso
        append(Path, [[Azione,SLib]], NuovoPath)
    ), NodiChiusi).

sostituisci_valori(S, SOcc, SLib, Val, SNuovo):-
    select([SOcc, nil], S , [SOcc, Val], S1), %sostituisco il valore della posizione occupata
    select([SLib, Val], S1, [SLib, nil], SNuovo). %sostituisco il valore della posizione libera

calcola_euristiche(NuoviNodi, C, StatiConEuristiche) :-
    maplist(aggiorna_euristica(C), NuoviNodi, StatiConEuristiche).
    %maplist applica il predicato aggiorna_euristica a ciascun elemento di NuoviNodi

aggiorna_euristica(C, [_, S, P, Apertura], [H, S, P, Apertura]) :-
    euristica(S, F),
    H is C + F.



calcola_euristica_chiusi(NodiChiusi, C, StatiConEuristicheChiusi) :-
    findall([H,S,P,aperto],(
        member([HVecchio,S,P,chiuso], NodiChiusi),
        euristica(S,F),
        H is C + F,
        HVecchio > H,       %controllo se l'euristica è minore di quella già calcolata
        \+ member([_,S,_,aperto], StatiConEuristicheChiusi) %controllo se non è già presente
    ), StatiConEuristicheChiusi).


euristica([],0).
euristica([X|Tail],Ris):-
    finale(Finale),
    member(X,Finale),
    euristica(Tail,Ris).
euristica([X|Tail],Ris):-
    finale(Finale),
    \+ member(X,Finale),
    euristica(Tail,Equal),
    Ris is Equal+1.


visita(Stati, [HMin,SMin,PMin,AperturaMin]):-
    include(aperto, Stati, NodiAperti),
    min_member([HMin, SMin, PMin, AperturaMin], NodiAperti).

aperto([_,_,_, aperto]). %controllo se lo stato è aperto


