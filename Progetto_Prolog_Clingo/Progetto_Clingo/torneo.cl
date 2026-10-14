squadra(italia, europa).
squadra(francia, europa).
squadra(germania, europa).
squadra(portogallo, europa).
squadra(spagna, europa).
squadra(irlanda, europa).
squadra(svezia, europa).
squadra(macedonia, europa).
squadra(romania, europa).
squadra(croazia, europa).

squadra(stati_uniti, nordCentroAmerica).
squadra(canada, nordCentroAmerica).
squadra(nicaragua, nordCentroAmerica).
squadra(messico, nordCentroAmerica).

squadra(argentina, sudAmerica).
squadra(cile, sudAmerica).
squadra(colombia, sudAmerica).
squadra(brasile, sudAmerica).
squadra(peru, sudAmerica).
squadra(venezuela, sudAmerica).
squadra(ecuador, sudAmerica).
squadra(paraguay, sudAmerica).

squadra(giappone, asia).
squadra(cina, asia).
squadra(corea, asia).
squadra(thailandia, asia).

squadra(namibia, africa).
squadra(nigeria, africa).
squadra(niger, africa).
squadra(ghana, africa).

squadra(australia, oceania).
squadra(nuova_zelanda, oceania).

girone(1..8).

%una squadra è presente in un unico girone
1 { suddivisione(S, Z, G) : girone(G) } 1:- squadra(S,Z).

%un girone contiene 4 squadra
4 { suddivisione(S, Z, G) : squadra(S,Z) } 4:- girone(G).

%#show suddivisione/3.
%suddivisione(argentina,sudAmerica,1) suddivisione(niger,africa,1) suddivisione(ghana,africa,1) suddivisione(australia,oceania,1) suddivisione(corea,asia,2) suddivisione(thailandia,asia,2) suddivisione(namibia,africa,2) suddivisione(nigeria,africa,2) suddivisione(nicaragua,nordCentroAmerica,3) suddivisione(messico,nordCentroAmerica,3) suddivisione(cile,sudAmerica,3) suddivisione(colombia,sudAmerica,3) suddivisione(romania,europa,4) suddivisione(croazia,europa,4) suddivisione(stati_uniti,nordCentroAmerica,4) suddivisione(canada,nordCentroAmerica,4) suddivisione(spagna,europa,5) suddivisione(irlanda,europa,5) suddivisione(svezia,europa,5) suddivisione(macedonia,europa,5) suddivisione(italia,europa,6) suddivisione(francia,europa,6) suddivisione(germania,europa,6) suddivisione(portogallo,europa,6) suddivisione(peru,sudAmerica,7) suddivisione(venezuela,sudAmerica,7) suddivisione(giappone,asia,7) suddivisione(nuova_zelanda,oceania,7) suddivisione(brasile,sudAmerica,8) suddivisione(equador,sudAmerica,8) suddivisione(paraguay,sudAmerica,8) suddivisione(cina,asia,8)

%un girone corretto è un girone in cui 3 zone sono diverse
girone_suddiviso_bene(G) :- suddivisione(S1, Z1, G), suddivisione(S2, Z2, G), suddivisione(S3, Z3, G), Z1 != Z2, Z1 != Z3, Z2 != Z3.

%se è presente un girone che non è un girone corretto, allora è false
:- girone(G), not girone_suddiviso_bene(G).

%#show girone_suddiviso_bene/1. 
%#show suddivisione/3.

%suddivisione(brasile,sudAmerica,1) suddivisione(thailandia,asia,1) suddivisione(namibia,africa,1) suddivisione(stati_uniti,nordCentroAmerica,2) suddivisione(argentina,sudAmerica,2) suddivisione(cile,sudAmerica,2) suddivisione(italia,europa,3) suddivisione(corea,asia,3) suddivisione(nigeria,africa,3) suddivisione(niger,africa,3) suddivisione(venezuela,sudAmerica,4) suddivisione(equador,sudAmerica,4) suddivisione(canada,nordCentroAmerica,4) suddivisione(ghana,africa,5) suddivisione(australia,oceania,5) suddivisione(nuova_zelanda,oceania,5) suddivisione(colombia,sudAmerica,6) suddivisione(giappone,asia,6) suddivisione(cina,asia,6) suddivisione(paraguay,sudAmerica,7) suddivisione(messico,nordCentroAmerica,7) suddivisione(peru,sudAmerica,8) suddivisione(nicaragua,nordCentroAmerica,8) suddivisione(francia,europa,8) suddivisione(germania,europa,1) suddivisione(portogallo,europa,8) suddivisione(spagna,europa,2) suddivisione(irlanda,europa,6) suddivisione(svezia,europa,5) suddivisione(macedonia,europa,4) suddivisione(romania,europa,7) suddivisione(croazia,europa,7)

