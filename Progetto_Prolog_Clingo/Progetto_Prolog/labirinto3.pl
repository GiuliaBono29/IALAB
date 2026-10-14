%LABIRINTO PROGETTO NUMERO 3 
 
%costruzione matrice per il labirinto 
num_col(20). 
num_righe(10). 
 
%indico quali caselle sono occupate 
occupata(pos(1,1)).
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
occupata(pos(2,19)).
occupata(pos(2,20)).

occupata(pos(3,3)).
occupata(pos(3,4)).
occupata(pos(3,5)).
occupata(pos(3,7)).
occupata(pos(3,9)).
occupata(pos(3,15)).
occupata(pos(3,16)).
occupata(pos(3,17)).
 
occupata(pos(4,2)).
occupata(pos(4,7)). 
occupata(pos(4,9)).
occupata(pos(4,14)). 
occupata(pos(4,15)). 
occupata(pos(4,16)).
occupata(pos(4,17)).
occupata(pos(4,18)).
occupata(pos(4,19)).

occupata(pos(5,6)).
occupata(pos(5,7)).
occupata(pos(5,10)).
occupata(pos(5,13)).
occupata(pos(5,17)).

occupata(pos(6,4)).
occupata(pos(6,7)).
occupata(pos(6,10)).
occupata(pos(6,11)).
occupata(pos(6,12)).
occupata(pos(6,13)).
occupata(pos(6,15)).
occupata(pos(6,16)).
occupata(pos(6,17)).
occupata(pos(6,19)).
occupata(pos(6,20)).

occupata(pos(7,4)).
occupata(pos(7,7)).
occupata(pos(7,17)).

occupata(pos(8,1)).
occupata(pos(8,2)).
occupata(pos(8,3)).
occupata(pos(8,4)).
occupata(pos(8,5)).
occupata(pos(8,7)).
occupata(pos(8,9)).
occupata(pos(8,10)).
occupata(pos(8,11)).
occupata(pos(8,12)).
occupata(pos(8,13)).
occupata(pos(8,14)).
occupata(pos(8,17)).
occupata(pos(8,18)).

occupata(pos(9,4)).
occupata(pos(9,10)).
occupata(pos(9,11)).
occupata(pos(9,16)).

occupata(pos(10,4)).
occupata(pos(10,13)). 
occupata(pos(10,14)).
occupata(pos(10,19)). 
occupata(pos(10,20)). 
 
%indico lo stato iniziale e lo stato goal 
iniziale(pos(1,10)).

finale(pos(1,20)). 
finale(pos(5,12)).
finale(pos(9,3)).