clc;

tic

addpath(genpath('/FFT_ZP'));
addpath(genpath('/GoertzelKPrim'));
addpath(genpath('/FixedPointConverter'));

% ============================ FIXED-POINT ================================
% (0,0) = depends on each case
% (1,0) = all enabled
% (x,1) = all disabled
ALL_FP_ENABLED = 0; DISABLE_ALL_FP = 1;

% 1FP Rxsample
ENABLE_1FP  = (0 | ALL_FP_ENABLED) & ~DISABLE_ALL_FP;
FP1_w       = 13;
FP1_i       = 3; % between -2.44 and 2.44

% FPfft FFT ZP
ENABLE_FPfft = (0 | ALL_FP_ENABLED) & ~DISABLE_ALL_FP;
FPfft_w      = 12;
FPfft_i      = 5; % between 3 and 5 (values are between -10 and 10)

% 2FP magnitude, unsigned
ENABLE_2FP  = (0 | ALL_FP_ENABLED) & ~DISABLE_ALL_FP;
FP2_w       = 10;
FP2_i       = 5; % max value in input is 25 for both real and imag
    
% 3FP TFAfinalodd/even, unsigned
ENABLE_3FP  = (0 | ALL_FP_ENABLED) & ~DISABLE_ALL_FP;
FP3_w       = 12;
FP3_i       = 7;

% 4FP R, unsigned
ENABLE_4FP  = (0 | ALL_FP_ENABLED) & ~DISABLE_ALL_FP;
FP4_w       = 12;
FP4_i       = 7;

% goertzel
ENABLE_FPgrz = (0 | ALL_FP_ENABLED) & ~DISABLE_ALL_FP;
FPgrz_w      = 12;
FPgrz_i      = 7;

% 5FP magnitude, unsigned
ENABLE_5FP  = (0 | ALL_FP_ENABLED) & ~DISABLE_ALL_FP;
FP5_w       = 8;
FP5_i       = 4;
% ============================ END FIXED-POINT ============================

%STDFT for BFSK

FLAG_PREAMBLE_DETECTOR_DATA_LOADED_ALREADY  = 0;
FLAG_DATA_DETECTION_LOADED_ALREADY          = 0;
FLAG_COMPLETE_SYS_LOADED_ALREADY            = 0;

SAVE_DATA_DETECTION         = 0; % simulation time= 10ms (sim time) done in 20s
LOAD_DATA_DETECTION         = 0;

SAVE_DATA_PREAMBLE_DETECTOR = 0; % simulation time=  27'390 for each ebn, each simulation takes 6.409 s (real time)
LOAD_DATA_PREAMBLE_DETECTOR = 0;

SAVE_DATA_FFT_ZP            = 0;
LOAD_DATA_FFT_ZP            = 0;

SAVE_DATA_GOERTZEL          = 0;
LOAD_DATA_GOERTZEL          = 0;

SAVE_PD_DATA_ACQUISITION    = 0;
LOAD_PD_DATA_ACQUISITION    = 0;

SAVE_DD_DATA_ACQUISITION    = 0;
LOAD_DD_DATA_ACQUISITION    = 0;

SAVE_COMPLETE_SYS           = 0; % 1 packet 1 ebn = 27 min (81ms sim time) packet = 1024 symbols (8192 samples) || packet 64 ->  
LOAD_COMPLETE_SYS           = 0;

USE_FFT_ZP_8_56 = 0;

USE_ADC = 1;
    ADC_bit_resolution = 8;
    ADC_saturation_level = 5;

ebn             = 1:14;         % range of Eb/N0
NoOfPckts       = 20;            % #of packets
LengthDataPckt  = 2^10;          % length of data packet
ImposedDelay    = 0;            % between 0 and 3 included

DataRate        = 2^10;         % data rate
Isync           = 8;            % interpolation factor during Synchronization
PreambleLength	= 16;           % length of preamble
FsVector        = 8*DataRate;   % Vector of sampling frequency values

if LOAD_DATA_GOERTZEL==1
    resgrzms = readFromFileTB_GOERTZEL2( FPgrz_w-FPgrz_i, NoOfPckts, length(ebn), LengthDataPckt-18 );
end

if LOAD_DATA_FFT_ZP==1
    resfftzpms = readFromFileTB_FFT_ZP( NoOfPckts, length(ebn) );
end

if LOAD_PD_DATA_ACQUISITION==1
    loaded_preambles = readFromFileTB_PD_DATA_ACQUISITION( NoOfPckts, length(ebn), PreambleLength-2, NumOfDelays );
