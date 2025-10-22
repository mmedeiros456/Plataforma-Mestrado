function Plot_S (figIdx,gate,struct_IV,lpot)

Lambda = struct_IV.Lambda;
a2T = struct_IV.a2T;
local_min_indices = struct_IV.local_min_indices;
local_max_indices = struct_IV.local_max_indices;
local_min_valores = struct_IV.local_min_valores;
local_max_valores = struct_IV.local_max_valores;
range_idx = struct_IV.range_idx;
dtLambda1 = struct_IV.dtLambda1;
dtLambda2 = struct_IV.dtLambda2;
Ng1v = struct_IV.Ng1v;
LambdaRes = struct_IV.LambdaRes;
FE = struct_IV.FE;
FSR = struct_IV.FSR;
Q = struct_IV.Q;
FWHM = struct_IV.FWHM;
F = struct_IV.F;
Tf = struct_IV.Tf;

%%
if gate
    figure(figIdx);
    hold on;
    grid on;
    plot(Lambda(1:end)', a2T(1:end), 'k');
    xlabel('Comprimento de Onda');
    ylabel('|a_2|^2');
    title('Espectro Real');

    ax = gca; 
     ax.FontSize = 14; 
     
     xtickformat('%.4f');
     ytickformat('%.3f');

     xlabel('Comprimento de Onda', 'FontSize', 16);
     ylabel('|a_2|^2', 'FontSize', 16);
     title('Espectro Real e Simulado', 'FontSize', 18); 

     
    Lambda_Res_R_crop = Lambda(local_min_indices(a2T(local_min_indices) < lpot ) + range_idx(1) - 1)';

    plot (Lambda_Res_R_crop(1:end), local_min_valores(1:end)', 'ko', 'linew',2,'markerfacecolor','b');
    plot (Lambda(local_max_indices(1:end)+range_idx(1)-1), local_max_valores(1:end)', 'ko', 'linew',2,'markerfacecolor','b');

    plot(Lambda(dtLambda1),a2T(dtLambda1),'Xb');
    plot(Lambda(dtLambda2),a2T(dtLambda2),'Xb');

else    
    figure (figIdx);
    hold on;
    grid on;
    plot(Lambda, a2T);
    xlabel('Comprimento de Onda');
    ylabel('|a_2|^2');
    title('Espectro Real e Simulado');
    
     ax = gca; 
     ax.FontSize = 14; 
     
     xtickformat('%.4f');
     ytickformat('%.3f');

     xlabel('Comprimento de Onda', 'FontSize', 16);
     ylabel('|a_2|^2', 'FontSize', 16);
     title('Espectro Real e Simulado', 'FontSize', 18); 


    plot (Lambda(local_min_indices+range_idx(1)-1), local_min_valores, 'ko', 'linew',2,'markerfacecolor','g');
    plot (Lambda(local_max_indices+range_idx(1)-1), local_max_valores, 'ko', 'linew',2,'markerfacecolor','g');

    plot(Lambda(dtLambda1),a2T(dtLambda1),'Xr')
    plot(Lambda(dtLambda2),a2T(dtLambda2),'Xr')
end

 figure;
 grid on;
 if gate
    plot (LambdaRes(2:end),Ng1v, 'ok', 'LineWidth', 2);
 else
     plot (Lambda(local_min_indices),Ng1v(local_min_indices), 'ok', 'LineWidth', 2);
 end
 xlabel('Comprimento de Onda');
 ylabel('Ng');
 title('Variação do Indice de Grupo(Ng)');


if gate 
    
     figure;
     grid on;
     plot (LambdaRes(1:end),FE(1:end), 'ok', 'LineWidth', 2);
     
     ax = gca; 
     ax.FontSize = 14; 
     
     xtickformat('%.4f');
     ytickformat('%.4f');

     xlabel('Comprimento de Onda', 'FontSize', 16);
     ylabel('FE', 'FontSize', 16);
     title('Variação do Fator de Extinção (FE)', 'FontSize', 18); 

    xticks(linspace(min(LambdaRes), max(LambdaRes), 11));
        
else
    figure;
     grid on;
     plot (LambdaRes(1:end),FE, 'ok', 'LineWidth', 2);
     xlabel('Comprimento de Onda');
     ylabel('FE');
     title('Variação do Fator de Extinção (FE)');
end
     
if gate
     figure;
     grid on;
     plot (LambdaRes(2:end),FSR(1:end), 'ok', 'LineWidth', 2);
     %plot (LambdaRes(3:end-2),FSR(2:end-2), 'ok', 'LineWidth', 2);
     xlabel('Comprimento de Onda');
     ylabel('FSR');
     title('Variação do Intervalo Espectral Livre do Disp. Real (um)');

else
     figure;
     grid on;
     plot (LambdaRes(2:end),FSR, 'ok', 'LineWidth', 2);
     xlabel('Comprimento de Onda');
     ylabel('FSR');
     title('Variação do Intervalo Espectral Livre do Disp. Real (um)');
end

 figure;
 grid on;
 plot (LambdaRes(1:end),Q, 'ok', 'LineWidth', 2);
 xlabel('Comprimento de Onda');
 ylabel('Q');
 title('Variação do Fator Q de Qualidade do Disp. Real');

 figure;
 grid on;
 plot (LambdaRes(1:end),FWHM, 'ok', 'LineWidth', 2);
 xlabel('Comprimento de Onda');
 ylabel('FWHM');
 title('Variação de Larg. a Meia Altura do Disp. Real(pm)');

 figure;
 grid on;
 plot (LambdaRes(2:end),F, 'ok', 'LineWidth', 2);
 xlabel('Comprimento de Onda');
 ylabel('Finesse');
 title('Variação de Finesse do Disp. Real');

 figure;
 grid on;
 plot (LambdaRes(1:end),Tf, 'ok', 'LineWidth', 2);
 xlabel('Comprimento de Onda');
 ylabel('Tf');
 title('Variação de Tempo de Vida do Fóton do Disp. Real');

end