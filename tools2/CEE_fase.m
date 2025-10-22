function [erroCusto,struct_E] = CEE_fase (struct_S,cStruct,pesos)
%%

CorteInicio = struct_S.CorteInicio;
a2T = struct_S.a2T;
a2T_R = cStruct.a2T;
FE = struct_S.FE;
FE_R = cStruct.FE;
FWHM = struct_S.FWHM;
FWHM_R = cStruct.FWHM;
LambdaRes = struct_S.LambdaRes;
LambdaRes_R = cStruct.LambdaRes;
FSR = struct_S.FSR;
FSR_R = cStruct.FSR;
FWHM_pot = struct_S.FWHM_pot;
FWHM_pot_R = cStruct.FWHM_pot;
curve_R = cStruct.curve;
curve_S = struct_S.curve;

%% Cálculos de diferença entre os aspectos do espectro

Delta_FE = [];
Delta_FWHM = [];
Delta_LambdaRes = []; 
Delta_FSR = [];

Ajuste_FE_R = FE_R(1+CorteInicio : end - 2);
Ajuste_FWHM_R = FWHM_R(1+CorteInicio : end - 2);
Ajuste_FWHM_R_pot = FWHM_pot_R(1+CorteInicio : end - 2);
Ajuste_LambdaRes_R = LambdaRes_R(1+CorteInicio : end - 2)';
Ajuste_FSR_R = FSR_R(1+CorteInicio : end - 2);

% Na condição de terem a mesma quantidade de ressonancias
if length(FE) == length(Ajuste_FE_R) 
    
    Delta_FE = abs(1 - FE./Ajuste_FE_R);
    Delta_FWHM = abs(1 - FWHM./Ajuste_FWHM_R);   
    Delta_LambdaRes = abs(1-LambdaRes./Ajuste_LambdaRes_R');
    Delta_FSR = abs(1-FSR./Ajuste_FSR_R);    
    Delta_FWHM_pot = abs(1 - FWHM_pot./Ajuste_FWHM_R_pot);   
end

% Na condição do Simulado ter mais ressonancias do que o disp. real
if length(FE) > length(Ajuste_FE_R)
       
    for i = 1 : length(Ajuste_FE_R)
        Delta_FE(i) = abs(1-FE(i)/Ajuste_FE_R(i));
        Delta_FWHM(i) = abs(1-FWHM(i)/Ajuste_FWHM_R(i)); 
        Delta_FWHM_pot(i) = abs(1 - FWHM_pot(i)/Ajuste_FWHM_R_pot(i));   
        Delta_LambdaRes(i) = abs(1-LambdaRes(i)/Ajuste_LambdaRes_R(i)');       
    end
    
    for i = 1 : length(Ajuste_FSR_R)        
        Delta_FSR(i) = abs(1-FSR(i)/Ajuste_FSR_R(i));        
    end
    
    for i = 1 + length(Ajuste_FE_R) : length(FE)    
        Delta_FE(i) = 1;
        Delta_FWHM(i) = 1;
        Delta_FWHM_pot(i) = 1;
        Delta_LambdaRes(i) = 1; 
    end
    
    for i = 1 + length(Ajuste_FSR_R) : length(FSR) 
        Delta_FSR(i) = 1;  
    end    
end

% Na condição do Simulado ter menos ressonancias do que o disp. real
if length(FE) < length(Ajuste_FE_R)
    
    for i = 1 : length(FE)    
        Delta_FE(i) = abs(1-FE(i)/Ajuste_FE_R(i));
        Delta_FWHM(i) = abs(1-FWHM(i)/Ajuste_FWHM_R(i)); 
        Delta_FWHM_pot(i) = abs(1 - FWHM_pot(i)/Ajuste_FWHM_R_pot(i));           
        Delta_LambdaRes(i) = abs(1-LambdaRes(i)/Ajuste_LambdaRes_R(i)');        
    end
    
    for i = 1 : length(FSR)        
        Delta_FSR(i) = abs(1-FSR(i)/Ajuste_FSR_R(i));        
    end
    
    for i = 1 + length(FE) : length(Ajuste_FE_R)
        Delta_FE(i) = 1;
        Delta_FWHM(i) = 1;
        Delta_FWHM_pot(i) = 1;
        Delta_LambdaRes(i) = 1;
    end
    
    for i = 1 + length(FSR) : length(Ajuste_FSR_R)
        Delta_FSR(i) = 1;
    end
     
end

%erro FSR
erroCustoFSR = sum(sqrt(Delta_FSR.^2)/length(Delta_FSR));

%erro do Fator de Extinção
erroCustoFE = sum(sqrt(Delta_FE.^2)/length(Delta_FE));

%erro de LambdaRes
erroCustoLambdaRes = sum(sqrt(Delta_LambdaRes.^2)/length(Delta_LambdaRes));

%erro de pot (Resposta Espectral dos Sinais)
DeltaPot = abs(a2T_R - a2T);
erroCustoPot = sum(sqrt(DeltaPot.^2)/length(DeltaPot));

%erro de correlação de pot
erroCustoCorr = abs(1 - corr(a2T_R(:),a2T(:)));   

%erro de FWHM
erroCustoFWHM = sum(sqrt(Delta_FWHM.^2)/length(Delta_FWHM)); 

%erro da curva poly da parte de baixo do espectro
erroCurve = abs (1 - corr(curve_R(cStruct.Lambda), curve_S(cStruct.Lambda)));
DeltaCurve = abs(curve_R(cStruct.Lambda) - curve_S(cStruct.Lambda));
erroCurvePot = sum(sqrt(DeltaCurve.^2)/length(DeltaCurve));

DeltaPotMin = abs(1- cStruct.a2T(cStruct.local_min_indices) ./ struct_S.a2T(struct_S.local_min_indices));
erroPotMin = sum(sqrt(DeltaPotMin.^2)/length(DeltaPotMin));            
     
erroCusto = erroCurvePot * pesos(1) + erroCurve * pesos(1) + erroCustoCorr * pesos(2) + erroCustoFE * pesos(3) + erroPotMin + erroCustoFWHM * pesos(4) + erroCustoFSR * pesos(5);

% arruamar os pesos para fora
struct_E = struct( ...
    'erroCustoLambdaRes', erroCustoLambdaRes, ...
    'erroCustoFE', erroCustoFE, ...
    'erroCustoPot', erroCustoPot, ...
    'erroCustoFSR', erroCustoFSR, ...
    'erroCustoCorr', erroCustoCorr, ...
    'erroCustoFWHM_total', erroCustoFWHM);

end