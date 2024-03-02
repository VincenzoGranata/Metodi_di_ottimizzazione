% Struttura Materie con punteggio (difficoltà), ore settimanali per ogni materia e nr di selezione (che controlla che le ore settimanali vengano rispettate):

% La function restituisce la struttura della materia in base all'ingresso, cioè se scrivo materie(3) mi restituisce la struct della 3° materia
function materia = materie(x)

materia1.nome = "Matematica e Fisica" ;
materia1.score = 0.8;
materia1.lezioni_settimanali = 7; 
materia1.n_selezioni = 0 ; 

materia2.nome = "Italiano e Latino" ;
materia2.score = 0.7;
materia2.lezioni_settimanali = 7;  
materia2.n_selezioni = 0 ; 

materia3.nome = "Storia e Filosofia" ;
materia3.score = 0.6;
materia3.lezioni_settimanali = 5;  
materia3.n_selezioni = 0 ; 

materia4.nome = "Chimica" ;
materia4.score = 0.5;
materia4.lezioni_settimanali = 3;  
materia4.n_selezioni = 0 ; 

materia5.nome = "Inglese" ;
materia5.score = 0.5;
materia5.lezioni_settimanali = 3;  
materia5.n_selezioni = 0 ; 

materia6.nome = "Arte" ;
materia6.score = 0.3;
materia6.lezioni_settimanali = 2;  
materia6.n_selezioni = 0 ;

materia7.nome = "Motoria" ;
materia7.score = 0.2;
materia7.lezioni_settimanali = 2;  
materia7.n_selezioni = 0 ; 

materia8.nome = "Religione" ;
materia8.score = 0.1;
materia8.lezioni_settimanali = 1;  
materia8.n_selezioni = 0 ; 

% Creazione di un array di strutture per le materie
materieArray = [materia1, materia2, materia3, materia4, materia5, materia6, materia7,materia8];
materia = materieArray(x);

end