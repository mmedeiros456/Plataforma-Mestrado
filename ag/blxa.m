function [F, indiv] = blxa(A,B,a)

nF = length(A);

F = zeros(nF,2);
indiv = zeros(nF,1);
for i=1:nF
    Itmp = max(A(i),B(i))-min(A(i),B(i));
    F(i,1) = min(A(i),B(i))-Itmp*a;
    F(i,2) = max(A(i),B(i))+Itmp*a;
    indiv(i) = F(i,1) + (F(i,2)-F(i,1)).*rand;
end

 
 
 