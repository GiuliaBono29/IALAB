%GIOCO OTTO 1

%costruzione matrice
num_col(3).
num_righe(3).

%indico che valori hanno le date posizioni
%NB per aumentare memoria : swipl --stack-limit=3g

%BLOCCO 1
%A* SI --- IDA* SI
%iniziale([[pos(1,1),4],[pos(1,2),1],[pos(1,3),2],[pos(2,1),nil],[pos(2,2),5],[pos(2,3),3],[pos(3,1),7],[pos(3,2),8],[pos(3,3),6]]). %T1 m=5
%iniziale([[pos(1,1),4],[pos(1,2),1],[pos(1,3),2],[pos(2,1),7],[pos(2,2),nil],[pos(2,3),3],[pos(3,1),8],[pos(3,2),5],[pos(3,3),6]]). %T2 m=8
%iniziale([[pos(1,1),4],[pos(1,2),1],[pos(1,3),2],[pos(2,1),7],[pos(2,2),3],[pos(2,3),6],[pos(3,1),8],[pos(3,2),5],[pos(3,3),nil]]). %T3 m=10
%iniziale([[pos(1,1),4],[pos(1,2),1],[pos(1,3),2],[pos(2,1),7],[pos(2,2),3],[pos(2,3),6],[pos(3,1),8],[pos(3,2),nil],[pos(3,3),5]]). %T4 m=11
%iniziale([[pos(1,1),4],[pos(1,2),1],[pos(1,3),2],[pos(2,1),7],[pos(2,2),nil],[pos(2,3),6],[pos(3,1),8],[pos(3,2),3],[pos(3,3),5]]). %T5 m=12
%iniziale([[pos(1,1),4],[pos(1,2),nil],[pos(1,3),2],[pos(2,1),7],[pos(2,2),1],[pos(2,3),6],[pos(3,1),8],[pos(3,2),3],[pos(3,3),5]]). %T6 m=13
%iniziale([[pos(1,1),nil],[pos(1,2),4],[pos(1,3),2],[pos(2,1),7],[pos(2,2),1],[pos(2,3),6],[pos(3,1),8],[pos(3,2),3],[pos(3,3),5]]). %T7 m=14
%A* NO (3g) -- IDA* SI
%iniziale([[pos(1,1),7],[pos(1,2),4],[pos(1,3),2],[pos(2,1),nil],[pos(2,2),1],[pos(2,3),6],[pos(3,1),8],[pos(3,2),3],[pos(3,3),5]]). %T8 m=15

%BLOCCO 2
%A* SI --- IDA* SI
%iniziale([[pos(1,1),1],[pos(1,2),2],[pos(1,3),3],[pos(2,1),4],[pos(2,2),6],[pos(2,3),8],[pos(3,1),7],[pos(3,2),nil],[pos(3,3),5]]). %T1 m=5
%iniziale([[pos(1,1),nil],[pos(1,2),1],[pos(1,3),3],[pos(2,1),6],[pos(2,2),2],[pos(2,3),8],[pos(3,1),4],[pos(3,2),7],[pos(3,3),5]]). %T2 m=10
%iniziale([[pos(1,1),6],[pos(1,2),1],[pos(1,3),3],[pos(2,1),2],[pos(2,2),nil],[pos(2,3),8],[pos(3,1),4],[pos(3,2),7],[pos(3,3),5]]). %T3 m=12
%iniziale([[pos(1,1),6],[pos(1,2),1],[pos(1,3),3],[pos(2,1),2],[pos(2,2),8],[pos(2,3),nil],[pos(3,1),4],[pos(3,2),7],[pos(3,3),5]]). %T4 m=13
%A* SI (2g) -- IDA* SI
%iniziale([[pos(1,1),6],[pos(1,2),1],[pos(1,3),3],[pos(2,1),2],[pos(2,2),8],[pos(2,3),5],[pos(3,1),4],[pos(3,2),7],[pos(3,3),nil]]). %T5 m=14

%BLOCCO 3
%A* SI --- IDA* SI
%iniziale([[pos(1,1),nil],[pos(1,2),5],[pos(1,3),2],[pos(2,1),1],[pos(2,2),8],[pos(2,3),3],[pos(3,1),4],[pos(3,2),7],[pos(3,3),6]]). %T1 m=8
%iniziale([[pos(1,1),5],[pos(1,2),2],[pos(1,3),3],[pos(2,1),1],[pos(2,2),nil],[pos(2,3),8],[pos(3,1),4],[pos(3,2),7],[pos(3,3),6]]). %T2 m=12
%iniziale([[pos(1,1),5],[pos(1,2),2],[pos(1,3),3],[pos(2,1),1],[pos(2,2),7],[pos(2,3),8],[pos(3,1),4],[pos(3,2),nil],[pos(3,3),6]]). %T3 m=13
%A* NO (3g) -- IDA* SI
%iniziale([[pos(1,1),5],[pos(1,2),2],[pos(1,3),3],[pos(2,1),1],[pos(2,2),4],[pos(2,3),8],[pos(3,1),nil],[pos(3,2),7],[pos(3,3),6]]). %T4 m=14

%BLOCCO 4
%A* SI --- IDA* SI
%iniziale([[pos(1,1),nil],[pos(1,2),3],[pos(1,3),6],[pos(2,1),1],[pos(2,2),5],[pos(2,3),2],[pos(3,1),4],[pos(3,2),7],[pos(3,3),8]]). %T1 m=10
%iniziale([[pos(1,1),3],[pos(1,2),6],[pos(1,3),2],[pos(2,1),1],[pos(2,2),5],[pos(2,3),nil],[pos(3,1),4],[pos(3,2),7],[pos(3,3),8]]). %T2 m=13
%iniziale([[pos(1,1),3],[pos(1,2),6],[pos(1,3),2],[pos(2,1),1],[pos(2,2),5],[pos(2,3),8],[pos(3,1),4],[pos(3,2),7],[pos(3,3),nil]]). %T3 m=14
%A* Si (3g) -- IDA* SI
%iniziale([[pos(1,1),3],[pos(1,2),6],[pos(1,3),2],[pos(2,1),1],[pos(2,2),5],[pos(2,3),8],[pos(3,1),4],[pos(3,2),nil],[pos(3,3),7]]). %T4 m=15
%iniziale([[pos(1,1),3],[pos(1,2),6],[pos(1,3),2],[pos(2,1),1],[pos(2,2),nil],[pos(2,3),8],[pos(3,1),4],[pos(3,2),5],[pos(3,3),7]]). %T5 m=16
%A* NO (4g) --- IDA* SI
iniziale([[pos(1,1),3],[pos(1,2),6],[pos(1,3),2],[pos(2,1),nil],[pos(2,2),1],[pos(2,3),8],[pos(3,1),4],[pos(3,2),5],[pos(3,3),7]]). %T6 m=17

%BLOCCO 5 (esempio consegna)
%A* NO (5g) --- IDA* SI
%iniziale([[pos(1,1),7],[pos(1,2),3],[pos(1,3),1],[pos(2,1),5],[pos(2,2),nil],[pos(2,3),6],[pos(3,1),8],[pos(3,2),2],[pos(3,3),4]]).

%finale fisso
finale([[pos(1,1),1],[pos(1,2),2],[pos(1,3),3],[pos(2,1),4],[pos(2,2),5],[pos(2,3),6],[pos(3,1),7],[pos(3,2),8],[pos(3,3),nil]]).
