function struct_S = Ajuste_superior_S(struct_S,lpot)


Lambda_R = struct_S.Lambda;  
a2T_R = struct_S.a2T;

ordemPol = 4;

range_local_R = [Lambda_R(1,1) Lambda_R(1,end)];
range_idx_R(1,1) = 1;
range_idx_R(2,1) = length(Lambda_R);


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
 
 ttt = Lambda_R(local_max_indices_R); 
 
 stop = 0;
 
 while stop ~= 1;
     
     lastwarn('');

     p = polyfit(ttt, local_max_valores_R, ordemPol); 
     curva_polinomial = polyval(p, Lambda_R);

     [warnMsg, warnId] = lastwarn;

     if ~isempty(warnMsg)
         ordemPol = ordemPol -1;
     else
         stop = 1;
     end
     
 end 
 
 valor_max_topo = max(local_max_valores_R); 
 correcao = (valor_max_topo - curva_polinomial);

 spectrum_corrigido = a2T_R + correcao; 
 
 a2T_R = spectrum_corrigido;
 struct_S.a2T = a2T_R; 
end