categoria(testa_di_serie; fascia_1; fascia_2; underdog).

%ogni suddivisione contiene 4 categorie
4 { suddivisione(S, Z, G) : squadra(S,Z) } 4 :- girone(G).

%ogni squadra può avere una unica categoria
1 { partizionamento(S, Z, G, C) : categoria(C) } 1 :- suddivisione(S, Z, G).


8 { partizionamento(S, Z, G, C) :  suddivisione(S, Z, G) } 8 :- categoria(C).

%#show partizionamento/4.
%partizionamento(spagna,europa,5,testa_di_serie) partizionamento(svezia,europa,1,testa_di_serie) partizionamento(macedonia,europa,6,testa_di_serie) partizionamento(colombia,sudAmerica,3,testa_di_serie) partizionamento(brasile,sudAmerica,5,testa_di_serie) partizionamento(ghana,africa,2,testa_di_serie) partizionamento(australia,oceania,8,testa_di_serie) partizionamento(nuova_zelanda,oceania,7,testa_di_serie) partizionamento(portogallo,europa,3,fascia_1) partizionamento(irlanda,europa,2,fascia_1) partizionamento(ecuador,sudAmerica,3,fascia_1) partizionamento(paraguay,sudAmerica,6,fascia_1) partizionamento(cina,asia,8,fascia_1) partizionamento(corea,asia,7,fascia_1) partizionamento(namibia,africa,6,fascia_1) partizionamento(niger,africa,3,fascia_1) partizionamento(italia,europa,4,fascia_2) partizionamento(germania,europa,5,fascia_2) partizionamento(canada,nordCentroAmerica,8,fascia_2) partizionamento(nicaragua,nordCentroAmerica,7,fascia_2) partizionamento(messico,nordCentroAmerica,5,fascia_2) partizionamento(argentina,sudAmerica,1,fascia_2) partizionamento(venezuela,sudAmerica,6,fascia_2) partizionamento(nigeria,africa,4,fascia_2) partizionamento(francia,europa,2,underdog) partizionamento(romania,europa,1,underdog) partizionamento(croazia,europa,4,underdog) partizionamento(stati_uniti,nordCentroAmerica,1,underdog) partizionamento(cile,sudAmerica,2,underdog) partizionamento(peru,sudAmerica,4,underdog) partizionamento(giappone,asia,8,underdog) partizionamento(thailandia,asia,7,underdog)

%nello stesso girone non può esserci una stessa categoria con due squadre diverse
:- partizionamento(S1, Z1, G, C), partizionamento(S2, Z2, G, C), S1 != S2.

%show partizionamento/4.
%partizionamento(paraguay,sudAmerica,1,testa_di_serie) partizionamento(venezuela,sudAmerica,1,fascia_1) partizionamento(stati_uniti,nordCentroAmerica,1,fascia_2) partizionamento(romania,europa,1,underdog) partizionamento(ghana,africa,2,testa_di_serie) partizionamento(irlanda,europa,2,fascia_1) partizionamento(spagna,europa,2,fascia_2) partizionamento(argentina,sudAmerica,2,underdog) partizionamento(colombia,sudAmerica,3,testa_di_serie) partizionamento(niger,africa,3,fascia_1) partizionamento(portogallo,europa,3,fascia_2) partizionamento(cile,sudAmerica,3,underdog) partizionamento(nigeria,africa,4,testa_di_serie) partizionamento(germania,europa,4,fascia_1) partizionamento(peru,sudAmerica,4,fascia_2) partizionamento(croazia,europa,4,underdog) partizionamento(brasile,sudAmerica,5,testa_di_serie) partizionamento(messico,nordCentroAmerica,5,fascia_1) partizionamento(francia,europa,5,fascia_2) partizionamento(italia,europa,5,underdog) partizionamento(macedonia,europa,6,testa_di_serie) partizionamento(svezia,europa,6,fascia_1) partizionamento(ecuador,sudAmerica,6,fascia_2) partizionamento(namibia,africa,6,underdog) partizionamento(corea,asia,7,testa_di_serie) partizionamento(nuova_zelanda,oceania,7,fascia_1) partizionamento(nicaragua,nordCentroAmerica,7,fascia_2) partizionamento(thailandia,asia,7,underdog) partizionamento(australia,oceania,8,testa_di_serie) partizionamento(cina,asia,8,fascia_1) partizionamento(canada,nordCentroAmerica,8,fascia_2) partizionamento(giappone,asia,8,underdog)

