tic
%STDFT for BFSK

ebn=1:1:14;% range of Eb/N0
MCM=50;% #of packets
nodata=2^10;% length of data packet
Rb=2^10;% data rate
FsVector=8*Rb;%[8*Rb,16*Rb,32*Rb];%Vector of sampling frequency values
berfinal=zeros(length(FsVector),length(ebn));% initializing "berfinal" which 
%is BER result from all packets 
avg=0


for freqindex=1:length(FsVector)
    Fs=FsVector(freqindex);%specifying sampling frequency
    N=Fs/Rb;% #of samples per symbol
    winLen=N;%length of window
    winLensync=N;% length of window during synchronization
    nodelay=N/2;% #of different delay values tested in synchronization phase
    ber=zeros(MCM,length(ebn)); % initializing BER array
    Tb=1/Rb; % symbol period
    Ts=1/Fs;% sampling time
    Tend=nodata*Tb; %end of simulation time; it is useful for frequency offset simulation
    preleng=16;% length of preamble
    win=ones(winLen,1);% ST-DFT window
    winsync=ones(winLensync,1);% ST-DFT window during synchornization
    Isync=8;% interpolation factor during Synchronization
    I=8;%Interpolation factor during detection
    fdev=Rb;% FSK frequency separation
    foffset=Rb+Rb/8;% frequency offset value
    fftpnt=winLensync*Isync;% FFT points
    index=zeros(MCM,length(ebn));
    maxi=zeros(MCM,length(ebn));
% delaysel=zeros(MCM,length(ebn));
% binsel1=zeros(MCM,length(ebn));
% binsel2=zeros(MCM,length(ebn));
% maxval=zeros(nodelay,MCM);
% falsesync=zeros(length(ebn),1);
    for q=1:MCM
%****************************Random Data generation************************    
        
        preamble1=ones(1,preleng/2);
        preamble2=zeros(1,preleng/2);
        preamble=[preamble1;preamble2];
        preamble=preamble(:);
        data=[preamble;1;randi([0,1],nodata-preleng-1,1)];% Transmitted
        %data incl. preamble
%**************************************************************************

%************************ Generating Transmitted Signal********************
        datasample=repelem(data,N);% repeating data samples; rectangular pulse
        %of transmited data
        Txdata=2*datasample-1; % bipolar conversion; 0/1 to -1/+1
        freq=(fdev/2)*Txdata; % Instantaneous frequency of signal 
        t=Ts:Ts:Tend;% time
        t=t';
        freqtime=freq*Ts;% frequency-time product
        phi=zeros(length(t),1);% initializing phase vector
        for i=1:length(t)%generating phase vector for signal
            phi(i)=2*pi*sum(freqtime(1:i));
        end
        signal=exp(1i*phi); %generating signal
%**************************************************************************

        datadetect=zeros(nodata,1);% initializing detected symbols vector

%*********************Frequency offset vector generation*******************
        freqoffset=zeros(length(foffset),length(t));
        for m=1:length(foffset)
        freqoffset(m,:)=exp(1i*2*pi*t*foffset(m));
        end
%**************************************************************************

