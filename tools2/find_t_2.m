function cStruct = find_t_2 (cStruct,parameters)

Lambda = cStruct.Lambda;

p = parameters(2:end-4);

switch length(p)
    case 3
        t = 1-(p(1)*Lambda.^2 + p(2)*Lambda + p(3));
    case 4
        t = 1-(p(1)*Lambda.^3 + p(2)*Lambda.^2 + p(3)*Lambda + p(4));
    case 5
        t = 1-(p(1)*Lambda.^4 + p(2)*Lambda.^3 + p(3)*Lambda.^2 + p(4)*Lambda + p(5));
    case 6
        t = 1-(p(1)*Lambda.^5 + p(2)*Lambda.^4 + p(3)*Lambda.^3 + p(4)*Lambda.^2 + p(5)*Lambda + p(6));
end


%Lambda = Lambda * 1e-3; % coef Variação do t

%p = [ 0.5 -10 -0.9 2.5 0.1 0.1]; % uso em micro 

%p = [ 0.5 -30 200 15 0.1 300];

% 0.5 ~ 0.9 / 0 ~ 70 / -500 ~ 500 / -50 ~ 50 /

% 0.5 ~ 0.9 / -15 ~  / -2 ~ 0.6 / 4.5 ~ 5 / 

%t = p(1) + p(2)*Lambda + p(3)*Lambda.^2 + p(4)*Lambda.^3 + p(5)*Lambda.^4 + p(6)*Lambda.^5;

%disp(t(1)); disp(t(end));

%t = max(0, min(1, t));

for i = 1 : length(t)
    if t(i) < 0 || t(i) > 1 || t(i) == 0 % testar 
        erroCusto = 1e100;
        return;
    end
end

cStruct.t = t;

end