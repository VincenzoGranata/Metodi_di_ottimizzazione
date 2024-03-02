% Function che genera la popolazione iniziale: una cella con dentro tanti orari che sono matrici 5x5x6. Tali orari sono riempiti controllando sia che il prof
% può stare effettivamente in quella classe (in base alla struttura insegnanti), sia le ore totali che deve fare in quella classe (in base alla struttura materia), 
% gestendo un nr di selezione che si incrementa ogni volta che viene chiamato quell'insegnante, fino ad arrivare alle sue ore settimanali. Quando ha raggiunto 
% le sue ore settimanali in una classe il nr di selezione si riazzera, perchè quando passo alla classe successiva lui deve poter comunque entrare. Per esempio il 
% prof 1 deve fare 6 ore in classe 1, 6 ore in classe 2, 6 ore in classe 3. Gestendo questa imposizione riesco ad ottenere un orario dove son rispettate le classi 
% di appartenenza di ogni professore e son rispettate anche le ore settimanali (tutte info contenute nelle strutture materie e insegnanti). 

function pop_iniziale = genera_pop(teachersArray, POP_SIZE)      % in ingresso chiaramente ci serve l'array degli insegnanti e la dimensione della popolazione
    pop_iniziale = cell(1, POP_SIZE);                            % creo una cella di vettori di dimensione POP_SIZE che poi man mano andrò a riempire
    
    for n = 1:POP_SIZE                                           % ciclo che scorre ogni volta che si genera un orario completo, così avro (POP_SIZE) orari generati

        orario = zeros(6, 5, 6);                                 % matrice tridimensionale inizialmente nullo che poi verrà riempito con l'orario

        for k = 1:6             % nr di classi
            for j = 1:5         % nr di giorni
                for i = 1:6     % nr di ore
                    is_nullo = true;
                    while is_nullo
                        ind = randi([1 , length(teachersArray)]);   % Prendo un insegnante a caso, un nr casuale da 1 a nr di insegnanti totali. Mi salvo il prof
                        prof = teachersArray(ind);                  % preso casualmente in una variabile prof (che conterrà tutta la sua struttura)
                        for z = 1 : length(prof.class)              % Ciclo le classi in cui può stare quel prof (es se è prof 1, questo z va da 1 a 3)

                            % Se k (classe selezionata) appart ad una delle classi in cui può stare il prof random e lui ha ancora ore da coprire, entra nell'if
                            if k == prof.class(z) && (prof.subject.n_selezioni < prof.subject.lezioni_settimanali)  
                                % disp("Ho selezionato la materia: ");
                                % disp(teachersArray(ind).subject.nome);

                                % Se si verifica l'if riempi quello slot orario con l'ID di tale prof e aumenta il nr di selez (cioè ha fatto un'ora in più) a
                                orario(i, j, k) = prof.ID; 

                                teachersArray(ind).subject.n_selezioni = teachersArray(ind).subject.n_selezioni +1; 
                                % disp(teachersArray(ind).subject.n_selezioni);  
                                is_nullo = false ;     % Questo fa uscire dal while per consentire lo scorrimento degli slot orari, poi dei giorni, poi delle classi
                            end 
                            
                        end
                    end
                end
            end
            
            for i=1:length(teachersArray)
                teachersArray(i).subject.n_selezioni = 0;   % azzero il nr di selezioni ogni volta che scorre k (cioè ogni volta che passo alla classe successiva) 
            end
        
        end

        pop_iniziale{1,n} = orario;    % l'orario appena generato lo inserisco nella cella come n-esimo elemento (intanto cioè sta scorrendo anche l'n)

    end
end