end

if LOAD_DD_DATA_ACQUISITION==1
    loaded_data = readFromFileTB_DD_DATA_ACQUISITION( FPgrz_w-FPgrz_i, NoOfPckts, length(ebn), LengthDataPckt-PreambleLength-2 );
end

disp('====== START SCRIPT EXECUTION ======');

for freqindex = 1:length(FsVector)
    Fs                  = FsVector(freqindex);              % specifying sampling frequency
    M                   = Fs/DataRate;                      % #of samples per symbol
    ber                 = zeros(NoOfPckts, length(ebn));    % initializing BER array
    Tsymbol             = 1/DataRate;                       % symbol period
    Ts                  = 1/Fs;                             % sampling time
    Lsync               = M;                                % length of window during synchronization
    fftpnt              = Lsync*Isync;                      % FFT points
    
    for q = 1:NoOfPckts
%****************************Random Data generation************************
        preamble1   = ones(1, PreambleLength/2);
        preamble2   = zeros(1, PreambleLength/2);
        preamble    = [preamble1; preamble2];
        preamble    = preamble(:);
        
        if ~(LOAD_DATA_FFT_ZP==1 || LOAD_DATA_GOERTZEL==1 || LOAD_DATA_PREAMBLE_DETECTOR==1 || LOAD_DATA_DETECTION==1 ...
            || LOAD_DD_DATA_ACQUISITION==1 || LOAD_PD_DATA_ACQUISITION==1 || LOAD_COMPLETE_SYS==1)
            data = [preamble; 1; randi([0,1], LengthDataPckt-PreambleLength-1, 1)]; % Transmitted data incl. preamble
            dataq(q,:) = data;
        end
        
        
%**************************************************************************

%************************Generating Transmitted Signal********************
        datasample  = repelem(dataq(q,:), M);   % repeating data samples; rectangular pulse of transmited data
        Txdata      = 2*datasample -1;          % bipolar conversion; 0/1 to -1/+1
        fdev        = DataRate;                 % FSK frequency separation
        freq        = (fdev/2)*Txdata;          % Instantaneous frequency of signal
        Tend        = LengthDataPckt*Tsymbol;   % end of simulation time; it is useful for frequency offset simulation
        t           = (Ts:Ts:Tend)';            % time
        freqtime    = freq*Ts;                  % frequency-time product
        phi         = zeros(length(t), 1);      % initializing phase vector
        
        accumulator = 0;
        for i = 1:length(t)	% generating phase vector for signal
            accumulator = accumulator + freqtime(i);
            phi(i)      = accumulator;
        end
        phi = phi*2*pi;
                
        signal = exp(1i*phi);	% generating signal
%**************************************************************************

        datadetect = zeros(LengthDataPckt, 1);       % initializing detected symbols vector

%*********************Frequency offset vector generation*******************
        foffset     = DataRate + DataRate/8;                  % frequency offset value
        freqoffset  = zeros(length(foffset), length(t));
        
        for m = 1:length(foffset)
            freqoffset(m, :) = exp(1i*2*pi*t*foffset(m));
        end
%**************************************************************************

