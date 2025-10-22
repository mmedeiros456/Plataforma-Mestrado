function struct_R = find_t (struct_R,first_Ex)

Lambda = struct_R.Lambda;
local_min_valores = struct_R.local_min_valores;
local_min_indices = struct_R.local_min_indices;

 LambdaRes = Lambda(local_min_indices)';
 
 p = polyfit(LambdaRes, local_min_valores,3); % ordem do poly
 curva_poly = polyval(p, Lambda);
 
 t = zeros(1,length(curva_poly));
 
 for j = 1 : length(curva_poly)
     if curva_poly(j) == 0
         curva_poly(j) = curva_poly(j)+0.00000001;
     end
     
    t(j) = curva_poly(j);
 end
 
 struct_R.t = t;
 
 if first_Ex 
     hold on;
     plot(LambdaRes, local_min_valores, 'ro', 'MarkerFaceColor', 'r'); % Destacar os picos
     plot(Lambda, curva_poly, 'g--', 'LineWidth', 1.5); % Curva polinomial ajustada  
 end

end