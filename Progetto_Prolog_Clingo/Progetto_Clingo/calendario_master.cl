% Settimana da assegnare
settimana(1..24).

% Settimane full-time
settimanaFullTime(7).
settimanaFullTime(16).

% Giorni da assegnare
giorno(lunedi; martedi; mercoledi; giovedi; venerdi; sabato).

% Giorni della settimana full-time
giornoFullTime(lunedi; martedi; mercoledi; giovedi).

% Predicato per definire l'appartenenza di un giorno ad una settimana
% Giorni di una settimana arbitraria
giornoDellaSettimana(Giorno, Settimana) :- giorno(Giorno), settimana(Settimana), not giornoFullTime(Giorno).

% Giorni di una settimana full-time
giornoDellaSettimana(Giorno, Settimana) :- giornoFullTime(Giorno), settimanaFullTime(Settimana).

% Indice dei giorni da assegnare (in modo da poter fare un confronto)
numeroGiorno(lunedi, 1).
numeroGiorno(martedi, 2).
numeroGiorno(mercoledi, 3).
numeroGiorno(giovedi, 4).
numeroGiorno(venerdi, 5).
numeroGiorno(sabato, 6).

% Insegnamenti da assegnare 
insegnamento(presentazione_master).

% Insegnamenti SENZA vincoli di propedeuticità
insegnamento(gestione_qualita).
insegnamento(accessibilita_progettazione_multimediale).
insegnamento(risorse_digitali_progetto).
insegnamento(introduzione_social_media_management).
insegnamento(acquisizione_elaborazione_suono).
insegnamento(comunicazione_pubblicitaria).
insegnamento(semiologia_e_multimedialita).
insegnamento(crossmedia).
insegnamento(gestione_risorse_umane).
insegnamento(vincoli_giuridici_progetto).

% Insegnamenti CON vincoli di propedeuticità
insegnamento(project_management).
insegnamento(fondamenti_ict_e_paradigmi_programmazione).
insegnamento(linguaggi_markup).
insegnamento(ambienti_sviluppo_e_linguaggi_web).
insegnamento(progettazione_grafica_design_interfacce).
insegnamento(progettazione_basi_dati).
insegnamento(strumenti_metodi_interazione_social_media).
insegnamento(acquisizione_ed_elaborazione_immagini_statiche_grafica).
insegnamento(marketing_digitale).
insegnamento(elementi_di_fotografia_digitale).
insegnamento(tecnologie_server_side_per_web).
insegnamento(tecniche_e_strumenti_marketing_digitale).
insegnamento(acquisizione_ed_elaborazione_immagini_digitali).
insegnamento(grafica_3d).
insegnamento(progettazione_e_sviluppo_applicazioni_web_su_mobile_i).
insegnamento(progettazione_e_sviluppo_applicazioni_web_su_mobile_ii).

insegnamento(blocco_libero).

% Docenti che insegnano gli insegnamenti
docente(tomatis).
docente(gena).
docente(boniolo).
docente(suppini).
docente(valle).
docente(gabardi).
docente(santangelo).
docente(taddeo).
docente(lombardo).
docente(travostino).

docente(muzzetto).
docente(schifanella_rossano).
docente(damiano).
docente(terranova).
docente(giordani).
docente(mazzei).
docente(micalizio).
docente(zanchetta).
docente(pozzato).
docente(schifanella_claudio).
docente(vargiu).
docente(gribaudo).
docente(ghidelli).

% Predicati per definire quale docente insegna quale corso
insegna(tomatis, gestione_qualita).
insegna(gena, accessibilita_progettazione_multimediale).
insegna(boniolo, risorse_digitali_progetto).
insegna(suppini, introduzione_social_media_management).
insegna(valle, acquisizione_elaborazione_suono).
insegna(gabardi, comunicazione_pubblicitaria).
insegna(santangelo, semiologia_e_multimedialita).
insegna(taddeo, crossmedia).
insegna(lombardo, gestione_risorse_umane).
insegna(travostino, vincoli_giuridici_progetto).

insegna(muzzetto, project_management).
insegna(muzzetto, marketing_digitale).
insegna(schifanella_rossano, linguaggi_markup).
insegna(damiano, tecnologie_server_side_per_web).
insegna(terranova, progettazione_grafica_design_interfacce).
insegna(giordani, strumenti_metodi_interazione_social_media).
insegna(mazzei, progettazione_basi_dati).
insegna(micalizio, ambienti_sviluppo_e_linguaggi_web).
insegna(zanchetta, tecniche_e_strumenti_marketing_digitale).
insegna(pozzato, fondamenti_ict_e_paradigmi_programmazione).
insegna(schifanella_rossano, progettazione_e_sviluppo_applicazioni_web_su_mobile_i).
insegna(schifanella_claudio, progettazione_e_sviluppo_applicazioni_web_su_mobile_ii).
insegna(zanchetta, acquisizione_ed_elaborazione_immagini_statiche_grafica).
insegna(vargiu, elementi_di_fotografia_digitale).
insegna(gribaudo, grafica_3d).
insegna(ghidelli, acquisizione_ed_elaborazione_immagini_digitali).

