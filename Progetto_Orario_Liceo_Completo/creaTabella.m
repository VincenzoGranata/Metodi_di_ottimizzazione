function orario_tabella = creaTabella(orario_ottimo)      

    teachersArray = insegnanti();
    orario_nomi = strings(6,5,6);
    
    % Visualizza l'orario con i nomi degli insegnanti per ogni classe
    for classe = 1:6
        for riga = 1:6
            for colonna = 1:5
                id_insegnante = orario_ottimo(riga, colonna, classe);
            
                % Trova il nome dell'insegnante utilizzando l'ID
                nome_insegnante = teachersArray(id_insegnante).name;
            
                % Sostituisci l'ID con il nome dell'insegnante nell'orario ottimo
                orario_nomi(riga, colonna, classe) = nome_insegnante;
            end
        end
    end

    % Creazione di celle per memorizzare le tabelle dell'orario per ogni classe
    tabelle_orari = cell(1, 6);

    % Definizione dei nomi dei giorni della settimana
    nomi_giorni = {'Lunedì', 'Martedì', 'Mercoledì', 'Giovedì', 'Venerdì'};

    % Definizione delle fasce orarie    
    fasce_orarie = {'08:00-09:00', '09:00-10:00', '10:00-11:00', '11:00-12:00', '12:00-13:00', '13:00-14:00'};

    % Riempimento delle tabelle per ogni classe
    for classe = 1:6

        % Inizializzazione della tabella per la classe corrente
        tabella_classe = cell(7, 6); % Utilizziamo una cella per includere le fasce orarie

        % Imposta i nomi dei giorni come intestazioni delle colonne della tabella
        tabella_classe(1, 1:5) = nomi_giorni;
    
        % Imposta le fasce orarie come prima colonna della tabella
        tabella_classe(2:end, 1) = fasce_orarie';
    
            % Riempimento della tabella con i nomi degli insegnanti
            for giorno = 1:5
                for ora = 1:6
                
                    % Estrai il nome dell'insegnante
                    id_insegnante = orario_ottimo(ora, giorno, classe);
            
                    % Trova il nome dell'insegnante utilizzando l'ID
                    nome_insegnante = teachersArray(id_insegnante).name;
        
                    % Assegna il nome dell'insegnante alla cella della tabella
                    tabella_classe{ora + 1, giorno + 1} = nome_insegnante;

                end
            end

        % Memorizza la tabella della classe corrente
        tabelle_orari{classe} = tabella_classe;
    end

    % Visualizza le tabelle per ogni classe con i nomi dei giorni della settimana e le fasce orarie
    for classe = 1:6
        disp(['Orario Classe ', num2str(classe), ':']);
    
        orario_classe = tabelle_orari{classe}; % Ottieni l'orario della classe
    
        % Creazione della tabella con nomi dei giorni e fasce orarie come intestazioni
        orario_tabella = array2table(orario_classe(2:end, 2:end), 'VariableNames', nomi_giorni, 'RowNames', fasce_orarie);
        disp(orario_tabella); % Mostra la tabella con i nomi dei giorni e le fasce orarie
    end
end