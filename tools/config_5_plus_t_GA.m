% configuracoes do dispositivo 90um canal 2

%% Constantes

c = 299792458; % Constante da Velocidade da luz 
gate = 1;

%% Configuracoes gerais   

 initp =  [0.5  ...
           0.003245 -0.0002943 -0.01537 0.03289 0.09722 0.05665 ...
           1.844699122296112  0.95  -0.107833686976847   0.127722583606968]; 

tol_t = 0.9;
tol_ng = 0.5;
R1 = 90; % raio do rr
L1 = 2 * pi * R1; % Anel Externo
Ng1v_R = 0;

cutoff_freq = 30;

filt_on = 1; % 1 = on, 0 = off

namefile = 'CN1_Disp3.mat'; 
data_load = 'sensor_grande_1__1530_1600_';

lpot = 0.7; % limiar de pot. normalizada

first_Ex = 0; % 1 = on, 0 = off

% erroCurvePot erroCustoCorr erroCustoFE erroCustoFWHM erroCustoFSR;
pesos = [10 1 100 10 10]; 

%% configuracoes do AG
if first_Ex == 0    
      
    [lim_min,lim_max,lim_ng,lim_off] = range_GA (initp,tol_t,tol_ng);

    flagDebug = 1;
    AG_TIME = 180;
    VezesAG = 10;

    %           A1, t1, Nga, offset, coefRetaNg, phi

%     lb = [   0.1 ...
%              lim_min(1) lim_min(2) lim_min(3) lim_min(4) lim_min(5) lim_min(6) ...
%              lim_ng(1) lim_off lim_ng(3) -2*pi];
% 
%     ub = [   0.9999 ...
%              lim_max(1) lim_max(2) lim_max(3) lim_max(4) lim_max(5) lim_max(6) ...
%              lim_ng(2) 0.00 lim_ng(4) 2*pi];
         
 lb = [   0.1 ...
             -2 -2 -2 -2 -2 -2 ...
             lim_ng(1) lim_off lim_ng(3) -2*pi];

    ub = [   0.9999 ...
             2 2 2 2 2 2 ...
             lim_ng(2) 0.00 lim_ng(4) 2*pi];         

    crossover_func = 'crossoverscattered'; % Matlab default: crossoverscattered

    ga_opt = optimoptions('ga','MaxTime',AG_TIME,'InitialPopulation',initp,'display','none','CrossoverFcn',...
                                crossover_func,'PlotFcn',{@gaplotbestf,@gaplotstopping,@myPlotFunc});
end