function [lim_min,lim_max,lim_ng,lim_off] = range_GA (initp,tol_t,tol_ng)

lim_min = [];
lim_max = [];
lim_ng = [];

for i = 1 : length(initp)-5    
    lim_min(i) = initp(end-3-i) * (1-tol_t);
    lim_max(i) = initp(end-3-i) * (1+tol_t);    
end
      
lim_min = flip(lim_min);
lim_max = flip(lim_max);

for i = 1 : length(lim_min)    
    if lim_min(i) > lim_max(i)        
        exc = lim_min(i);
        lim_min(i) = lim_max(i);
        lim_max(i) = exc;        
    end    
end

lim_ng(1) = initp(end-3) * (1-tol_ng);
lim_ng(2) = initp(end-3) * (1+tol_ng);
lim_ng(3) = -(initp(end-3) * tol_ng);
lim_ng(4) = initp(end-3) * tol_ng;
lim_off = (initp(end-2) -1) * 2;

end