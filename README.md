# Intelligenza Artificiale – Laboratorio (IALAB)

Progetti sviluppati per il corso di **Intelligenza Artificiale Laboratorio** della Laurea Magistrale in Informatica, Università di Torino. Il corso affronta tre paradigmi: ricerca nello spazio degli stati in Prolog, programmazione a vincoli con Answer Set Programming e sistemi a regole con agenti in CLIPS. Il progetto è stato sviluppato in gruppo per il corso di IALAB, insieme a due collaboratore.

## Tecnologie usate

* Prolog (SWI-Prolog)
* Clingo (Answer Set Programming)
* CLIPS (sistemi a regole)

## Progetti

### Parte 1 – Prolog e Clingo

* **Algoritmi di ricerca informata in Prolog:** implementazione di **A\*** e **IDA\*** applicati a due problemi, il labirinto (euristica: distanza di Manhattan) e il gioco dell'otto (euristica: numero di caselle fuori posto). Il confronto mostra che A\* è più veloce ma usa molta memoria, e funziona bene sul labirinto. IDA\*, al contrario, usa poca memoria e si comporta meglio sul gioco dell'otto, dove lo spazio degli stati è molto grande.
* **Gestione di tornei con Clingo:** modellazione in Answer Set Programming della generazione di un torneo (squadre, sfide) e di un calendario di insegnamenti con vincoli di precedenza. Il solver trova un answer set in circa 20 secondi con tutti i vincoli attivi.

### Parte 2 – Battaglia navale con agenti CLIPS

Due agenti a regole che giocano a battaglia navale con informazioni parziali (indizi sulle celle e numero di navi per riga e colonna):

* **Agente 1:** ragionamento più avanzato. Deduce la forma delle navi dalle informazioni raccolte e spara nei punti con maggiore probabilità di successo.
* **Agente 2:** ragionamento più semplice. Spara e fa ipotesi nelle celle vicine a quelle già note, ma dipende molto dagli indizi iniziali.

I due agenti sono stati confrontati su diversi scenari, valutando i punteggi ottenuti al variare delle informazioni fornite.

## Dati

Non servono dataset esterni. Sono necessari gli interpreti di SWI-Prolog, Clingo e CLIPS per eseguire il codice.

