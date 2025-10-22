function erroCusto = funcao_custo_ag_fase_t_GA(parameters,flagD,cStruct,flagDebug,c,L1,lpot,pesos)
%% Global data
if (flagDebug)
    global erro_custo idx_gen
end

%% parte principal
if flagD 
    fig1 = figure;
else
    fig1= 0;
end

gate = 0;

try
    cStruct = find_t_2 (cStruct,parameters);
    if cStruct.t == 0
        erroCusto = 1e100;
        return;
    end
catch
   erroCusto = 1e100;
   return;
end

%% Cálculo da matriz de transferencia (MMT)
try
struct_S = MMT_fase_plus_t (c,L1,cStruct,parameters);
catch
   erroCusto = 1e100;
   return;
end


%% Montagem da struct do Simulado

struct_S = montar_struct (struct_S);


%% Testando
try
struct_S = Ajuste_superior_S(struct_S,lpot);
catch
   erroCusto = 1e100;
   return;
end

%% Identificação dos Pontos Mínimos e Máximos no Espectro (MME)
try
struct_S = MME (struct_S,cStruct);
catch
   erroCusto = 1e100;
   return;
end


%% Cálculo dos principais aspectos da ressonancias (PARS)
try
    struct_S = PARS (struct_S,gate,c,L1);
catch
   erroCusto = 1e100;
   return;
end


%%
try
    [fitresult, gof] = createFit_min_poly5(struct_S);
    struct_S.curve = fitresult; 
catch
   erroCusto = 1e100;
   return;
end



%% Cálculos de diferença entre os aspectos do espectro (CEE)

try
    [erroCusto,struct_E] = CEE_fase (struct_S,cStruct,pesos);
catch
   erroCusto = 1e100;
   return;
end

if (flagDebug)  
    [idx_gen, erro_custo] = plot_gen (idx_gen, erro_custo, struct_E);
end

% Plot da Caracterização 
if (flagD)
    % Dispositivo real
    gate = 1; 
    Plot_S (fig1,gate,cStruct,lpot);   
    
    % Dispositivo simulado
    gate = 0;
    Plot_S (fig1,gate,struct_S,lpot);
    
    % Tabela de Valores
    Tab_Val (struct_S,cStruct);
end    

%R2 = corr(struct_S.a2T',cStruct.a2T').^2;  
%MAE = mean(abs(cStruct.a2T' - struct_S.a2T'));
% 
%disp (R2);
%disp (MAE);

end