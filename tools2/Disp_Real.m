function struct_I = Disp_Real (RR_Filt,lpot)

RR_Filt(:, 2) = (RR_Filt(:, 2) - min(RR_Filt(:, 2)))./(max(RR_Filt(:, 2)) - min(RR_Filt(:, 2))); 
if RR_Filt(1,1) > 50
    RR_Filt(:,1) = RR_Filt(:,1)./ 1000;
end


for j = 1 : 2
    
    if j == 2

            control = round(idx_LambdaRes_R(end)-(idx_LambdaRes_R(end)-idx_LambdaRes_R(end-1))/2);
            RR_Filt = RR_Filt(idx_LambdaRes_R(1):control,:); 
    end
    
    Lambda_R = RR_Filt(:,1); 
    a2T_R = RR_Filt(:, 2); 

    range_local_R = [RR_Filt(1,1) RR_Filt(end,1)];
    range_idx_R = dsearchn (Lambda_R, range_local_R');

    % Identificando os Pontos Minimos e Maximos

    local_min_valores_R = []; 
    local_min_indices_R = []; 
    local_max_valores_R = []; 
    local_max_indices_R = [];
    idx_LambdaRes_R = [];
    val_LambdaRes_R = [];

    % Identificação dos Pontos Minimos

    for i = range_idx_R(1):range_idx_R(2)
        if i > range_idx_R(1) && i < range_idx_R(2)
            if a2T_R(i) < a2T_R(i - 1) && a2T_R(i) < a2T_R(i + 1)
                local_min_valores_R = [local_min_valores_R, a2T_R(i)]; 
                local_min_indices_R = [local_min_indices_R, i];
            end
        end
    end

    %Ajuste dos Pontos Minimos

    cont = 0;
    
    for i = 1 : length(local_min_indices_R)
        if local_min_valores_R(i) < lpot 
            cont = cont +1;
            idx_LambdaRes_R(cont) = local_min_indices_R(i);
            val_LambdaRes_R(cont) = local_min_valores_R(i);
        end
    end
    
end

%Indetificaçao dos Pontos Maximos

impares = mod(idx_LambdaRes_R,2) == 1;
teste_idx = [];

for i = 1 : length(impares)
    if impares(i) == 1
       teste_idx(i) = idx_LambdaRes_R(i) +1;
    else
       teste_idx(i) = idx_LambdaRes_R(i);
    end
end

for i = 1 : length(idx_LambdaRes_R)
    if i == 1
        local_max_indices_R(i) = abs(idx_LambdaRes_R(i) - (abs(teste_idx(i+1) - teste_idx(i))/2));
        local_max_indices_R(i+1) = (abs(teste_idx(i+1) - teste_idx(i))/2) + idx_LambdaRes_R(i);
    end
    if i > 1 && i < (length(idx_LambdaRes_R))
        local_max_indices_R(i+1) = (abs(teste_idx(i+1) - teste_idx(i))/2) + idx_LambdaRes_R(i);
    end
    local_max_valores_R(i) = a2T_R(local_max_indices_R(1,i));
end

 local_min_valores_R = val_LambdaRes_R;
 local_min_indices_R = idx_LambdaRes_R;
  
 %struct de saída
   struct_I = struct( ...
       'Lambda', Lambda_R, ...
       'a2T', a2T_R, ...
       'local_min_indices', local_min_indices_R, ...
       'local_max_indices', local_max_indices_R, ...
       'local_min_valores', local_min_valores_R, ...
       'local_max_valores', local_max_valores_R, ...
       'range_idx', range_idx_R ...
   );

end