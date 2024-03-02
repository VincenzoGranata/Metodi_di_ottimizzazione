% Struttura insegnanti, con nome, ID, materia e classi in cui può stare:

% La function restituisce il vettore che ha come elementi la struttura di tutti gli insegnanti

function teachersArray = insegnanti()

teacher1.name = 'MAT/FIS(1)';
teacher1.ID = 1;
teacher1.subject = materie(1);
teacher1.class = [1,2,3];
teacher1.giorni = 1:5;

teacher2.name = 'MAT/FIS(2)';
teacher2.ID = 2;
teacher2.subject = materie(1);
teacher2.class = [4,5,6];
teacher2.giorni = 1:5;

teacher3.name = 'IT/LAT(1)';
teacher3.ID = 3;
teacher3.subject = materie(2);
teacher3.class = [1,2,3];
teacher3.giorni = 1:5;

teacher4.name = 'IT/LAT(2)';
teacher4.ID = 4;
teacher4.subject = materie(2);
teacher4.class = [4,5,6];
teacher4.giorni = 1:5;

teacher5.name = 'ST/FIL(1)';
teacher5.ID = 5;
teacher5.subject = materie(3);
teacher5.class = [1,2,3];
teacher5.giorni = 1:5;

teacher6.name = 'ST/FIL(2)';
teacher6.ID = 6;
teacher6.subject = materie(3);
teacher6.class = [4,5,6];
teacher6.giorni = 1:5;

teacher7.name = 'CHI';
teacher7.ID = 7;
teacher7.subject = materie(4);
teacher7.class = [1,2,3,4,5,6];
teacher7.giorni = 1:5;

teacher8.name = 'ING';
teacher8.ID = 8;
teacher8.subject = materie(5);
teacher8.class = [1,2,3,4,5,6];
teacher8.giorni = 1:5;

teacher9.name = 'ART';
teacher9.ID = 9;
teacher9.subject = materie(6);
teacher9.class = [1,2,3,4,5,6];
teacher9.giorni = 1:5;

teacher10.name = 'MOT';
teacher10.ID = 10;
teacher10.subject = materie(7);
teacher10.class = [1,2,3,4,5,6];
teacher10.giorni = [2,3,4];

teacher11.name = 'REL';
teacher11.ID = 11;
teacher11.subject = materie(8);
teacher11.class = [1,2,3,4,5,6];
teacher11.giorni = [1,2,3];


% Creazione di un array di strutture per gli insegnanti
teachersArray = [teacher1, teacher2, teacher3, teacher4, teacher5, teacher6, teacher7, teacher8, teacher9, teacher10, teacher11];

end