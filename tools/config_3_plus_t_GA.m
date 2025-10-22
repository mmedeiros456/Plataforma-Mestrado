% configuracoes do dispositivo 5um

%% Constantes

c = 299792458; % Constante da Velocidade da luz 
gate = 1;

%% Configuracoes gerais
      
initp =  [0.5  ...
          0.456  0.0146  0.04236 ...  
          4.190627769978261  0.95 0.419 0];      

tol_t = 0.9;
tol_ng = 0.2;
R1 = 5;
L1 = 2 * pi * R1; 
Ng1v_R = 0;

cutoff_freq = 30;
filt_on = 0; % 1 = on, 0 = off

namefile = 'Disp2_cut_Cn1.mat';
data_load = 'onecavity';

lpot = 0.7; % limiar de pot. normalizada

first_Ex = 0; % 1 = on, 0 = off

% erroCurvePot erroCustoCorr erroCustoFE erroCustoFWHM erroCustoFSR;
pesos = [10 1000 10 10 10]; 

%% configuracoes do AG
if first_Ex == 0
    
    flagDebug = 1;
    AG_TIME = 360;
    VezesAG = 1;
    
    [lim_min,lim_max,lim_ng] = range_GA (initp,tol_t,tol_ng);

    %        A1, t1, Nga, offset, coefRetaNg, phi
%     lb = [   0.1 ...
%              lim_min(1) lim_min(2) lim_min(3) ...
%               lim_ng(1) -0.1 lim_ng(3) -2*pi];
% 
%     ub = [   0.9999 ...
%              lim_max(1) lim_max(2) lim_max(3) ...
%              lim_ng(2) 0.00 lim_ng(4) 2*pi];

    lb = [   0.7 ...
             -1 -1 -1 ...
              lim_ng(1) -0.1 lim_ng(3) -2*pi];

    ub = [   0.9999 ...
             1 1 1 ...
             lim_ng(2) 0.00 lim_ng(4) 2*pi];
         
    crossover_func = 'crossoverscattered'; 

    ga_opt = optimoptions('ga','MaxTime',AG_TIME,'InitialPopulation',initp,'display','none','CrossoverFcn',...
                                crossover_func,'PlotFcn',{@gaplotbestf,@gaplotstopping,@myPlotFunc});

end