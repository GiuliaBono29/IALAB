%LABIRINTO PROGETTO NUMERO 4
 
%costruzione matrice per il labirinto 
num_col(20). 
num_righe(10). 
 
%indico quali caselle sono occupate 
occupata(pos(1,16)).

occupata(pos(2,6)).
occupata(pos(2,7)).
occupata(pos(2,8)).
occupata(pos(2,9)).
occupata(pos(2,10)).
occupata(pos(2,11)). 
occupata(pos(2,12)). 
occupata(pos(2,13)). 
occupata(pos(2,14)). 
occupata(pos(2,15)). 
occupata(pos(2,16)).

occupata(pos(3,3)).
occupata(pos(3,4)).
occupata(pos(3,5)).
occupata(pos(3,9)).
occupata(pos(3,14)).
 
occupata(pos(4,9)).
occupata(pos(4,14)).

occupata(pos(5,10)).
occupata(pos(5,13)).

occupata(pos(6,11)).
occupata(pos(6,12)).

occupata(pos(8,1)).
occupata(pos(8,2)).
occupata(pos(8,3)).
occupata(pos(8,4)).
occupata(pos(8,5)).

occupata(pos(9,4)).
occupata(pos(10,4)).

 
%indico lo stato iniziale e lo stato goal 
%iniziale(pos(1,10)).
iniziale(pos(5,9)). 

finale(pos(1,20)). 
finale(pos(5,12)).
finale(pos(9,3)).