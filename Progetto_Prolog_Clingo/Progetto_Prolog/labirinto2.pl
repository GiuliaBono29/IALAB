%LABIRINTO PROGETTO NUMERO 2 
 
%costruzione matrice per il labirinto 
num_col(10). 
num_righe(10). 
 
%indico quali caselle sono occupate 
occupata(pos(2,3)). 
occupata(pos(2,4)). 
occupata(pos(2,5)). 
occupata(pos(2,6)). 
occupata(pos(2,7)). 
occupata(pos(2,8)). 
occupata(pos(2,9)). 
occupata(pos(2,10)). 
occupata(pos(3,9)).
occupata(pos(4,1)). 
occupata(pos(4,2)).
occupata(pos(4,3)). 
occupata(pos(4,4)).
occupata(pos(4,5)). 
occupata(pos(4,9)). 
occupata(pos(4,10)). 
occupata(pos(6,5)).
occupata(pos(6,6)).
occupata(pos(6,7)).
occupata(pos(6,8)). 
occupata(pos(7,1)).
occupata(pos(7,2)).
occupata(pos(7,3)).
occupata(pos(7,5)).
occupata(pos(7,8)). 
occupata(pos(8,5)).
occupata(pos(8,7)).
occupata(pos(8,8)). 
occupata(pos(9,2)).
occupata(pos(9,3)).
occupata(pos(9,4)).
occupata(pos(9,5)). 
occupata(pos(10,5)). 
occupata(pos(10,7)). 
 
%indico lo stato iniziale e lo stato goal 
iniziale(pos(1,10)).

finale(pos(3,10)). 
finale(pos(7,7)).
finale(pos(10,4)).