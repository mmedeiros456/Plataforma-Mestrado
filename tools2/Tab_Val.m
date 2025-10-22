function Tab_Val(struct_S,cStruct)
%%

CorteInicio = struct_S.CorteInicio;
local_min_indices = struct_S.local_min_indices;
Ng1v = struct_S.Ng1v;
LambdaRes = struct_S.LambdaRes;
FE = struct_S.FE;
FSR = struct_S.FSR;
Q = struct_S.Q;
FWHM = struct_S.FWHM;
F = struct_S.F;
Tf = struct_S.Tf;

Ng1v_R = cStruct.Ng1v;
LambdaRes_R = cStruct.LambdaRes;
FE_R = cStruct.FE;
FSR_R = cStruct.FSR;
Q_R = cStruct.Q;
FWHM_R = cStruct.FWHM;
F_R = cStruct.F;
Tf_R = cStruct.Tf;

%%
% Dados em txt

    %cd('C:\Users\Note 02\Desktop\projeto\Plataforma');
    arquivo = fopen('Dados da Cavidade.txt', 'w');

    fprintf(arquivo, 'SINAL SIMULADO\n');

    fprintf(arquivo, 'Valores dos comprimentos de onda das ressonâncias(?res): \n');
    for i = 1 : length(LambdaRes)
        fprintf(arquivo, '%d - %f\n', i, LambdaRes(i));
    end

    fprintf(arquivo, 'Valores dos espaçamentos espectrais livres(FSR): \n');
    for i = 1 : (length(LambdaRes))-1
        fprintf(arquivo, '%d - %f\n', i, FSR(i));
    end

    fprintf(arquivo, 'Valores dos fatores de extinção das ressonâncias(FE): \n');
    for i = 1 :  length(FE)
        fprintf(arquivo, '%d - %f\n', i, FE(i));
    end

    fprintf(arquivo, 'Valores das larguras à meia altura das ressonâncias(Delta_Lambda_FWHM): \n');
    for i = 1 : length(FWHM)
        fprintf(arquivo, '%d - %g um\n', i, FWHM(i)); %pico
    end
    
    fprintf(arquivo, 'Valores de Finesse(F): \n');
    for i = 1 : length(F)
        fprintf(arquivo, '%d - %f\n', i, F(i));
    end
    
    fprintf(arquivo, 'Fator de Qualidade(Q): \n');
    for i = 1 : length(Q)
        fprintf(arquivo, '%d - LambdaRes=%f Q=%0.0f\n', i, LambdaRes(i), Q(i));
    end
    
    fprintf(arquivo, 'Tempo de Vida do Foton(Tf): \n');
    for i = 1 : length(Tf)
        fprintf(arquivo, '%d - %f\n', i, Tf(i));
    end
    
    NG = Ng1v(local_min_indices);
    fprintf(arquivo, 'Indice de Grupo(Ng): \n');
    for i = 1 : length(NG)
        fprintf(arquivo, '%d - %f\n', i, NG(i));
    end  
    
    fprintf(arquivo, '\n\n>>>>>>>  SINAL REAL\n');

    fprintf(arquivo, 'Valores dos comprimentos de onda das ressonâncias(?res): \n');
    for i = 1 : length(LambdaRes_R)
        fprintf(arquivo, '%d - %f\n', i, LambdaRes_R(i));
    end

    fprintf(arquivo, 'Valores dos espaçamentos espectrais livres(FSR): \n');
    for i = 1 : length(FSR_R)
        fprintf(arquivo, '%d - %f\n', i, FSR_R(i)); 
    end

    fprintf(arquivo, 'Valores dos fatores de extinção das ressonâncias (FE): \n');
    for i = 1 : length(FE_R)
        fprintf(arquivo, '%d - %f\n', i, FE_R(i));
    end
    
    fprintf(arquivo, 'Valores das larguras à meia altura das ressonâncias(Delta_Lambda_FWHM): \n');
    for i = 1 : length(FWHM_R)
        fprintf(arquivo, '%d - %g um \n', i, FWHM_R(i)); %pico
    end
    
    fprintf(arquivo, 'Valores de Finesse(F): \n');
    for i = 1 : length(F_R)
        fprintf(arquivo, '%d - %f\n', i, F_R(i));
    end
    
    fprintf(arquivo, 'Fator de Qualidade(Q): \n');
    for i = 1 : length(Q_R)
        fprintf(arquivo, '%d - LambdaRes=%f um Q=%0.0f\n', i, LambdaRes_R(i), Q_R(i));
    end
    
    fprintf(arquivo, 'Tempo de Vida do Foton(Tf): \n');
    for i = 1 : length(Tf_R)
        fprintf(arquivo, '%d - %f\n', i, Tf_R(i));
    end
    
    fprintf(arquivo, 'Valores de Índice de Grupo(Ng): \n');
    for i = 1 : length(Ng1v_R)
        fprintf(arquivo, '%f\n', Ng1v_R(i));
    end

    fprintf(arquivo, '\n\nANALISES DE DIFERENÇA DOS SINAIS\n');
    
    if length(LambdaRes) == length(LambdaRes_R') -CorteInicio %-2
    
        fprintf(arquivo, 'Diferença das ressonâncias(?res): \n');
        for i = 1 : length(LambdaRes)
            fprintf(arquivo, '%d - %.4f%%\n', i, (abs(LambdaRes(i) - LambdaRes_R(i+CorteInicio))/LambdaRes_R(i+CorteInicio))*100);
        end

        fprintf(arquivo, 'Diferença dos FSR: \n');
        for i = 1 : length(FSR)
            fprintf(arquivo, '%d - %.4f%%\n', i, (abs(FSR(i) - FSR_R(i+CorteInicio))/FSR_R(i+CorteInicio))*100);
        end

        fprintf(arquivo, 'Diferença dos FE: \n');
        for i = 1 : length(FE)
            fprintf(arquivo, '%d - %.4f%%\n', i, (abs(FE(i) - FE_R(i+CorteInicio))/FE_R(i+CorteInicio))*100);
        end

        fprintf(arquivo, 'Diferença dos FWHM: \n');
        for i = 1 : length(FWHM)
            fprintf(arquivo, '%d - %.4f%%\n', i, (abs(FWHM(i) - FWHM_R(i+CorteInicio))/FWHM_R(i+CorteInicio))*100);
        end

        fprintf(arquivo, 'Diferença dos Finesse: \n');
        for i = 1 : length(F)
            fprintf(arquivo, '%d - %.4f%%\n', i, (abs(F(i) - F_R(i+CorteInicio))/F_R(i+CorteInicio))*100);
        end

        fprintf(arquivo, 'Diferença dos Fatores de Qualidade Q: \n');
        for i = 1 : length(Q)
            fprintf(arquivo, '%d - %.4f%%\n', i, (abs(Q(i) - Q_R(i+CorteInicio))/Q_R(i+CorteInicio))*100);
        end

        fprintf(arquivo, 'Diferença dos Tempos de Fóton: \n');
        for i = 1 : length(Tf)
            fprintf(arquivo, '%d - %.4f%%\n', i, (abs(Tf(i) - Tf_R(i+CorteInicio))/Tf_R(i+CorteInicio))*100);
        end
    
    else        
        fprintf(arquivo, '\n\nO ajuste dos dados não revela a quantidade esperada de ressonâncias.\n\n');        
    end
    
    fclose(arquivo); 

end