% configuracoes do dispositivo 20 um Canal 1

%% Constantes

c = 299792458; % Constante da Velocidade da luz 
gate = 1;

%% Configuracoes gerais

 initp =  [0.5  ... 
           -0.008315  -0.008396  0.02292   0.02914  -0.004581  0.01648 ...
           4.305457934915569  -0.087348594408673  0.90   0.127722583606968];

tol_t = 0.1;
tol_ng = 0.3;
R1 = 20; % raio do rr
L1 = 2 * pi * R1; % Anel Externo
Ng1v_R = 0;

cutoff_freq = 10;

filt_on = 0; % 1 = on, 0 = off

namefile = 'CN1_Disp1.mat';
data_load = 'CN1';

lpot = 0.8; % limiar de pot. normalizada

first_Ex = 0; % 1 = on, 0 = off

% erroCurvePot erroCustoCorr erroCustoFE erroCustoFWHM erroCustoFSR;
pesos = [10 10 100 10 10]; 

%% configuracoes do AG
if first_Ex == 0 

    flagDebug = 1;
    AG_TIME = 600; 
    VezesAG = 5; 

    [lim_min,lim_max,lim_ng,lim_off] = range_GA (initp,tol_t,tol_ng);

    %           A1, t1, Nga, offset, coefRetaNg, phi
    % lb = [   0.5 ...
    %              lim_min(1) lim_min(2) lim_min(3) lim_min(4) lim_min(5) lim_min(6) ...
    %              lim_ng(1) lim_off lim_ng(3) -2*pi]; %-2*pi
    % 
    % ub = [   0.99999 ...
    %              lim_max(1) lim_max(2) lim_max(3) lim_max(4) lim_max(5) lim_max(6) ...
    %              lim_ng(2) 0.00 lim_ng(4) 2*pi];

    lb = [   0.1 ...
                 -2 -2 -2 -2 -2 -2 ...
                 lim_ng(1) lim_off lim_ng(3) -2*pi];

    ub = [   0.9999 ...
                 2 2 2 2 2 2 ...
                 lim_ng(2) 0.00 lim_ng(4) 2*pi];      

    crossover_func = 'crossoverscattered'; 

        ga_opt = optimoptions('ga','MaxTime',AG_TIME,'InitialPopulation',initp,'display','none','CrossoverFcn',...
                                crossover_func,'PlotFcn',{@gaplotbestf,@gaplotstopping,@myPlotFunc});
end