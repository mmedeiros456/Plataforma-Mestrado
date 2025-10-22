function child = myCrossoverFcn(parents, options, nvars, FitnessFcn, ...
                                unused,thisPopulation)

% The arguments to the function are
% parents — Row vector of parents chosen by the selection function
% options — options
% nvars — Number of variables
% FitnessFcn — Fitness function
% unused — Placeholder not used
% thisPopulation — Matrix representing the current population. The number of rows of the matrix is Population size and the number of columns is Number of variables.                            
   
%% Calcular o Fitness
child = zeros(length(parents)/2,size(thisPopulation,2));

% mantem o individuo melhor
[~,pos] = min(unused);
child(1,:) = thisPopulation(pos,:);

% for i=1:size(thisPopulation,1)
%     fprintf('%f\n',FitnessFcn(thisPopulation(i,:)));
% end
parfor i = 2:length(parents)/2
    a=1;b=length(parents);
    r1 = round(a + (b-a).*rand);
    r2 = round(a + (b-a).*rand);
    
    A = thisPopulation(parents(r1),:);
    B = thisPopulation(parents(r2),:);
    [~, indiv] = blxa(A,B,0.4);
    
    child(i,:) = indiv';
end      


% nF = length(A);
% 
% F = zeros(nF,2);
% indiv = zeros(nF,1);
% for i=1:nF
%     Itmp = max(A(i),B(i))-min(A(i),B(i));
%     F(i,1) = min(A(i),B(i))-Itmp*a;
%     F(i,2) = max(A(i),B(i))+Itmp*a;
%     indiv(i) = F(i,1) + (F(i,2)-F(i,1)).*rand;
% end