function struct_out = ...
    MMT_fase_plus_t (c, L1, cStruct, parameters)    

N = 1; % Reservado para uso posterior para N cavidades.

%% Dados do AG
A1 = parameters(1); % Atenuação
Nga = parameters(end-3); % parametro para Ng
offset = parameters(end-2); % Ajuste do Ponto Max.
coefRetaNg = parameters(end-1); % coef reta para Ng
phi = parameters(end); % coef reta para Ng
%% Quantidade de Amostras pelo Comprimento de Onda
Lambda_R = cStruct.Lambda;
[amostras,~] = size(Lambda_R); 
Lambda = Lambda_R(1) : (Lambda_R(end) - Lambda_R(1)) / (amostras -1) : Lambda_R(end); 
t1 = cStruct.t';

%% pre-alocacao de memoria
Ng1v = zeros(1,amostras);
w = zeros(1,amostras);
a2 = zeros(1,amostras);
a2Conj = zeros(1,amostras);
a2T = zeros(1,amostras);
T1 = zeros(1,amostras);

%% MMT
 for n = 1 : amostras
     
    Ng1 = Nga + Lambda(n) * coefRetaNg;        
    Ng1v(n) = Ng1;
    
    T1(n) = (L1 * Ng1 /c);      
    w(n)= 2 * pi * c / Lambda(n);
    
 end
 
    a2 = (t1 - (A1 .* exp(1i .* w .* T1 + 1i .* phi).* N)) ./ (1 - (t1 .* A1 .* exp(1i .* w .* T1 .* N + 1i .* phi)));    
    a2Conj = conj(a2); 
    a2T = (a2 .* a2Conj) + offset;

for i = 1 : length(a2T)
    if a2T(i) < 0 || a2T(i) > 1
        erroCusto = 1e100;
        return;
    end
end
 %end
 
  % Criando a struct de saída
   struct_out = struct( ...
       'Lambda', Lambda, ...
       'a2T', a2T, ...
       'Ng1v', Ng1v);
 
end