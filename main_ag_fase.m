% 'ga' requires Global Optimization Toolbox.
%
% Neste script eh apresento um exemplo de codigo utilizando agoritmo
% genetico para ajustar ........... (TODO)
%
% Laboratorio de Processamento de Sinais Biologicos (LSBio)
% Site: www.lsbio.ufscar.br
% Prof. Samuel Lourenco Nogueira e Prof. Luís Alberto Mijam Barêa 
% Aluno: Marcelo de Medeiro

clear all;close all;format long;
restoredefaultpath;
clc;

path(path,'tools')
path(path,'tools2')
path(path,'ag')
path(path,'data')
warning ('off','all')

%% Carregar dados
config_1_plus_t_GA; % 20 cn1
%config_2_plus_t_GA; % 20 cn2
%config_3_plus_t_GA; % 5 cn1 high weight erroCustoCorr
%config_4_plus_t_GA; % 90 cn1
%config_5_plus_t_GA; % 90 cn2
%config_6_plus_t_GA; % 5 cn2 high weight erroCustoCorr

load(namefile);
eval(sprintf('onecavity = %s;',data_load));
%% Pre caracterizacoes

if filt_on == 1
    [onecavity_f] = Filtro (onecavity, cutoff_freq);
else
    onecavity_f = onecavity;
end

onecavity_f = Ajuste_superior(onecavity_f,lpot); 

struct_I = Disp_Real (onecavity_f,lpot); 

struct_II = montar_struct (struct_I);

struct_R = PARS (struct_II,gate,c,L1);

if first_Ex     
    [fitresult, gof] = createFit_min_poly5(struct_R);
    mean(struct_R.Ng1v)
    disp(fitresult);

    plot_fig_carac (struct_R, fitresult);
    return;
else
    [fitresult, gof] = createFit_min_poly5(struct_R);
    struct_R.curve = fitresult;    
    struct_R.p_curve = coeffvalues(fitresult);
end

%% AG 

A = [];
b = [];
Aeq = [];
beq = [];

x = zeros(VezesAG,length(lb));
fval = inf(VezesAG,1);

for i = 1 : VezesAG
    
    flagD = 0;
    [x(i,:), fval(i)] = ga(@(parameters)funcao_custo_ag_fase_t_GA(parameters,flagD,struct_R,flagDebug,c,L1,lpot,pesos), ...
        length(lb), A, b, Aeq, beq, lb, ub, [], [], ga_opt);

end

[~,pos] = min(fval);

%load '20um_cn1_36_percert_max_erro.mat';
%load '20um_cn2_13_percent_max_erro.mat';
%load '90um_cn1_25_percent_max_erro.mat';
%load '90um_cn2_7_percent_max_erro.mat';

flagD = 1;
funcao_custo_ag_fase_t_GA(x(pos,:),flagD,struct_R,flagDebug,c,L1,lpot,pesos);

best_indiv = x(pos,:);

