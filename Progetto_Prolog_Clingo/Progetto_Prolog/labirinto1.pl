%LABIRINTO PROGETTO come quello prof

%costruzione matrice per il labirinto
num_col(10).
num_righe(10).

%indico quali caselle sono occupate
occupata(pos(2,5)).
occupata(pos(3,5)).
occupata(pos(4,5)).
occupata(pos(5,5)).
occupata(pos(6,5)).
occupata(pos(7,5)).
occupata(pos(7,1)).
occupata(pos(7,2)).
occupata(pos(7,3)).
occupata(pos(7,4)).
occupata(pos(5,7)).
occupata(pos(6,7)).
occupata(pos(7,7)).
occupata(pos(8,7)).
occupata(pos(4,7)).
occupata(pos(4,8)).
occupata(pos(4,9)).
occupata(pos(4,10)).

%blocca pos(1,1)
occupata(pos(1,2)).
occupata(pos(2,1)).

%alternativa per bloccare pos(10,3)
occupata(pos(10,2)).
occupata(pos(9,3)).
occupata(pos(10,4)).

%indico lo stato iniziale e gli stati goal
iniziale(pos(4,2)).

finale(pos(1,1)).
finale(pos(7,9)).
finale(pos(10,3)).