% Channel Modeling and Receiver
        for j = 1:length(ebn)   % doing it for different Eb/N0 values to acheive a BER vs Eb/N0 curve
            [q ebn(j)]
            
            SNR         = ebn(j) - 10*log10(Tsymbol/Ts);    % calculating SNR based on AWGN assumption 
            channelout  = awgn(signal, SNR, 'measured');    % adding AWGN noise
            
            % OUTPUT OF THE TRANSMISSION CHANNEL
            
            if LOAD_DATA_FFT_ZP==0 && LOAD_DATA_GOERTZEL==0 && LOAD_DATA_DETECTION==0 && LOAD_DATA_PREAMBLE_DETECTOR==0 ...
                    && LOAD_DD_DATA_ACQUISITION==0 && LOAD_PD_DATA_ACQUISITION==0
                Rxsample = channelout .* (freqoffset(m, :)'); % applying frequency offset so that the samples at the receiver are obtained
                
                %%if ImposedDelay > 0
                    Rxsample = [repelem(0, ImposedDelay).'; Rxsample(1:end-ImposedDelay)];
                %end
            else
                Rxsample = squeeze(tmprx(q,j,:));
            end

            if USE_ADC==1
                % calculate RMS
                prms = rms(Rxsample)^2;
                ADC_saturation_level = 1.2*prms;
                
                realpart = real(Rxsample);
                imagpart = imag(Rxsample);

                realpartQ = ADC(realpart, ADC_saturation_level, ADC_bit_resolution);
                imagpartQ = ADC(imagpart, ADC_saturation_level, ADC_bit_resolution);
                
                Rxsample = complex(realpartQ, imagpartQ);
            end
            
            if SAVE_DATA_GOERTZEL==1 || SAVE_DATA_FFT_ZP==1 || SAVE_DATA_PREAMBLE_DETECTOR==1 || SAVE_DATA_DETECTION==1 ...
                    || SAVE_PD_DATA_ACQUISITION==1 || SAVE_DD_DATA_ACQUISITION==1 || SAVE_COMPLETE_SYS==1
                tmprx(q,j,:) = Rxsample;
            end
            
            if SAVE_PD_DATA_ACQUISITION==1
                DATA_INPUT_SYNCHRONIZATION(q, j, :) = Rxsample(1:115);
            end
            
            % 1FP
%             if ENABLE_1FP==1
%                 Rxsample = convertToFp(Rxsample, 1, FP1_w, FP1_i);
%             end
                        
%|||||||||||||||||||||||||||||||Synchronization||||||||||||||||||||||||||||

% INPUT Rxsample

%*************************** Initializing Variables ***********************
            Wsync           = ones(Lsync,1);    % ST-DFT window during synchornization
            NumOfDelays     = M/2;              % #of different delay values tested in synchronization phase
            TFAfinalodd     = zeros(Lsync*Isync, NumOfDelays);
            TFAfinaleven    = zeros(Lsync*Isync, NumOfDelays);
            FFTsync         = zeros(Lsync*Isync, NumOfDelays, PreambleLength-2);
            FFTsyncRearr    = zeros(Lsync*Isync, NumOfDelays, PreambleLength-2);
            FFTsyncMagn     = zeros(Lsync*Isync, NumOfDelays, PreambleLength-2);
            maxindex        = zeros(LengthDataPckt/2, 1);
            maxodd          = zeros(NumOfDelays, 1);
            maxeven         = zeros(NumOfDelays, 1);
            indmaxeven      = zeros(NumOfDelays, 1);
            indmaxodd       = zeros(NumOfDelays, 1);
            R               = zeros(NumOfDelays, 1);
            Sample          = zeros(Lsync, NumOfDelays);
            WindowedSample  = zeros(Lsync, NumOfDelays);
%**************************************************************************
%symbol timing correction
            if LOAD_COMPLETE_SYS==0
                if LOAD_DATA_PREAMBLE_DETECTOR==0
                    for k = 1:PreambleLength-2
                        for i = 1:NumOfDelays
                            startSsync              = M*(k-1) + i;
                            endSsync                = startSsync + M-1;

                            if LOAD_PD_DATA_ACQUISITION==0
                                Sample(:, i) = Rxsample(startSsync : endSsync);
                            else
                                Sample(:, i) = squeeze( loaded_preambles(q,j,k,i,:) );
                            end

                            WindowedSample(:, i)	= Sample(:,i) .* Wsync;
                            ZPaddedSample           = [WindowedSample ; zeros(Lsync*(Isync-1), NumOfDelays)];

                            if SAVE_DATA_PREAMBLE_DETECTOR==1 || SAVE_DATA_FFT_ZP==1 || SAVE_COMPLETE_SYS==1
                                DATA_INPUT_SYNCHRONIZATION(q,j,k,i,:) = Rxsample(startSsync : endSsync);
                            end

                            % FPfft
                            if USE_FFT_ZP_8_56==1
                                FFTsync(:, i, k)    = fft_zp_8_56(WindowedSample(:, i).', ENABLE_FPfft, FPfft_w, FPfft_i);
                            else                    
                                if LOAD_DATA_FFT_ZP==1
                                    FFTsync(:,i,k)      = resfftzpms(q,j,k,i,:);
                                else
                                    FFTsync(:, i, k)    = fft(ZPaddedSample(:, i));
                                end
                            end
                            
                            % rearranging FFT points from -f to +f
                            FFTsyncRearr(:, i, k)   = [FFTsync(fftpnt/2 +1 : end, i, k) ; FFTsync(1 : fftpnt/2, i, k)]; 
                            FFTsyncMagn(:, i, k)    = abs(FFTsyncRearr(:, i, k));

                            % 2FP
                            if ENABLE_2FP==1
                                [FFTsyncMagn(:, i, k) b] = convertToFp(FFTsyncMagn(:, i, k), 0, FP2_w, FP2_i);
                            end
                        end
                    end

                    for i = 1:NumOfDelays
                        for l = 1:PreambleLength/2 -1       % 7
                            for r = 1:length(FFTsyncMagn)   % 64
                                TFAfinalodd(r,i)    = TFAfinalodd(r,i)  + FFTsyncMagn(r, i, 2*l -1); % sum odd indeces
                                TFAfinaleven(r,i)   = TFAfinaleven(r,i) + FFTsyncMagn(r, i, 2*l   ); % sum even indeces

                                % 3FP
                                if ENABLE_3FP==1
                                    TFAfinalodd(r,i)    = convertToFp(TFAfinalodd(r,i) , FP3_w, FP3_i);
                                    TFAfinaleven(r,i)   = convertToFp(TFAfinaleven(r,i), FP3_w, FP3_i);
                                end
                            end
                        end

                        [maxodd(i), indmaxodd(i)]    = max(TFAfinalodd(:, i));
                        [maxeven(i), indmaxeven(i)]  = max(TFAfinaleven(:, i));

                        R(i) = maxodd(i) - TFAfinalodd(indmaxeven(i), i) + maxeven(i) - TFAfinaleven(indmaxodd(i), i);

                        % 4FP
                        if ENABLE_4FP==1
                            R(i) = convertToFp(R(i), FP4_w, FP4_i);
                        end

                    end

                    [val, delaysel] = max(R); % calculating max of R and Selecting the two bins corresponding to high and low frequency

                    binsel1 = indmaxeven(delaysel);
                    binsel2 = indmaxodd(delaysel);
                    
                    all_delaysel(q,j,:) = delaysel;

                    if binsel1 > binsel2
                        BinHigh = binsel1;
                        BinLow  = binsel2;
                    else
                        BinHigh = binsel2;
                        BinLow  = binsel1;
                    end

                else
                    if FLAG_PREAMBLE_DETECTOR_DATA_LOADED_ALREADY==0
                        [BinLowLOADED, BinHighLOADED, delayselLOADED] = readFromFileTB_PREAMBLE_DETECTOR(NoOfPckts, length(ebn));
                        FLAG_PREAMBLE_DETECTOR_DATA_LOADED_ALREADY = 1;
                    end

                    BinLow = BinLowLOADED(q, j);
                    BinHigh = BinHighLOADED(q, j);
                    delaysel = delayselLOADED(q, j);
                end

                if LOAD_DATA_PREAMBLE_DETECTOR==1
                    iL(q,j) = BinLow;
                    iH(q,j) = BinHigh;
                    delaysel = delaysel;
                else
                    iL(q,j) = mod( BinLow  +32-1, 64 );
                    iH(q,j) = mod( BinHigh +32-1, 64 );
                end

                % BinHigh AND BinLow OUTPUT OF SYNCHRONIZATION

    %||||||||||||||||||||||||||||Data Detection||||||||||||||||||||||||||||||||

    % INPUT Rxsample, BinLow, BinHigh, delaysel

    %***********************Initializing variables ****************************
                L               = M;            % length of window
                W               = ones(L,1);    % ST-DFT window
    %**************************************************************************
                ['start of data detection']

                for i = 1 : LengthDataPckt-2-PreambleLength % calculating STDFT for each symbol
                    if LOAD_DATA_DETECTION==0
                        startS              = M*(i+PreambleLength-1) + delaysel;
                        endS                = startS + M-1;

                        if LOAD_DD_DATA_ACQUISITION==0
                            SampleData = Rxsample(startS : endS);                        
                        else
                            SampleData = squeeze(loaded_data(q, j, i, :));
                        end

                        if SAVE_DD_DATA_ACQUISITION==1 || SAVE_COMPLETE_SYS==1 || SAVE_DATA_DETECTION==1 || SAVE_DATA_GOERTZEL==1
                            INPUT_DATA_DETECTION(q,j,i,:) = SampleData;
                        end

                        WindowedData = SampleData .* W; % applying window to samples

        %********************** Comparison and Decision making*********************                
                        if LOAD_DATA_GOERTZEL==0
                            % FPgrz
                            grzL = goertzel_mod_kprim_i(WindowedData, iL(q,j), ENABLE_FPgrz, FPgrz_w, FPgrz_i);
                            grzH = goertzel_mod_kprim_i(WindowedData, iH(q,j), ENABLE_FPgrz, FPgrz_w, FPgrz_i);
                        else
                            grzL = resgrzms(q,j,i,2);
                            grzH = resgrzms(q,j,i,1);
                        end

                        grzL = abs(grzL);
                        grzH = abs(grzH);

                        % 5FP
                        % values coming before this operation are between 0 and 23
                        if ENABLE_5FP==1
                            [grzL, b] = convertToFp(grzL, 0, FP5_w, FP5_i);
                            [grzH, c] = convertToFp(grzH, 0, FP5_w, FP5_i);
                        end

                        if grzL > grzH
                            datadetect(i+PreambleLength) = 0;
                        else
                            datadetect(i+PreambleLength) = 1;
                        end
                    else
                        if FLAG_DATA_DETECTION_LOADED_ALREADY==0
                            datadetectLOADED = readFromFileTB_DATA_DETECTION(NoOfPckts, length(ebn), LengthDataPckt-2-PreambleLength);
                            FLAG_DATA_DETECTION_LOADED_ALREADY = 1;
                        end

                        datadetect(i+PreambleLength) = datadetectLOADED(q, j, i);
                    end
                end
            else
                if FLAG_COMPLETE_SYS_LOADED_ALREADY==0
                    datadetect_LOADED = readFromFileTB_COMPLETE_SYS(NoOfPckts, length(ebn), LengthDataPckt-PreambleLength, 1);
                    FLAG_COMPLETE_SYS_LOADED_ALREADY = 1;
                end
                
                datadetect_adj(q,j,:) = [preamble', squeeze(datadetect_LOADED(q, j, :))']';
                datadetect = datadetect_adj(q,j,:);
            end
%**************************************************************************

%||||||||||||||||||||||||||||| BER Calculation ||||||||||||||||||||||||||||
            error = 0;
                    
            for i = PreambleLength+1 : LengthDataPckt-3
                if datadetect(i) ~= dataq(q,i)
                   error = error+1;
                end
            end
            
            ber(q,j) = error/(LengthDataPckt-2-PreambleLength);
%||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        end
    end
    
    berfinal                = zeros(length(FsVector), length(ebn));  % initializing "berfinal" which is BER result from all packets
    berfinal(freqindex,:)   = sum(ber(1:end, :), 1)/NoOfPckts;       % averaging BER results of all packets
    [" ===== BER ===== "]
    [ebn; berfinal].'
end
    if SAVE_DATA_DETECTION==1
        writeToFileTB_DATA_DETECTION(iH, iL, INPUT_DATA_DETECTION, 6, FPgrz_w, FPgrz_w-FPgrz_i);
    end

    if SAVE_DATA_PREAMBLE_DETECTOR==1
        writeToFileTB_PREAMBLE_DETECTOR ...
            (DATA_INPUT_SYNCHRONIZATION, FPfft_w, FPfft_w-FPfft_i, NoOfPckts, length(ebn), PreambleLength-2, NumOfDelays);
    end

    if SAVE_DATA_FFT_ZP==1
        writeToFileTB_FFT_ZP(DATA_INPUT_SYNCHRONIZATION, FPfft_w, FPfft_w-FPfft_i, NoOfPckts, length(ebn), PreambleLength-2, NumOfDelays);
    end
    
    if SAVE_PD_DATA_ACQUISITION==1
        writeToFileTB_DATA_ACQUISITION(DATA_INPUT_SYNCHRONIZATION, FPfft_w, FPfft_w-FPfft_i, NoOfPckts, length(ebn));
    end
    
    if SAVE_DATA_GOERTZEL==1
        writeToFileTB_GOERTZEL2(iH, iL, INPUT_DATA_DETECTION, 6, FPgrz_w, FPgrz_w-FPgrz_i);
    end
    
    if SAVE_DD_DATA_ACQUISITION==1
        writeToFileTB_DD_DATA_ACQUISITION(tmprx, FPgrz_w, FPgrz_w-FPgrz_i, NoOfPckts, length(ebn));
    end
    
    if SAVE_COMPLETE_SYS==1
        writeToFileTB_COMPLETE_SYS(tmprx, FPfft_w, FPfft_w-FPfft_i, FPgrz_w, FPgrz_w-FPgrz_i, NoOfPckts, length(ebn), ImposedDelay, 1 );
    end

    if isempty(who('reference_ber')) %plot the theoretical curve only once
        reference_ber = [0.39092      0.34366       0.2583      0.19513      0.13429     0.073562     0.045675 ...
                         0.02272     0.010607    0.0040117 0.00074364   0.00027397   1.9569e-05            0];
        semilogy(1:14, reference_ber);
        hold on;
    end
    
    semilogy(ebn, berfinal,'*');
    
%     load gong.mat;
%     sound(y(1:4500));

[" ===== BER ===== "]
[ebn; berfinal].'
    
toc