% Possibile numero di ore da assegnare 
numeroOre(2).
numeroOre(3).
numeroOre(4).

% Numero di ore da erogare per ciasun insegnamento
oreDaErogare(presentazione_master, 2).

oreDaErogare(gestione_qualita, 10).
oreDaErogare(accessibilita_progettazione_multimediale, 14).
oreDaErogare(risorse_digitali_progetto, 10).
oreDaErogare(introduzione_social_media_management, 14).
oreDaErogare(acquisizione_elaborazione_suono, 10). 
oreDaErogare(comunicazione_pubblicitaria, 14). 
oreDaErogare(semiologia_e_multimedialita, 10). 
oreDaErogare(crossmedia, 20).
oreDaErogare(gestione_risorse_umane, 10). 
oreDaErogare(vincoli_giuridici_progetto, 10).

oreDaErogare(project_management, 14). 
oreDaErogare(marketing_digitale, 10).                               
oreDaErogare(linguaggi_markup, 20).
oreDaErogare(tecnologie_server_side_per_web, 20).
oreDaErogare(progettazione_grafica_design_interfacce, 10).
oreDaErogare(strumenti_metodi_interazione_social_media, 14).
oreDaErogare(progettazione_basi_dati, 20).
oreDaErogare(ambienti_sviluppo_e_linguaggi_web, 20).
oreDaErogare(tecniche_e_strumenti_marketing_digitale, 10).
oreDaErogare(fondamenti_ict_e_paradigmi_programmazione, 14).
oreDaErogare(progettazione_e_sviluppo_applicazioni_web_su_mobile_i, 10).
oreDaErogare(progettazione_e_sviluppo_applicazioni_web_su_mobile_ii, 10).
oreDaErogare(acquisizione_ed_elaborazione_immagini_statiche_grafica, 14).
oreDaErogare(elementi_di_fotografia_digitale, 10).
oreDaErogare(grafica_3d, 20).
oreDaErogare(acquisizione_ed_elaborazione_immagini_digitali, 20).

oreDaErogare(blocco_libero, 12).

% Limite di ore per ogni giorno della settimana
limiteOre(lunedi, 8).
limiteOre(martedi, 8).
limiteOre(mercoledi, 8).
limiteOre(giovedi, 8).
limiteOre(venerdi, 8).
limiteOre(sabato, 6).

% Assegnamento di un insegnamento ad un giorno della settimana arbitrario
0 { assegnamento(Insegnamento, Giorno, Settimana, NumeroOre) : numeroOre(NumeroOre) } 1 :- insegnamento(Insegnamento), giorno(Giorno), settimana(Settimana), giornoDellaSettimana(Giorno, Settimana).

% Vincolo d'integrità per escludere le soluzioni dove l'insegnamento "Tecnologie server-side per il web" viene assegnato con dei blocchi di ore diverso da 4
:- assegnamento(tecnologie_server_side_per_web, _, _, NumeroOre), NumeroOre != 4.

% Vincolo d'integrità per escludere le soluzioni dove i blocchi liberi NON sono assegnati con blocchi da 2 
% (imponendo quindi che i blocchi utilizzati sono 12 / 2 = 6 blocchi)
:- assegnamento(blocco_libero, _, _, NumeroOre), NumeroOre != 2.

% Predicato per imporre la presenza della presentazione master per il primo giorno di lezione (Venerdì della prima settimana)
:- not assegnamento(presentazione_master, venerdi, 1, 2).

% Predicato per ottenere le ore d'insegnamento erogate in un dato giorno 
totaleGiornaliero(Giorno, Settimana, NumeroOreTotali) :-
    giorno(Giorno),
    settimana(Settimana),
    NumeroOreTotali = #sum { NumeroOre, Insegnamento : assegnamento(Insegnamento, Giorno, Settimana, NumeroOre) }.

% Vincolo d'integrità per imporre che il numero di ore in un dato giorno sia maggiore di 8
:- totaleGiornaliero(Giorno, Settimana, NumeroOreTotali),
    limiteOre(Giorno, LimiteNumeroOre),
    NumeroOreTotali > LimiteNumeroOre.

% Predicato per ottenere le ore d'insegnamento erogate da un docente in un dato giorno
oreGiornaliereDocente(Docente, Giorno, Settimana, NumeroOreGiornaliereDocente) :-
    docente(Docente),
    giorno(Giorno),
    settimana(Settimana),
    NumeroOreGiornaliereDocente = #sum { NumeroOre, Insegnamento : assegnamento(Insegnamento, Giorno, Settimana, NumeroOre), insegna(Docente, Insegnamento) }.

