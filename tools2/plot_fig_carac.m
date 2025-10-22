function plot_fig_carac (struct_R, fitresult)
    
    hold off;
    figure;
    plot(struct_R.Lambda, struct_R.a2T, 'k');

    ax = gca; 
    ax.FontSize = 14; 
     
    xtickformat('%.4f');
    ytickformat('%.3f');

    xlabel('Comprimento de Onda (um)', 'FontSize', 16);
    ylabel('Potência Normalizada', 'FontSize', 16);
    title('Espectro Experimental Pós-processamento', 'FontSize', 18); 

    % Plot fit with data.
    figure( 'Name', 'untitled fit 1' );
    h = plot( fitresult, struct_R.LambdaRes, struct_R.local_min_valores );
    legend( h, 'y vs. x', 'untitled fit 1', 'Location', 'NorthEast' );
    % Label axes
    xlabel x
    ylabel y
    grid on

end