%_________________________________________________________________________________________________________

giornata(giornata1; giornata2; giornata3).

8 {torneo(G, D) : girone(G) } 8 :- giornata(D).
3 {torneo(G, D) : giornata(D) } 3 :- girone(G).
%#show torneo/2.
%torneo(1,giornata1) torneo(1,giornata2) torneo(1,giornata3) torneo(2,giornata1) torneo(2,giornata2) torneo(2,giornata3) torneo(3,giornata1) torneo(3,giornata2) torneo(3,giornata3) torneo(4,giornata1) torneo(4,giornata2) torneo(4,giornata3) torneo(5,giornata1) torneo(5,giornata2) torneo(5,giornata3) torneo(6,giornata1) torneo(6,giornata2) torneo(6,giornata3) torneo(7,giornata1) torneo(7,giornata2) torneo(7,giornata3) torneo(8,giornata1) torneo(8,giornata2) torneo(8,giornata3)

%sfidante è la squadra che gioca nel girone G il giorno D
sfidante(S, Z, G, D) :- suddivisione(S, Z, G), torneo(G, D).

%#show sfidante/4.
%sfidante(italia,europa,1,giornata1) sfidante(spagna,europa,1,giornata1) sfidante(canada,nordCentroAmerica,1,giornata1) sfidante(nigeria,africa,1,giornata1) sfidante(svezia,europa,2,giornata1) sfidante(cile,sudAmerica,2,giornata1) sfidante(giappone,asia,2,giornata1) sfidante(namibia,africa,2,giornata1) sfidante(macedonia,europa,3,giornata1) sfidante(messico,nordCentroAmerica,3,giornata1) sfidante(colombia,sudAmerica,3,giornata1) sfidante(brasile,sudAmerica,3,giornata1) sfidante(francia,europa,4,giornata1) sfidante(portogallo,europa,4,giornata1) sfidante(nicaragua,nordCentroAmerica,4,giornata1) sfidante(thailandia,asia,4,giornata1) sfidante(croazia,europa,5,giornata1) sfidante(ecuador,sudAmerica,5,giornata1) sfidante(paraguay,sudAmerica,5,giornata1) sfidante(ghana,africa,5,giornata1) sfidante(romania,europa,6,giornata1) sfidante(peru,sudAmerica,6,giornata1) sfidante(venezuela,sudAmerica,6,giornata1) sfidante(niger,africa,6,giornata1) sfidante(germania,europa,7,giornata1) sfidante(irlanda,europa,7,giornata1) sfidante(argentina,sudAmerica,7,giornata1) sfidante(nuova_zelanda,oceania,7,giornata1) sfidante(stati_uniti,nordCentroAmerica,8,giornata1) sfidante(cina,asia,8,giornata1) sfidante(corea,asia,8,giornata1) sfidante(australia,oceania,8,giornata1) sfidante(italia,europa,1,giornata2) sfidante(spagna,europa,1,giornata2) sfidante(canada,nordCentroAmerica,1,giornata2) sfidante(nigeria,africa,1,giornata2) sfidante(svezia,europa,2,giornata2) sfidante(cile,sudAmerica,2,giornata2) sfidante(giappone,asia,2,giornata2) sfidante(namibia,africa,2,giornata2) sfidante(macedonia,europa,3,giornata2) sfidante(messico,nordCentroAmerica,3,giornata2) sfidante(colombia,sudAmerica,3,giornata2) sfidante(brasile,sudAmerica,3,giornata2) sfidante(francia,europa,4,giornata2) sfidante(portogallo,europa,4,giornata2) sfidante(nicaragua,nordCentroAmerica,4,giornata2) sfidante(thailandia,asia,4,giornata2) sfidante(croazia,europa,5,giornata2) sfidante(ecuador,sudAmerica,5,giornata2) sfidante(paraguay,sudAmerica,5,giornata2) sfidante(ghana,africa,5,giornata2) sfidante(romania,europa,6,giornata2) sfidante(peru,sudAmerica,6,giornata2) sfidante(venezuela,sudAmerica,6,giornata2) sfidante(niger,africa,6,giornata2) sfidante(germania,europa,7,giornata2) sfidante(irlanda,europa,7,giornata2) sfidante(argentina,sudAmerica,7,giornata2) sfidante(nuova_zelanda,oceania,7,giornata2) sfidante(stati_uniti,nordCentroAmerica,8,giornata2) sfidante(cina,asia,8,giornata2) sfidante(corea,asia,8,giornata2) sfidante(australia,oceania,8,giornata2) sfidante(italia,europa,1,giornata3) sfidante(spagna,europa,1,giornata3) sfidante(canada,nordCentroAmerica,1,giornata3) sfidante(nigeria,africa,1,giornata3) sfidante(svezia,europa,2,giornata3) sfidante(cile,sudAmerica,2,giornata3) sfidante(giappone,asia,2,giornata3) sfidante(namibia,africa,2,giornata3) sfidante(macedonia,europa,3,giornata3) sfidante(messico,nordCentroAmerica,3,giornata3) sfidante(colombia,sudAmerica,3,giornata3) sfidante(brasile,sudAmerica,3,giornata3) sfidante(francia,europa,4,giornata3) sfidante(portogallo,europa,4,giornata3) sfidante(nicaragua,nordCentroAmerica,4,giornata3) sfidante(thailandia,asia,4,giornata3) sfidante(croazia,europa,5,giornata3) sfidante(ecuador,sudAmerica,5,giornata3) sfidante(paraguay,sudAmerica,5,giornata3) sfidante(ghana,africa,5,giornata3) sfidante(romania,europa,6,giornata3) sfidante(peru,sudAmerica,6,giornata3) sfidante(venezuela,sudAmerica,6,giornata3) sfidante(niger,africa,6,giornata3) sfidante(germania,europa,7,giornata3) sfidante(irlanda,europa,7,giornata3) sfidante(argentina,sudAmerica,7,giornata3) sfidante(nuova_zelanda,oceania,7,giornata3) sfidante(stati_uniti,nordCentroAmerica,8,giornata3) sfidante(cina,asia,8,giornata3) sfidante(corea,asia,8,giornata3) sfidante(australia,oceania,8,giornata3)