% Vincolo d'integrità per escludere tutte quelle soluzioni in cui lo stesso docente insegna per più di 4 ore
:- oreGiornaliereDocente(Docente, Giorno, Settimana, NumeroOreGiornaliereDocente),
    NumeroOreGiornaliereDocente > 4.

% Predicato per contare il numero di ore che vengono erogate per ogni insegnamento
oreComplessiveInsegnamento(Insegnamento, NumeroOreComplessiveInsegnamento) :-
    insegnamento(Insegnamento),
    NumeroOreComplessiveInsegnamento = #sum { NumeroOre, Giorno, Settimana : assegnamento(Insegnamento, Settimana, Giorno, NumeroOre) }.

% Vincolo d'integrità per escludere tutte quelle soluzioni in cui, per un dato insegnamento, vengono erogate un numero di ore diverso da quello richiesto
:- insegnamento(Insegnamento),
    oreComplessiveInsegnamento(Insegnamento, NumeroOreComplessiveInsegnamento),
    oreDaErogare(Insegnamento, NumeroOreDaErogare),
    NumeroOreComplessiveInsegnamento != NumeroOreDaErogare.

% Predicati per ottenere i giorni della prima e dell'ultima lezione di un dato insegnamento (definito tramite giorno e settimana)
giornoPrimaLezione(Insegnamento, NumeroGiornoPrimaLezione) :-
    insegnamento(Insegnamento),
    NumeroGiornoPrimaLezione = #min { NumeroGiorno : assegnamento(Insegnamento, Giorno, _, _), numeroGiorno(Giorno, NumeroGiorno) }.

giornoUltimaLezione(Insegnamento, NumeroGiornoUltimaLezione) :-
    insegnamento(Insegnamento), 
    NumeroGiornoUltimaLezione = #max { NumeroGiorno : assegnamento(Insegnamento, Giorno, _, _), numeroGiorno(Giorno, NumeroGiorno)}.

% Predicato per ottenere le settimane della prima e dell'ultima lezione di un dato insegnamento (definito tramite giorno e settimana)
settimanaPrimaLezione(Insegnamento, SettimanaPrimaLezione) :-
    insegnamento(Insegnamento),
    SettimanaPrimaLezione = #min { Settimana : assegnamento(Insegnamento, _, Settimana, _) }.

settimanaUltimaLezione(Insegnamento, SettimanaUltimaLezione) :-
    insegnamento(Insegnamento),
    SettimanaUltimaLezione = #max { Settimana: assegnamento(Insegnamento, _, Settimana, _) }.

% VINCOLI SUL POSIZIONAMENTO DELLE PRIME E ULTIME LEZIONI
% Vincolo d'integrità per escludere le soluzioni dove la prima lezione di "Crossmedia" NON sia nella seconda settimana full-time
:- settimanaPrimaLezione(crossmedia, SettimanaPrimaLezione), not SettimanaPrimaLezione = 16.

% Vincolo d'integrità per escludere le soluzioni dove la prima lezione di "Introduzione ai social media management" NON sia nella seconda settimana full-time
:- settimanaPrimaLezione(introduzione_social_media_management, SettimanaPrimaLezione), not SettimanaPrimaLezione = 16.

% Vincolo d'integrità per escludere le soluzioni dove l'ultima lezione di "Project Management" sia oltre la prima settimana full-time
:- settimanaUltimaLezione(project_management, SettimanaUltimaLezione), SettimanaUltimaLezione > 7.

% Vincolo d'integrità per escludere le soluzioni dove la prima lezione di "Accessibilità e progettazione multimediale" sia dopo l'ultima lezione di "Linguaggi di markup"
:- settimanaPrimaLezione(accessibilita_progettazione_multimediale, SettimanaPrimaLezioneAccessibilita),
   settimanaUltimaLezione(linguaggi_markup, SettimanaUltimaLezioneLinguaggi),
   SettimanaPrimaLezioneAccessibilita > SettimanaUltimaLezioneLinguaggi.

% Predicato per capire se le lezioni di un insegnamento precedono quelle di un altro insegnamento
% (basandosi sulla settimana)
precede(InsegnamentoUno, InsegnamentoDue) :-
    insegnamento(InsegnamentoUno),
    insegnamento(InsegnamentoDue),
    settimanaPrimaLezione(InsegnamentoDue, SettimanaPrimaLezione),
    settimanaUltimaLezione(InsegnamentoUno, SettimanaUltimaLezione),
    SettimanaUltimaLezione < SettimanaPrimaLezione.

