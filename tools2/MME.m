function struct_S = MME (struct_S, cStruct);
%%
Lambda = struct_S.Lambda;
a2T = struct_S.a2T;
Lambda_R = cStruct.Lambda; 
 
%% Minimos e Máximos

if length(Lambda)== length(Lambda_R)
    range_local = [Lambda_R(1) Lambda_R(end)]; 
    range_idx = dsearchn (Lambda', range_local');
else    
    range_local = [Lambda(1) Lambda(end)]; 
    range_idx = dsearchn (Lambda', range_local');    
end

local_min_valores = []; 
local_min_indices = []; 
local_max_valores = []; 
local_max_indices = []; 

% Identificar os máximos locais
for i = range_idx(1) + 1:range_idx(2) - 1
    if a2T(i) > a2T(i - 1) && a2T(i) > a2T(i + 1)  
        local_max_valores = [local_max_valores, a2T(i)];
        local_max_indices = [local_max_indices, i];
    end
end

% Identificar os mínimos locais
for i = range_idx(1) + 1:range_idx(2) - 1
    if a2T(i) < a2T(i - 1) && a2T(i) < a2T(i + 1)
        local_min_valores = [local_min_valores, a2T(i)];
        local_min_indices = [local_min_indices, i];
    end
end

% Remover 1 ressonacia final
CorteInicio = 0; % Usado para os cálculos de Delta

% local_min_valores(end) = [];
% local_min_indices(end) = [];    
% local_max_valores(end) = [];
% local_max_indices(end) = [];   

% Ajuste dos tamanho de Max e Min
while length(local_min_indices) > length(local_max_indices)
    local_min_valores(1) = [];
    local_min_indices(1) = [];
end

while length(local_max_indices) > length(local_min_indices)
    local_max_valores(1) = [];
    local_max_indices(1) = [];
    CorteInicio = CorteInicio +1;
end

%Remove 1 ressonancia inicial
% local_min_valores(1) = [];
% local_min_indices(1) = [];
% local_max_valores(1) = [];
% local_max_indices(1) = [];
% CorteInicio = CorteInicio +1;

% Normalização dos Locais Max e Min
cortou_min = 0;
min_idx_aux = [];
min_val_aux = [];
max_idx_aux = [];
max_val_aux = [];

% nomalizar o minimo

for i = 1:length(local_min_indices)-1
    if (i < length(local_min_indices))
        if (local_max_indices(i) > local_min_indices(i))
            min_idx_aux = local_min_indices(i+1:end);
            min_val_aux = local_min_valores(i+1:end);
            cortou_min = 1;
            break;
        end
    end
end

% nomalizar o maximo

if (cortou_min)
    local_min_indices = min_idx_aux;
    local_min_valores = min_val_aux;
end

diff_tamanho = length(local_max_indices)-length(local_min_indices);
cortou_max = 0;
for i = length(local_max_indices):-1:1
    if (local_max_indices(i) > local_min_indices(i-diff_tamanho))
        max_idx_aux = local_max_indices(1:i-1);
        max_val_aux = local_max_valores(1:i-1);
        cortou_max = 1;
        break;
    end
end

if (cortou_max)
    local_max_indices = max_idx_aux;
    local_max_valores = max_val_aux;
end

 struct_S.local_max_indices = local_max_indices;
 struct_S.local_max_valores = local_max_valores;
 struct_S.local_min_indices = local_min_indices;
 struct_S.local_min_valores = local_min_valores;
 struct_S.range_idx = range_idx;
 struct_S.CorteInicio = CorteInicio;

end