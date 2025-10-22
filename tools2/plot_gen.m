function [idx_gen, erro_custo] = plot_gen (idx_gen, erro_custo, struct_E)

%[idx_gen, erro_custo] = plot_gen (idx_gen, erro_custo, erroCustoLambdaRes, erroCustoFE, erroCustoPot, erroCustoFWHM_total, erroCustoFSR, erroCorr)

erroCustoLambdaRes = struct_E.erroCustoLambdaRes;
erroCustoFE = struct_E.erroCustoFE;
erroCustoPot = struct_E.erroCustoPot;
erroCustoFSR = struct_E.erroCustoFSR;
erroCorr = struct_E.erroCustoCorr;
erroCustoFWHM_total = struct_E.erroCustoFWHM_total;


%%
    if (isempty(idx_gen))
        idx_gen = 1;
    else
        idx_gen = idx_gen + 1;
    end

    if (isempty(erro_custo))
       erro_custo = [erroCustoLambdaRes, erroCustoFE, erroCustoPot, erroCustoFWHM_total, erroCustoFSR, erroCorr];
    else
       erro_custo = [erro_custo;
                     erroCustoLambdaRes, erroCustoFE, erroCustoPot, erroCustoFWHM_total, erroCustoFSR, erroCorr];
    end

    if (mod(idx_gen,100) == 0)
        time_gen = 1:idx_gen;
        figure(1000);hold on
        subplot(3,2,1);plot(time_gen,erro_custo(:,1));title('erroCustoLambdaRes')
        subplot(3,2,2);plot(time_gen,erro_custo(:,2));title('erroCustoFE')
        subplot(3,2,3);plot(time_gen,erro_custo(:,3));title('erroCustoPot')
        subplot(3,2,4);plot(time_gen,erro_custo(:,4));title('erroCustoFWHM_total')
        subplot(3,2,5);plot(time_gen,erro_custo(:,5));title('erroCustoFSR')
        subplot(3,2,6);plot(time_gen,erro_custo(:,6));title('erroCorr')
    end

end