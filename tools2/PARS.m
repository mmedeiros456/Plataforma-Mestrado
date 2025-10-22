function struct_II = PARS (struct_II,gate,c,L1)

% Fator de Ressonância
struct_II.FE = struct_II.local_max_valores - struct_II.local_min_valores;

%Local dos Vales no Comprimento de Onda das Ressonâncias
if gate
    struct_II.LambdaRes = struct_II.Lambda(struct_II.local_min_indices)';
    struct_II.a2T = struct_II.a2T';
else
    struct_II.LambdaRes = struct_II.Lambda(struct_II.local_min_indices); 
end

% FSR
struct_II.FSR = diff(struct_II.LambdaRes); 

% Largura a meia potência
ValorMeiaPot = struct_II.local_max_valores - struct_II.FE / 2;

try
    struct_II.dtLambda1 = zeros(1,length(ValorMeiaPot));
    struct_II.dtLambda2 = zeros(1,length(ValorMeiaPot));
    for i = 1 : length(ValorMeiaPot)
        [~ , aux1_localMeiaPot] = find(struct_II.a2T(struct_II.local_min_indices(1,i) : end ) >= ValorMeiaPot(1,i));  
        struct_II.dtLambda1(i) = aux1_localMeiaPot(1) + struct_II.local_min_indices(i)-1;  

        [~ , aux2_localMeiaPot] = find(struct_II.a2T(struct_II.local_max_indices(i) : struct_II.local_min_indices(i))...
            <= ValorMeiaPot(i)); 
        struct_II.dtLambda2(i) = aux2_localMeiaPot(1) + struct_II.local_max_indices(i)-2; 
    end
catch
    erroCusto = 1e100; 
end

try        
    idx_FWHM = struct_II.dtLambda1 - struct_II.dtLambda2; 
    struct_II.FWHM = abs(struct_II.Lambda(struct_II.dtLambda2) - struct_II.Lambda(struct_II.dtLambda2 + idx_FWHM));
    
    if size(struct_II.FWHM, 1) > 1
        struct_II.FWHM = struct_II.FWHM';
    end
    
    struct_II.FWHM_pot = struct_II.a2T(struct_II.dtLambda2);
catch
    erroCusto = 1e100; 
    return;  
end   
    
try
    %Finesse
    struct_II.F = struct_II.FSR(1:end) ./ struct_II.FWHM(2:end);

    %Fator de Qualidade
    struct_II.Q = struct_II.LambdaRes ./ struct_II.FWHM;

    % Tempo de Vida do Foton
    struct_II.Tf = (struct_II.Q .* struct_II.LambdaRes / c) * 10^6;
catch
    erroCusto = 1e100; 
    return;  
end


% Índice de Grupo
if gate
    struct_II.Ng1v = (struct_II.LambdaRes(2:end).^2) ./ (struct_II.FSR .* L1);
end

end