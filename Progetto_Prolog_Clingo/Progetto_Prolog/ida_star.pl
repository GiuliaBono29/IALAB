initialize:-
    retractall(threshold(_)),
    retractall(min(_)),
    iniziale(S0),
    euristica(S0, F0),
    asserta(threshold(F0)).

%Metto un massimo come soglia limite della ricerca, sennò anche se non esiste un percorso andrà avanti all'infinito
ida(Max,Cammino):-
    threshold(SogliaCorrente),
    SogliaCorrente<Max,
    profondita([_,Cammino],SogliaCorrente),
    \+ Cammino==break.

ida(Max,Cammino):-
    retractall(threshold(_)),    %tolgo il valore del threshold
    min(ValoreMinimo),
    ValoreMinimo<Max,
    retractall(min(_)),        %tolgo la lista salvata in min
    asserta(threshold(ValoreMinimo)), %assegno il nuovo valore al threshold
    ida(Max,Cammino).               %richiamo ida con il nuovo threshold

%faccio il cut per impedire di cercare di nuovo tramite il backtracking se non ho trovato soluzioni
%però in questo modo non posso trovare soluzioni alternative
profondita([Minimo,Cammino], SogliaCorrente):-
    iniziale(S0),   %stato iniziale
    euristica(S0, F0),  %calcolo l'euristica
    path_iniz(Path), %creo il cammino iniziale
    ricerca([F0,S0,Path],1,SogliaCorrente,[[F0,S0,Path]],[Minimo,Cammino]),!.
    %primo arg: lista degli stati da esplorare
%altri arg: costo, soglia, atatifigli, risultato

ricerca([H,S,P],_,_,_,[H,P]):-
    finale(S),!. % Se lo stato è finale

ricerca(Stato,C,Threshold,Visitati,[Minimo,Cammino]):- % Parto con uno stato che devo controllare e devo espandere
    Stato = [H,S,P],
    H=<Threshold,       %verifico che sia espandibile
    espandi(S,P,C,StatiFigli), % Espando trovando i figli
    visitati(Visitati,StatiFigli,StatiFigliNonVisitati,NuoviVisitati), % Trovo gli stati visitati e da visitare
    CStar is C+1,
    esplora_figli(StatiFigliNonVisitati, CStar, Threshold, NuoviVisitati, infinito, [Minimo,Cammino]),
    retractall(min(_)),
    asserta(min(Minimo)).

ricerca(Stato,_,Threshold,_,[H,break]):-
    Stato= [H,_,_],
    H>Threshold. % Se il valore di H è maggiore della soglia

visitati(Visitati,StatiFigli,StatiFigliNonVisitati,NuoviVisitati):-
    findall([HFiglio,SFiglio,PFiglio],(
        member([HFiglio,SFiglio,PFiglio],StatiFigli), % Per ogni stato figlio
        \+ member([_,SFiglio,_],Visitati) % Verifico che non sia già visitato
    ), StatiFigliNonVisitati), % Trovo gli stati figli non visitati
    append(Visitati, StatiFigliNonVisitati, NuoviVisitati). % Aggiungo gli stati visitati alla lista

%Non uso un findall per potermi fermare nel mentre se trovo un cammino
esplora_figli([], _, _, _, Min, [Min,break]). % Se non ho trovato un cammino

esplora_figli([Stato | Altri], C, Threshold, Visitati, Min, [MinFinal,CamminoFinal]) :-
    ricerca(Stato, C, Threshold, Visitati, [NewMin, NewCammino]),   %faccio la ricerca su un figlio
    controllo([NewMin, NewCammino],Altri, C, Threshold, Visitati, Min, [MinFinal,CamminoFinal]).  %controllo il risultato e in base a quello continuo la ricerca

controllo([NewMin, NewCammino], Altri, C, Threshold, Visitati, Min, [MinFinal,CamminoFinal]):-  %è presente un break E Altri non è vuoto
    con_break([NewMin, NewCammino]), %H,break oppure H,Cammino
    min_val(Min,NewMin,MinRicavato),
    Altri \== [], % Ci sono ancora stati da esplorare
    esplora_figli(Altri, C, Threshold, Visitati, MinRicavato, [MinFinal,CamminoFinal]). %continuo la ricerca

controllo([NewMin, NewCammino],[], _, _, _, Min, [MinRicavato,NewCammino]):-    %è presente un break E Altri è vuoto, termino la ricerca
    con_break([NewMin, NewCammino]),
    min_val(Min,NewMin,MinRicavato). 

controllo([NewMin, NewCammino],_, _, _, _, _, [NewMin,NewCammino]):-    %è presente il cammino, lo restituisco
    \+ con_break([NewMin, NewCammino]), !.

min_val(Val_1, Val_2, Min) :-
(  Val_2 = infinito -> Min = Val_1;
   Val_1 = infinito -> Min = Val_2;
   Val_1 < Val_2 -> Min = Val_1;
   Val_2 =< Val_1 -> Min = Val_2).

con_break([_,break]). %verifico se il cammino contiene break