%ci sono 96 "sfidante", e infatti le squadre sono 32 e ogni squadra gioca 3 partie :)

%Ogni sfidante si batte con 1 sfidante al giorno
1 { sfida(S_a, Z_a, S_b, Z_b, G, D) : sfidante(S_a, Z_a, G, D), S_a != S_b } 1 :- sfidante(S_b, Z_b, G, D).
1 { sfida(S_a, Z_a, S_b, Z_b, G, D) : sfidante(S_b, Z_b, G, D), S_a != S_b } 1 :- sfidante(S_a, Z_a, G, D). 

%se i giorni sono diversi, allora allora due squadre che hanno già disputato una sfida in un giorno non posso disputarla nuovamente un altro giorno
:- sfida(S_a1, Z_a1, S_b1, Z_b1, G, D1), sfida(S_a2, Z_a2, S_b2, Z_b2, G, D2), D1 != D2, S_a1 = S_a2, S_b1 = S_b2.
:- sfida(S_a1, Z_a1, S_b1, Z_b1, G, D1), sfida(S_a2, Z_a2, S_b2, Z_b2, G, D2), D1 != D2, S_a1 = S_b2, S_b1 = S_a2.
%:- sfida(S_a1, Z_a1, S_b1, Z_b1, G, D1), sfida(S_a2, Z_a2, S_b2, Z_b2, G, D2), D1 = D2, S_a1 = S_b2, S_b1 = S_a2.
%#show sfida/6.

risultato(S_a, S_b, D, G) :- sfida(S_a, Z_a, S_b, Z_b, G, D).
%altri tentativi falliti per togliere la simmetria:
%* 1 { risultato(G, S_a, S_b, D) : sfidante(S_a, Z_a, G, D) }1 :- sfida(S_a, Z_a, S_b, Z_b, G, D).
3 { risultato(G, S_a, S_b, D) : sfida(S_a, Z_a, S_b, Z_b, G, D) }3 :- torneo(G, D). *%
%* :- risultato(S_a, S_b, D, G), risultato(S_b, S_a, D, G). *%

%per togliere la simmetria
risultato_finale(S_a, S_b, D, G) :- risultato(S_a, S_b, D, G), S_a < S_b.
#show risultato_finale/4.