% (basandosi sul giorno, nel caso la settimana sia uguale)
precede(InsegnamentoUno, InsegnamentoDue) :-
    insegnamento(InsegnamentoUno),
    insegnamento(InsegnamentoDue),
    settimanaUltimaLezione(InsegnamentoUno, SettimanaUltimaLezione),
    settimanaPrimaLezione(InsegnamentoDue, SettimanaPrimaLezione),
    giornoUltimaLezione(InsegnamentoUno, NumeroGiornoUltimaLezione),
    giornoPrimaLezione(InsegnamentoDue, NumeroGiornoPrimaLezione),
    SettimanaUltimaLezione = SettimanaPrimaLezione,
    NumeroGiornoUltimaLezione < NumeroGiornoPrimaLezione.

% VINCOLI SULLA PROPEDEUTICITÀ
% Vincolo d'integrità per escludere le soluzioni dove "Project Management" NON precede "Marketing Digitale"
:- not precede(project_management, marketing_digitale).

% Vincolo d'integrità per escludere le soluzioni dove "Project Management" NON precede "Progettazione grafica e design d'interfacce"
:- not precede(project_management, progettazione_grafica_design_interfacce).

% Vincolo d'integrità per escludere le soluzioni dove "Project Management" NON precede "Strumenti e metodi d'interazione nei Social media"
:- not precede(project_management, strumenti_metodi_interazione_social_media).

% Vincolo d'integrità per escludere le soluzioni dove "Progettazione di basi di dati" NON precede "Tecnologie server-side per il web"
:- not precede(progettazione_basi_dati, tecnologie_server_side_per_web).

% Vincolo d'integrità per escludere le soluzioni dove "Linguaggi mark-up" NON precede "Ambienti di sviluppo e linguaggi client-side per il web"
:- not precede(linguaggi_markup, ambienti_sviluppo_e_linguaggi_web).

% Vincolo d'integrità per escludere le soluzioni dove "Marketing digitale" NON precede "Tecniche e strumenti di Marketing digitale"
:- not precede(marketing_digitale, tecniche_e_strumenti_marketing_digitale).

% Vincolo d'integrità per escludere le soluzioni dove "Fondamenti di ICT e paradigmi di programmazione" NON precede "Ambienti di sviluppo e linguaggi client-side per il web" 
:- not precede(fondamenti_ict_e_paradigmi_programmazione, ambienti_sviluppo_e_linguaggi_web).

% Vincolo d'integrità per escludere le soluzioni dove "Ambienti di sviluppo e linguaggi client-side per il web" NON precede "Progettazione e sviluppo di applicazioni web su dispositivi mobile I"
:- not precede(ambienti_sviluppo_e_linguaggi_web, progettazione_e_sviluppo_applicazioni_web_su_mobile_i).

% Vincolo d'integrità per escludere le soluzioni dove "Progettazione e sviluppo di applicazioni web su dispositivi mobile I" NON precede "Progettazione e sviluppo di applicazioni web su dispositivi mobile II"
:- not precede(progettazione_e_sviluppo_applicazioni_web_su_mobile_i, progettazione_e_sviluppo_applicazioni_web_su_mobile_ii).

% Vincolo d'integrità per escludere le soluzioni dove "Acquisizione ed elaborazione di immagini statiche - grafica" NON precede "Elementi di fotografia digitale"
:- not precede(acquisizione_ed_elaborazione_immagini_statiche_grafica, elementi_di_fotografia_digitale).

% Vincolo d'integrità per escludere le soluzioni dove "Acquisizione ed elaborazione di immagini statiche - grafica" NON precede "Grafica 3D"
:- not precede(acquisizione_ed_elaborazione_immagini_statiche_grafica, grafica_3d).

% Vincolo d'integrità per escludere le soluzioni dove "Elementi di fotografia digitale" NON precede "Acquisizione ed elaborazione di immagini digitali"
:- not precede(elementi_di_fotografia_digitale, acquisizione_ed_elaborazione_immagini_digitali).

% Predicato per indicare la distanza fra la prima ed ultima di un insegnamento (in settimane)
distanzaPrimaUltimaLezione(Insegnamento, DistanzaPrimaUltimaLezione) :-
    insegnamento(Insegnamento),
    settimanaPrimaLezione(Insegnamento, SettimanaPrimaLezione),
    settimanaUltimaLezione(Insegnamento, SettimanaUltimaLezione),
    DistanzaPrimaUltimaLezione = SettimanaUltimaLezione - SettimanaPrimaLezione.

% Vincolo d'integrità per escludere le soluzioni dove la distanza fra la prima e ultima lezione di un insegnamento supera le 8 settimane
:- insegnamento(Insegnamento),
    distanzaPrimaUltimaLezione(Insegnamento, DistanzaPrimaUltimaLezione),
    DistanzaPrimaUltimaLezione > 8.

#show assegnamento/4. 