% Channel Modeling and Receiver
        for j=1:length(ebn)% doing it for different Eb/N0 values to acheive a BER vs Eb/N0 curve
    
            SNR=ebn(j)-10*log10(Tb/Ts);%calculating SNR based on AWGN assumption 
            channelout=awgn(signal,SNR,'measured'); % adding AWGN noise
            Rxsample=channelout.*(freqoffset(m,:)');% applying frequency offset so that 
            %the samples at the receiver are obtained
           

%|||||||||||||||||||||||||||||||Synchronization||||||||||||||||||||||||||||

%*************************** Initializing Variables ***********************
            TFAfinalodd=zeros(winLensync*Isync,nodelay);
            TFAfinaleven=zeros(winLensync*Isync,nodelay);
            TFAtail=zeros(winLensync*Isync,nodelay,preleng-2);
            TFAmir=zeros(winLensync*Isync,nodelay,preleng-2);
            TFAmirval=zeros(winLensync*Isync,nodelay,preleng-2);
            maxindex=zeros(nodata/2,1);
            maxodd=zeros(nodelay,1);
            maxeven=zeros(nodelay,1);
            indmaxeven=zeros(nodelay,1);
            indmaxodd=zeros(nodelay,1);
            R=zeros(nodelay,1);
            Sample=zeros(winLensync,nodelay);
            winRxsync=zeros(winLensync,nodelay);
%**************************************************************************
            for k=1:preleng-2
                for i=1:nodelay

                Sample(:,i)=Rxsample(N*(k-1)+i:N*(k-1)+i+N-1);

                winRxsync(:,i)=Sample(:,i).*winsync;
                winRxtailpadsync=[winRxsync;zeros(winLensync*(Isync-1),nodelay)];%zero padding samples of each symbol
                TFAtail(:,i,k)=fft(winRxtailpadsync(:,i));%calculating FFT
                TFAmir(:,i,k)=[TFAtail(fftpnt/2+1:end,i,k);TFAtail(1:fftpnt/2,i,k)];% rearranging FFT points from -f to +f
                TFAmirval(:,i,k)=abs(TFAmir(:,i,k));%absolute value of the FFT results
                end
            end

            for i=1:nodelay 
    
                for sum_ind=1:preleng/2-1 % adding up odd and even symbols FFT in preamble
                    TFAfinalodd(:,i)=TFAfinalodd(:,i)+TFAmirval(:,i,2*sum_ind-1);
                    TFAfinaleven(:,i)=TFAfinaleven(:,i)+TFAmirval(:,i,2*sum_ind);
                end
                [maxodd(i),indmaxodd(i)]=max(TFAfinalodd(:,i));
                [maxeven(i),indmaxeven(i)]=max(TFAfinaleven(:,i));
                R(i)=maxodd(i)-TFAfinalodd(indmaxeven(i),i)+maxeven(i)...
                -TFAfinaleven(indmaxodd(i),i);
                avg = avg + R(i);
                %[val,maxval(i,q)]=max(TFAfinal(:,i));
                %sum(TFAmirval(:,i,:),3);
            end
            
            mr(q,j) = max(R);
            % winRxtailpad=[winRx;zeros(winLen*(I-1),N)];
            % % winRxpad=[winRx(N/2+1:N);zeros(winLen*(I-1),1);winRx(1:N/2)];
            % % fftpnt=length(winRxtailpad);

            [val,delaysel]=max(R);% calculating max of R and Selecting the two bins ...
            %corresponding to high and low frequency
            binsel1=indmaxeven(delaysel);
            binsel2=indmaxodd(delaysel);

            if binsel1>binsel2
                binhigh=binsel1;
                binlow=binsel2;
            else
                binhigh=binsel2;
                binlow=binsel1;
            end
%||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

%||||||||||||||||||||||||||||Data Detection||||||||||||||||||||||||||||||||

%******************************Initializing variables *********************
            TFAtaild=zeros(nodata,winLen*I);
            TFAvald=zeros(nodata,winLen*I);
            TFAmird=zeros(nodata,winLen*I);
%**************************************************************************

            for i=preleng:nodata-2%calculating STDFT for each symbol

                SampleData=Rxsample(N*(i-1)+delaysel:N*(i-1)+N-1+delaysel);

                winRxData=SampleData.*win;%applying window to samples

                winRxtailpadData=[winRxData;zeros(winLen*(I-1),1)];%zero padding
                % winRxpad=[winRx(N/2+1:N);zeros(winLen*(I-1),1);winRx(1:N/2)];
                %fftpnt=length(winRxtailpadData);

                TFAtaild(i,:)=fft(winRxtailpadData);%FFT calculation

                TFAvald(i,:)=abs(TFAtaild(i,:));%FFT magnitude calculation
                TFAmird(i,:)=[TFAvald(i,fftpnt/2+1:end),TFAvald(i,1:fftpnt/2)];%rearranging 
                %FFT values from -f to +f

%********************** Comparison and Decision making*********************
                if TFAmird(i,binlow)> TFAmird(i,binhigh)
                    datadetect(i)=0;
                else
                    datadetect(i)=1;
                end
            end
%**************************************************************************
%||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

%||||||||||||||||||||||||||||| BER Calculation ||||||||||||||||||||||||||||
            error=0;
            
                    
            for i=preleng+1:nodata-3
                if datadetect(i)~=data(i)
                   error=error+1;
                end
            end
            
            ber(q,j)=error/(nodata-2);
%||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        end
    end
%averaging BER results of all packets
berfinal(freqindex,:)=sum(ber(2:end,:),1)/MCM %#ok<NOPTS>
avg = avg/(4*14*50)
min(min(mr))
max(max(mr))
end

toc