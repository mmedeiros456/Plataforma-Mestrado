% configuracoes do dispositivo 5um

%% Constantes

c = 299792458; % Constante da Velocidade da luz 
gate = 1;

%% Configuracoes gerais

initp =  [0.7  ...
          -0.117  0.2216  0.4364 ...  
          4.124050426750079  0.9 0.4124 0];
      
tol_t = 0.5;
tol_ng = 0.2;
R1 = 5; % raio do rr
L1 = 2 * pi * R1; % Anel Externo
Ng1v_R = 0;

cutoff_freq = 15;

filt_on = 1; % 1 = on, 0 = off

namefile = 'Disp2_Cn2.mat';

data_load = 'Disp2_Cn2';

lpot = 0.8; % limiar de pot. normalizada

first_Ex = 0; % 1 = on, 0 = off

% erroCurvePot erroCustoCorr erroCustoFE erroCustoFWHM erroCustoFSR;
pesos = [10 1000 10 10 10]; 

%% configuracoes do AG
if first_Ex == 0  

    flagDebug = 1;
    AG_TIME = 600;
    VezesAG = 1;

    [lim_min,lim_max,lim_ng] = range_GA (initp,tol_t,tol_ng);

    %           A1, t1, Nga, offset, coefRetaNg
    lb = [   0.1 ...
             -2 -2 -2 ...
             3.78 -0.2 0 -2*pi];

    ub = [   0.9999 ...
             2 2  2 ...
             4.58 0.00 0.4 2*pi];

    crossover_func = 'crossoverscattered';

        ga_opt = optimoptions('ga','MaxTime',AG_TIME,'InitialPopulation',initp,'display','none','CrossoverFcn',...
                                crossover_func,'PlotFcn',{@gaplotbestf,@gaplotstopping,@myPlotFunc});
end