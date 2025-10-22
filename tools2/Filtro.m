function [RR_Filt] = Filtro (onecavity, cutoff_freq)

%Filtro Passa-baixa

tic

sampling_freq = size(onecavity,1) /(onecavity(end,1) - onecavity(1,1));
orderLP = 3;

for i=0 : length(onecavity) -1
    x_rebat = onecavity(:,2) .* -1 ; 
end

WnLP = cutoff_freq/(sampling_freq/2); 
[bLP aLP] = butter(orderLP,WnLP); 

y_t = filtfilt(bLP,aLP,x_rebat'); 
y = y_t'; 

for i=0 : length(onecavity) -1
    RR_Filt(1:length(onecavity),2) = y(:,1) .* -1 ; 
    RR_Filt(1:length(onecavity),1) = onecavity(:,1);
end

toc

end