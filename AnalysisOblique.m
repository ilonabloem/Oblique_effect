
clear all
close all

load('DataContrastSensitivity_S_001.mat');

r = 2;

    TrialEvents = TheData(r).p.TrialEvents;
    rightwrong = TheData(r).data.rightwrong;
    
    TrialEvents(:,5) = rightwrong';
    
    SortedEvents = sortrows(TrialEvents,1);
        
    Contrasts = reshape(SortedEvents, [80, 10, 5]); %trail * contrast * trialevents
    
    for c = 1:10
        
        temp = squeeze(Contrasts(:,c,:));
        n = 0;
        o = 0;
        
        for i = 1:80 % amount of trials
            
            if temp(i,2) == 0 
                
                n = n +1;
                cardinal(n,1) = temp(i,5);
                
            elseif temp(i,2) == 90
                
                n = n +1;
                cardinal(n,2) = temp(i,5);
                
            elseif temp(i,2) == 45
                
                o = o +1;
                oblique(o,1) = temp(i,5);                
                
            elseif   temp(i,2) == 135
                
                o = o +1;
                oblique(o,2) = temp(i,5);
             end
            
            
        end
        
        
        CardinalScore(c,:) = mean(cardinal);
        ObliqueScore(c,:) = mean(oblique); %mean(oblique(:,n));
        
        
    end

    

MeanCardinal = CardinalScore; %squeeze(mean(CardinalScore,1));
MeanOblique = ObliqueScore;%   squeeze(mean(ObliqueScore,1));

c = 10.^linspace(log10(0.025),log10(1),10);

figure,
semilogx(c,MeanCardinal(:,1),'or--'); hold all
semilogx(c,MeanCardinal(:,2),'^r--');
semilogx(c,MeanOblique(:,1),'ob--'); 
semilogx(c,MeanOblique(:,2),'^b--'); 
% set(gca, 'YLim', [0.3 1]);
xlabel('Contrast'); ylabel('Accuracy')
legend('0', '90', '45', '135');
title('seperate orientations');


figure,
semilogx(c,mean(MeanCardinal,2),'or--'); hold all
semilogx(c,mean(MeanOblique,2),'ob--'); 
% set(gca, 'YLim', [0.3 1]);
xlabel('Contrast'); ylabel('Accuracy')
legend('Cardinal', 'Oblique');
title('collapsed orientations');


