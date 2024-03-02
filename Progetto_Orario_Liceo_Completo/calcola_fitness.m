% Funzione che calcola la fitness per ogni individuo

function fitness = calcola_fitness(individuo)


    %------------------------------------------------VINCOLO 1------------------------------------------------%

    % Vincolo1: Un'insegnante non può essere contemporaneamente in più aule (gestione della sovrapposizione)
    p_sovrapposizione = 0;          % nr di conflitti legati alla sovrapposizione
    for k=1:6      % Confronto ogni classe con tutte le altre
        for kk=k+1:6
    
            for i=1:6   % Scorro tutti gli elementi della matrice per confrontarli
                for j=1:5
                    i_orario = individuo(:,:,k);        % sarebbe più corretto scrivere k_orario e kk_orario. Sono gli orari della classe k-esima confrontati     
                    j_orario = individuo(:,:,kk);       % con l'orario della classe kk-esima

                    % Confronto elemento per elemento delle due matrici (classi) ogni volta
                    if i_orario(i,j) == j_orario(i,j)
                       p_sovrapposizione = p_sovrapposizione + 1 ;              % Se sono uguali allora aumenta il nr di conflitti
                    end

                end
            end
    
        end
    end
    

    %------------------------------------------------VINCOLO 2------------------------------------------------%

    % Vincolo 2: equilibrio tra i giorni (controllo che non ci siano giorni troppo pesanti, in base allo score)

    % Inizializzazione della matrice per la somma degli score per giorno
    ScoresPerDay = zeros(6, 5, 6);

    % Sostituzione degli elementi dell'orario, ovvero gli insegnanti, con il loro score
    for class = 1:6
        for slot = 1:6
            for day = 1:5
                teacherID = individuo(slot, day, class);        %Stavolta l'orario è individuo, ovvero l'ingresso della funzione calcola_fitness

                % Trovare l'insegnante corrispondente dall'array teachersArray
                teachersArray = insegnanti();                   %teachersArray lo scrivo usando la funzione insegnanti (function 'insegnanti')
                teacher = teachersArray(teacherID);

                % Aggiungi lo score dell'insegnante al giorno specifico
                ScoresPerDay(slot, day, class) = ScoresPerDay(slot, day, class) + teacher.subject.score;
            end
        end
    end

    % Ho ottenuto una matrice 5x5x4 dove, al posto dell'ID degli insegnanti, c'è il loro score.

    % Conto in p_equilibrio tutte le volte in cui un giorno è "troppo difficile", ovvero conto quante volte la somma degli score di quel giorno 
    % (quindi di quella colonna) supera 3 (4 è il valore max). I possibili conflitti in totale sono 30 (5 gg * 6 classi), cioè al max posso avere p_equilibrio = 30 

    p_equilibrio = 0 ;

    for i = 1 : 6
        for j = 1 : 5
            somma_giorno = sum(ScoresPerDay(: , j , i));        % sommo (per riga) gli elementi di quella specifica colonna e di quella specifica classe

            if somma_giorno < 2.9 || somma_giorno > 3.8         % se lo score totale è superiore a 3.4 e inferiore a 2.5, conto un conflitto
                p_equilibrio = p_equilibrio + 1 ;
            end 

        end
    end


    %------------------------------------------------VINCOLO 3------------------------------------------------%
    
    % Vincolo 3: ore totali in un giorno per lo stesso insegnante
    p_oreMax = 0;

    for class = 1:6
        for day = 1:5
            orario_giornaliero = individuo(:, day, class);

            % Conta il numero di ore in cui lo stesso insegnante è presente in un giorno
            for insegnante = 1:max(orario_giornaliero(:))
                ore_insegnante = sum(orario_giornaliero == insegnante);

                % Se il numero di ore supera 2, incrementa il contatore dei conflitti
                if ore_insegnante > 2
                    p_oreMax = p_oreMax + 1;
                end
            end
        end
    end


    %------------------------------------------------VINCOLO 4------------------------------------------------%
    
    % Vincolo 4: il professore di Motoria (10) può andare a scuola solo mar, mer e giov. Mentre quello di religione (11) può andare solo lun, mar, mer. Perchè 
    % magari vengono da fuori oppure fanno altri lavori e quindi ha senso concentrare i loro giorni di lavoro in meno giorni.

    p_giorno = 0;

    % Giorni di lavoro assegnati a teacher10 e teacher11
    giorni_lavoro_teacher10 = teachersArray(10).giorni;
    giorni_lavoro_teacher11 = teachersArray(11).giorni;

    for c = 1:6
        for g = 1:5
            giorno = individuo(:, g, c);
        
            % Trova l'insegnante corrispondente dall'array teachersArray
            teachersArray = insegnanti();

            for ore=1:6
                teacher = teachersArray(giorno(ore));
                
                % Controllo se l'insegnante è teacher10 o teacher11
                if teacher.ID == 10

                    % Controllo se il giorno di lavoro è assegnato a teacher10
                    if ~ismember(g,giorni_lavoro_teacher10 )
                        % Incrementa la penalità per il giorno non assegnato
                        p_giorno = p_giorno + 1;
                    end
        
                elseif teacher.ID == 11
                    
                    % Controllo se il giorno di lavoro è assegnato a teacher10
                    if ~ismember(g,giorni_lavoro_teacher11)
                        % Incrementa la penalità per il giorno non assegnato
                        p_giorno = p_giorno + 1;
                    end

                end
            
            end  
        
        end
    end



    % Calcolo la fitness, che sarà la somma dei conflitti ottenuti per quegli individui. Il senso è dare un peso all'equilibrio che è un criterio, mentre gli altri sono
    % vincoli stretti. Quindi quando la fitness arriva a 3 significa che sicuro sono rispettati tutti e 3 i vincoli stretti, quando la fitness è compresa tra 3 e 3.1 
    % vuol dire che i 3 vincoli sono rispettati ma l'equilibrio non è rispettato per tutti i giorni. Quando fitness arriva a 3.1 significa che, oltre a esser rispettati
    % i 3 vincoli è anche rispettato l'equilibrio per tutti i giorni e quindi quella è la soluzione che, oltre ad esser ammissibile (rispetta i 3 vincoli stretti) è anche
    % quella ottima, perchè rispetta anche il criterio equilibrio.

    fitness = 1/(p_sovrapposizione + 1) + 1/(p_oreMax + 1) + 1/(p_giorno + 1) + 0.1/(p_equilibrio + 1);
    %fitness = 1/(p_sovrapposizione + p_equilibrio + p_oreMax + 1);
    %fitness = 1/(p_equilibrio +1);
    %fitness = 1/(p_sovrapposizione+1);
    %fitness = 1/(p_oreMax + 1);
end