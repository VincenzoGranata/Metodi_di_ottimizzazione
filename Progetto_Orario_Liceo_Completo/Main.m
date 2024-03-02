clear all
close all
clc

% Richiamo la struttura degli insegnanti teachersArray con la funz 'insegnanti'. Così creo il vett contenente tutti gli insegn (le loro strutt).
teachersArray = insegnanti();

% Definisco la dimensione della popolazione iniziale e il nr di volte che deve esser generata
POP_SIZE = 100;
N_GENERAZIONI = 500;

% Definisco la cella contenente la popolazione, con la funz 'genera_pop'. Così facendo creo una popolazione di matrici 6x5x6
% con numeri casuali da 1 a 11 (nr totali dei prof), tenendo conto sia delle classi in cui possono stare, sia delle ore totali che devono fare. 
popolazione = genera_pop(teachersArray,POP_SIZE);

% Calcolo la fitness per ogni elemento della popolaz (ogni individuo), tenendo conto dei vincoli e del nr di conflitti di ogni individuo (vedi calcola_fitness) 
fitness = zeros(1,POP_SIZE);        
for i = 1:POP_SIZE
    fitness(i) = calcola_fitness(popolazione{i}); 
end
% Dunque fitness è un vettore di dimensione POP_SIZE dove ogni elemento è la fitness di quell'individuo

% Creo la figura:
figure;
hold on;
title('Andamento Fitness');
xlabel('Nr Generazioni');
ylabel('Miglior Valore Fitness');
yticks(0:0.1:3.5);
xticks(0:5:N_GENERAZIONI);

% Faccio partire l'algoritmo che genera una nuova popolazione e calcolo la fitness della nuova popolazione
for i = 1:N_GENERAZIONI
    [popolazione, fitness] = geneticAlgorithm(popolazione, fitness, POP_SIZE);

    % Calcola la miglior fitness della generazione corrente
    [miglior_fitness_generazione, indice] = max(fitness);
    disp(['Miglior fitness della generazione ', num2str(i), ': ', num2str(miglior_fitness_generazione)]);

    % Metto in un grafico l'andamento della fitness migliore per le varie generazioni
    axis([0 N_GENERAZIONI 0 3.5]);
    plot(i,miglior_fitness_generazione,'b.');
    drawnow;
    
    % Trova gli indici degli elementi con miglior_fitness_generazione
    indici_validi = find(fitness == miglior_fitness_generazione);

    % Prealloca la cella pop_temp
    pop_temp = cell(1, length(indici_validi));

    % Copia gli orari in base agli indici trovati
    for j = 1:length(indici_validi)
        pop_index = indici_validi(j);
        pop_temp{j} = popolazione{pop_index};
    end

    % Prealloca le celle per orario_nomi
    orario_ottimo = zeros(6, 5, 6);

    if i == N_GENERAZIONI 
        if miglior_fitness_generazione >= 3 && miglior_fitness_generazione < 3.1
            orario_ottimo = pop_temp{randi([1,length(pop_temp)])};
            disp('Orario valido ma non ottimo:');
            disp(orario_ottimo);

            %Scrivo lo stesso orario ma come tabella, dove ogni elemento è il nome della materia: 
            orario_tabella = creaTabella(orario_ottimo);

        elseif miglior_fitness_generazione < 3 
            disp('Non ho trovato nessun orario valido');

        end
    end

    % Se trovo l'ottimo mi fermo    
    if miglior_fitness_generazione == 3.1
        disp('Orario ottimo globale: ');
        orario_ottimo = pop_temp{randi([1,length(pop_temp)])};
        disp(orario_ottimo);

        %Scrivo lo stesso orario ma come tabella, dove ogni elemento è il nome della materia: 
        orario_tabella = creaTabella(orario_ottimo);

        break
    end

end
