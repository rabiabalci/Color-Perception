clear all
load('ExperimentData2.mat')

subjectID = input('Katýlýmcýnýn ID''sini giriniz:     ');


ListenChar(2);

Screen('Preference', 'SkipSyncTests', 1);
[windowPtr,windowSize]=Screen('OpenWindow',0);


xCenter=windowSize(3)/2;
yCenter=windowSize(4)/2;


stimulusOrder = Shuffle(1:27);
emotionAnswers = [];
fixationAnswers = [];
totalNumberOfFlashes = [];

for trial=1:length(stimulusOrder)
    
    whichImage = sprintf('%d.jpg', stimulusOrder(trial));
    
    myImage = imread(whichImage);
    imageSize = size(myImage);
    
    imageHeigth = imageSize(1);
    imageWidth = imageSize(2);
    
    xCenter=windowSize(3)/2;
    yCenter=windowSize(4)/2;
    
    imageRectangle = [0 0 imageWidth imageHeigth] * 1.5;
    
    imageLocation = CenterRectOnPointd(imageRectangle, xCenter, yCenter+50);
    
    myTexture = Screen('MakeTexture', windowPtr, myImage);
    
    Screen('DrawTexture',windowPtr,myTexture,[],imageLocation);
    Screen('Flip',windowPtr);
    
    WaitSecs(20); %burasý için 30saniye düþünmüþtüm ancak kýsaltmam gerekti
    
    text = ' Hüzün = 1 \n \n \n Mutluluk = 2 \n \n \n Öfke = 3 \n \n \n Korku = 4 \n \n \n Þaþkýnlýk = 5 \n \n \n Tiksinti = 6 \n \n\n Tarafsýz = 7';
    text2 = 'Bu resim sizde hangi duyguyu uyandýrýyor?';
    
    while 1
        Screen('TextSize', windowPtr, 30);
        Screen('DrawTexture',windowPtr,myTexture,[],imageLocation);
        DrawFormattedText(windowPtr, text, 100, yCenter / 2);
        DrawFormattedText(windowPtr, text2, xCenter / 1.5 + 50 , yCenter / 3 -50);
        
        Screen('Flip',windowPtr);
        
        [~,~,keyCode]=KbCheck;
        
        if find(keyCode==1) == KbName('q')
            sca;
            ListenChar(0);
            return;
            
        elseif find(keyCode==1) == KbName('1')
            emotionAnswers = [emotionAnswers 1];
            break;
        elseif find(keyCode==1) == KbName('2')
            emotionAnswers = [emotionAnswers 2];
            break;
        elseif find(keyCode==1) == KbName('3')
            emotionAnswers = [emotionAnswers 3];
            break;
        elseif find(keyCode==1) == KbName('4')
            emotionAnswers = [emotionAnswers 4];
            break;
        elseif find(keyCode==1) == KbName('5')
            emotionAnswers = [emotionAnswers 5];
            break;
        elseif find(keyCode==1) == KbName('6')
            emotionAnswers = [emotionAnswers 6];
            break;
        elseif find(keyCode==1) == KbName('7')
            emotionAnswers = [emotionAnswers 7];
            break;
        end
        
        
    end
    
    Screen('Flip',windowPtr);
    
    if trial == length(stimulusOrder)  % Son resimden sonra fixation taski istemiyoruz
        break;
    end
    
    numFlashes = randi([1,5]);
    totalNumberOfFlashes = [totalNumberOfFlashes numFlashes];
    
    WaitSecs(randi(5));
    
    for flashes=1:numFlashes
        Screen('FillOval',windowPtr, [55 55 55], [xCenter-180 yCenter-180 xCenter+180 yCenter+180]);
        Screen('Flip',windowPtr);
        WaitSecs(0.2);
        Screen('Flip',windowPtr);
        WaitSecs(15 / numFlashes);
    end
    
    flashText = ' Toplam kaç yuvarlak gösterildi?';
    Screen('TextSize', windowPtr, 30);
    DrawFormattedText(windowPtr, flashText, xCenter / 2 + 100, yCenter / 2);
    Screen('Flip',windowPtr);
    
    while 1
        [~,~,keyCode]=KbCheck;
        
        if find(keyCode==1) == KbName('1')
            fixationAnswers = [fixationAnswers 1];
            break;
        elseif find(keyCode==1) == KbName('2')
            fixationAnswers = [fixationAnswers 2];
            break;
        elseif find(keyCode==1) == KbName('3')
            fixationAnswers = [fixationAnswers 3];
            break;
        elseif find(keyCode==1) == KbName('4')
            fixationAnswers = [fixationAnswers 4];
            break;
        elseif find(keyCode==1) == KbName('5')
            fixationAnswers = [fixationAnswers 5];
            break;
        end
        
    end
    
    Screen('Flip',windowPtr);
    
    
    WaitSecs(3);
end

quitText = 'Deneye katýldýðýnýz için teþekkürler...';

while 1
    DrawFormattedText(windowPtr, quitText, xCenter / 2, yCenter / 2);
    Screen('TextSize', windowPtr, 30);
    
    Screen('Flip',windowPtr);
    
    [~,~,keyCode]=KbCheck;
    
    if find(keyCode==1) == KbName('q')
        break;
    end
end

stimulusOrder
emotionAnswers
fixationAnswers
totalNumberOfFlashes

subject{subjectID}.stimulusOrder = stimulusOrder;
subject{subjectID}.emotionAnswers = emotionAnswers;
subject{subjectID}.numberOfCircles = totalNumberOfFlashes;
subject{subjectID}.taskAnswers = fixationAnswers;

save('ExperimentData2.mat','subject')
  
sca;
ListenChar(0);