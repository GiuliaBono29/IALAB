%FUNZIONI PER APPLICABILITA' E TRASFORMAZIONE
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

%C=numero passi fatti
espandi(S,Path,C,StatiConEuristiche):-
    apri(S,Path,NuoviNodi),                          %creo la lista di stati aperti a partire da S
    calcola_euristiche(NuoviNodi, C, StatiConEuristiche).   %calcolo le euristiche per gli stati aperti

apri(S,Path,NuoviNodi):-   %ritorno tutta la lista aperta
    findall([_, SNuovo, NuovoPath], (       %genera una lista di stati aperti indicando il percorso per raggiungerlo
        applicabile(Azione, S),                     %verifica se l'azione è applicabile
        trasforma(Azione, S, [SOcc, Val], SLib),               %calcola il nuovo stato
        sostituisci_valori(S,  SOcc, SLib, Val, SNuovo),
        append(Path, [[Azione,SLib]], NuovoPath)           %aggiunge lo stato al cammino
    ), NuoviNodi).

sostituisci_valori(S, SOcc, SLib, Val, SNuovo):-
    select([SOcc, nil], S , [SOcc, Val], S1), %sostituisco il valore della posizione occupata
    select([SLib, Val], S1, [SLib, nil], SNuovo). %sostituisco il valore della posizione libera

calcola_euristiche(NuoviNodi, C, StatiConEuristiche) :-
    maplist(aggiorna_euristica(C), NuoviNodi, StatiConEuristiche).   %maplist applica il predicato aggiorna_euristica a ciascun elemento di NuoviNodi

aggiorna_euristica(C, [_, S, P], [H, S, P]) :-
    euristica(S, F),
    H is C + F.


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
