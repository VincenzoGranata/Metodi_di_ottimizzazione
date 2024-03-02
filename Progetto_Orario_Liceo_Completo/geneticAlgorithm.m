function [popolazione, fitness] = geneticAlgorithm(popolazione, fitness, POP_SIZE)

% Creo un vettore temporaneo per mantenere i nuovi individui generati
nuovi_figli = cell(1, round(POP_SIZE/2));
nuove_fitness = zeros(1, round(POP_SIZE/2));

    for p = 1:(round(POP_SIZE/2))
        [genitore1, genitore2] = roulette_wheel_selection();
        
        figlio_dopo_crossover = crossover(genitore1, genitore2);
        probabilita_mutazione = 0.1;
        figlio_dopo_mutazione = mutazione(figlio_dopo_crossover, probabilita_mutazione);
        fit = calcola_fitness(figlio_dopo_mutazione);

        % Aggiungi i nuovi figli al vettore temporaneo
        nuovi_figli{p} = figlio_dopo_mutazione;
        nuove_fitness(p) = fit;
    end

    % Aggiungi i nuovi figli alla popolazione
    popolazione = [popolazione, nuovi_figli];
    fitness = [fitness, nuove_fitness];

    % Trova gli individui con la fitness più alta
    [~, indici_piu_alti] = maxk(fitness, POP_SIZE);

    % Scarta gli individui con la fitness più bassa
    popolazione = popolazione(indici_piu_alti);
    fitness = fitness(indici_piu_alti);


    function [genitore1, genitore2] = roulette_wheel_selection()
        
        %valore totale di tutte le fitness
        max = sum(fitness);

        %associo una probabilità ad ogni individuo della popolazione in modo proporzionale al suo valore di fitness
        probs_selezione = fitness / max;

        while true
            ind1=randsample(1:length(popolazione), 1, true, probs_selezione);
            ind2=randsample(1:length(popolazione), 1, true, probs_selezione);

            if(ind1 ~= ind2)
                genitore1 = popolazione{ind1};
                genitore2 = popolazione{ind2};
                break
            end
        end

    end

    function  figlio = crossover(genitore1,genitore2)
        figlio = zeros(6,5,6);
        n_classi = size(genitore1,3);

        for class=1:n_classi

            if  rand() < 0.5
                figlio(:,:,class) = genitore1(:,:,class);
            else
                figlio(:,:,class) = genitore2(:,:,class);
            end

        end          
    end

    function figlio_mutato = mutazione(figlio, probabilita_mutazione)
        figlio_mutato = figlio;
        
        
        for class = 1:size(figlio, 3)
            if rand() < probabilita_mutazione
                % Applica la mutazione solo con una certa probabilità
    
                % Seleziona casualmente due posizioni nella matrice
                posizione1 = [randi([1,6]) , randi([1,5])];
                posizione2 = [randi([1,6]) , randi([1,5])];
    
                % Scambia gli insegnanti alle due posizioni
                temp = figlio_mutato(posizione1(1), posizione1(2), class);
                figlio_mutato(posizione1(1), posizione1(2), class) = figlio_mutato(posizione2(1), posizione2(2), class);
                figlio_mutato(posizione2(1), posizione2(2), class) = temp;
            end
        end
    end


end