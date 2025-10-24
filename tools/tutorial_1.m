% configuracoes do dispositivo 90um canal 2
%% Constantes

c = 299792458; % Constante da Velocidade da luz 
gate = 1;

%% Configuracoes gerais

initp =  [ ...
           ...
           ]; 

tol_t = 0.1;
tol_ng = 0.1;
R1 = ; 
namefile = '';
data_load = '';

L1 = 2 * pi * R1; % Anel Externo
Ng1v_R = 0;

cutoff_freq = 30;
filt_on = 1; % 1 = on, 0 = off

lpot = 0.8; % limiar de pot. normalizada

first_Ex = 0; % 1 = on, 0 = off

% erroCurvePot erroCustoCorr erroCustoFE erroCustoFWHM erroCustoFSR;
pesos = [10 1 100 10 10];

%% configuracoes do AG
if first_Ex == 0    
      
    [lim_min,lim_max,lim_ng,lim_off] = range_GA (initp,tol_t,tol_ng);

    flagDebug = 1;
    %Tempo e execuçoes do AG
    AG_TIME = 900;
    VezesAG = 5;

    lb = [   0.1 ...
             lim_min(1) lim_min(2) lim_min(3) lim_min(4) lim_min(5) lim_min(6) ...
             lim_ng(1) lim_off lim_ng(3) -2*pi];

    ub = [   0.99 ...
             lim_max(1) lim_max(2) lim_max(3) lim_max(4) lim_max(5) lim_max(6) ...
             lim_ng(2) 0.00 lim_ng(4) 2*pi];

    crossover_func = 'crossoverscattered';

    ga_opt = optimoptions('ga','MaxTime',AG_TIME,'InitialPopulation',initp,'display','none','CrossoverFcn',...
                                crossover_func,'PlotFcn',{@gaplotbestf,@gaplotstopping,@myPlotFunc});
end