function output_function = ssDem(adc_num_bit, input_ebn, input_noOfPackets, ...
    special_mag_sync, special_mag_detec, fft_zp, ...
    enAdc, en1, en2, en3, en4, en5, enfft, engrz, fp1f, fp1i, fpfftf, fpffti, ...
    fp2f, fp2i, fp3f, fp3i, fp4f, fp4i, fpgrzf, fpgrzi, fp5f, fp5i)

addpath(genpath('/FFT_ZP'));
addpath(genpath('/GoertzelKPrim'));
addpath(genpath('/FixedPointConverter'));

% set to 0 to suppress all the command window scribbling
DISPLAY_STUFF               = 0;
USE_SPECIAL_MAGNITUDE_SYNC  = special_mag_sync;
USE_SPECIAL_MAGNITUDE_DETEC = special_mag_detec;
USE_FFT_ZP_8_56             = fft_zp;

USE_ADC = enAdc;
    ADC_bit_resolution      = adc_num_bit;
    ADC_saturation_level    = 5;

% ============================ FIXED-POINT ================================
% (0,0) = depends on each case
% (1,0) = all enabled
% (x,1) = all disabled
ALL_FP_ENABLED = 0; DISABLE_ALL_FP = 0;

% 1FP magnitude, unsigned
ENABLE_1FP  = (en1 | ALL_FP_ENABLED) & ~DISABLE_ALL_FP;
FP1_f       = fp1f;
FP1_i       = fp1i; % biggest input magnitude R8.9926 I9.0724
FP1_w       = FP1_i+FP1_f;

% FPfft FFT ZP
ENABLE_FPfft = (enfft | ALL_FP_ENABLED) & ~DISABLE_ALL_FP;
FPfft_f      = fpfftf;
FPfft_i      = fpffti; % between 3 and 5 (biggest input magnitude R6.1499 I7.2534)
FPfft_w      = FPfft_i+FPfft_f;

% 2FP magnitude, unsigned
ENABLE_2FP  = (en2 | ALL_FP_ENABLED) & ~DISABLE_ALL_FP;
FP2_f       = fp2f;
FP2_i       = fp2i; % biggest input magnitude R25.656 I26.95
FP2_w       = FP2_i+FP2_f;
    
% 3FP accumulator, unsigned
ENABLE_3FP  = (en3 | ALL_FP_ENABLED) & ~DISABLE_ALL_FP;
FP3_f       = fp3f;
FP3_i       = fp3i;  % biggest input 19.533
FP3_w       = FP3_i+FP3_f;

% 4FP R, unsigned
ENABLE_4FP  = (en4 | ALL_FP_ENABLED) & ~DISABLE_ALL_FP;
FP4_f       = fp4f;
FP4_i       = fp4i;  % biggest input 96.238
                   % biggest output 102.56
FP4_w       = FP4_f+FP4_i;

% goertzel
ENABLE_FPgrz = (engrz | ALL_FP_ENABLED) & ~DISABLE_ALL_FP;
FPgrz_f      = fpgrzf;
FPgrz_i      = fpgrzi; % biggest input R8.9047 I8.8568
FPgrz_w      = FPgrz_f+FPgrz_i;

% 5FP magnitude, unsigned
ENABLE_5FP      = (en5 | ALL_FP_ENABLED) & ~DISABLE_ALL_FP;
FP5_f       = fp5f;
FP5_i       = fp5i;  % biggest input R23.998 I23.97
                   % biggest output 25.572
FP5_w       = FP5_i+FP5_f;
% ============================ END FIXED-POINT ============================

%STDFT for BFSK

% do not change these flags
FLAG_PREAMBLE_DETECTOR_DATA_LOADED_ALREADY  = 0;
FLAG_DATA_DETECTION_LOADED_ALREADY          = 0;
FLAG_COMPLETE_SYS_LOADED_ALREADY            = 0;

SAVE_DATA_DETECTION         = 0; % simulation time= 10ms (sim time) done in 20s
LOAD_DATA_DETECTION         = 0;

SAVE_DATA_PREAMBLE_DETECTOR = 0; % simulation time=  60'940 ns for each ebn
LOAD_DATA_PREAMBLE_DETECTOR = 0;

SAVE_DATA_FFT_ZP            = 0; % sim time = 1230 ns
LOAD_DATA_FFT_ZP            = 0;

SAVE_DATA_GOERTZEL          = 0;
LOAD_DATA_GOERTZEL          = 0;

SAVE_PD_DATA_ACQUISITION    = 0;
LOAD_PD_DATA_ACQUISITION    = 0;

SAVE_DD_DATA_ACQUISITION    = 0;
LOAD_DD_DATA_ACQUISITION    = 0;

SAVE_COMPLETE_SYS                       = 0; % 1 packet 1 ebn = 27 min (81ms sim time) packet = 1024 symbols (8192 samples) || packet 64 ->  
LOAD_COMPLETE_SYS                       = 0;
USE_MULTIPLE_TESTBENCHES_COMPLETE_SYS   = 0;

ebn             = input_ebn;            % range of Eb/N0
NoOfPckts       = input_noOfPackets;    % #of packets
LengthDataPckt  = 2^10;                 % length of data packet
ImposedDelay    = 0;                    % between 0 and 7 (M-1)

DataRate        = 2^10;         % data rate
Isync           = 8;            % interpolation factor during Synchronization
PreambleLength	= 16;           % length of preamble
FsVector        = 8*DataRate;   % Vector of sampling frequency values

if LOAD_DATA_GOERTZEL==1
    resgrzms = readFromFileTB_GOERTZEL2( FPgrz_w-FPgrz_i, NoOfPckts, length(ebn), LengthDataPckt-PreambleLength-2 );
end

if LOAD_DATA_FFT_ZP==1
    resfftzpms = readFromFileTB_FFT_ZP( NoOfPckts, length(ebn), PreambleLength-2, NumOfDelays );
end

if LOAD_PD_DATA_ACQUISITION==1
    loaded_preambles = readFromFileTB_PD_DATA_ACQUISITION( NoOfPckts, length(ebn), PreambleLength-2, NumOfDelays );
end

if LOAD_DD_DATA_ACQUISITION==1
    loaded_data = readFromFileTB_DD_DATA_ACQUISITION( FPgrz_w-FPgrz_i, NoOfPckts, length(ebn), LengthDataPckt-PreambleLength-2 );
end

%disp('====== START SCRIPT EXECUTION ======');

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
        Txsignal=[zeros(ImposedDelay,1);signal(1:end-ImposedDelay)];% or  [signal(sig_delay+1:end-4);zeros(sig_delay,1)];   %%%MODIFIED%%%%%
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
            if(DISPLAY_STUFF==1), [q ebn(j)], end
            
            SNR         = ebn(j) - 10*log10(Tsymbol/Ts);    % calculating SNR based on AWGN assumption 
            channelout  = awgn(Txsignal, SNR, 'measured');    % adding AWGN noise %%%%%MODIFIED%%%%%% Txsignal is replaced
            
            % OUTPUT OF THE TRANSMISSION CHANNEL
            
            if LOAD_DATA_FFT_ZP==0 && LOAD_DATA_GOERTZEL==0 && LOAD_DATA_DETECTION==0 && LOAD_DATA_PREAMBLE_DETECTOR==0 ...
                    && LOAD_DD_DATA_ACQUISITION==0 && LOAD_PD_DATA_ACQUISITION==0
                Rxsample = channelout .* (freqoffset(m, :)'); % applying frequency offset so that the samples at the receiver are obtained                
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
            
            if(ENABLE_1FP==1)
                Rxsample = convertToFp(Rxsample, 1, FP1_w, FP1_i);
            end
            
            if SAVE_DATA_GOERTZEL==1 || SAVE_DATA_FFT_ZP==1 || SAVE_DATA_PREAMBLE_DETECTOR==1 || SAVE_DATA_DETECTION==1 ...
                    || SAVE_PD_DATA_ACQUISITION==1 || SAVE_DD_DATA_ACQUISITION==1 || SAVE_COMPLETE_SYS==1
                tmprx(q,j,:) = Rxsample;
            end
            
            if SAVE_PD_DATA_ACQUISITION==1
                DATA_INPUT_SYNCHRONIZATION(q, j, :) = Rxsample(1:119);
            end
                                    
%|||||||||||||||||||||||||||||||Synchronization||||||||||||||||||||||||||||

% INPUT Rxsample

%*************************** Initializing Variables ***********************
            Wsync           = ones(Lsync,1);    % ST-DFT window during synchornization
            NumOfDelays     = M;              % #of different delay values tested in synchronization phase
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
                            
                            if SAVE_PD_DATA_ACQUISITION==1
                                DATA_PD_DATA_ACQUISITION(q,j,k,i,:) = Rxsample(startSsync : endSsync);
                            end

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
                            
                            % ================ MGNITUDE ================
                            if(USE_SPECIAL_MAGNITUDE_SYNC==0)
                                FFTsyncMagn(:, i, k)    = abs(FFTsyncRearr(:, i, k));
                            else
                                % 2FP
                                tmp2fp(:,k,i,q,j) = FFTsyncRearr(:, i, k);
                                if ENABLE_2FP==1, FFTsyncRearr(:, i, k)  = convertToFp(FFTsyncRearr(:, i, k), 1, FP2_w, FP2_i); end
                                
                                REAL_FFTsyncMagn(:, i, k)    = (real(FFTsyncRearr(:, i, k))).^2;
                                IMAG_FFTsyncMagn(:, i, k)    = (imag(FFTsyncRearr(:, i, k))).^2;                            
                                
                                if ENABLE_2FP==1
                                    REAL_FFTsyncMagn(:, i, k)  = convertToFp(REAL_FFTsyncMagn(:, i, k), 0, FP2_w, FP2_i);
                                    IMAG_FFTsyncMagn(:, i, k)  = convertToFp(IMAG_FFTsyncMagn(:, i, k), 0, FP2_w, FP2_i); 
                                end

                                FFTsyncMagn(:, i, k)    = REAL_FFTsyncMagn(:, i, k) + IMAG_FFTsyncMagn(:, i, k);
                                if ENABLE_2FP==1, FFTsyncMagn(:, i, k)  = convertToFp(FFTsyncMagn(:, i, k), 0, FP2_w, FP2_i); end

                                FFTsyncMagn(:, i, k)    = sqrt(FFTsyncMagn(:, i, k));
                                if ENABLE_2FP==1, FFTsyncMagn(:, i, k)  = convertToFp(FFTsyncMagn(:, i, k), 0, FP2_w, FP2_i); end
                            end
                        end
                    end
                    
                    for i = 1:NumOfDelays
                        for l = 1:PreambleLength/2 -1       % 7
                            for r = 1:length(FFTsyncMagn)   % 64       
                                % 3FP         
                                if ENABLE_3FP==1, FFTsyncMagn(r, i, 2*l -1)  = convertToFp(FFTsyncMagn(r, i, 2*l -1), 0, FP3_w, FP3_i); end
                                
                                TFAfinalodd(r,i)    = TFAfinalodd(r,i)  + FFTsyncMagn(r, i, 2*l -1); % sum odd indeces
                                TFAfinaleven(r,i)   = TFAfinaleven(r,i) + FFTsyncMagn(r, i, 2*l   ); % sum even indeces

                                if ENABLE_3FP==1
                                    TFAfinalodd(r,i)    = convertToFp(TFAfinalodd(r,i) , 0, FP3_w, FP3_i);
                                    TFAfinaleven(r,i)   = convertToFp(TFAfinaleven(r,i), 0, FP3_w, FP3_i);
                                end
                            end
                        end
                        
                        [maxodd(i), indmaxodd(i)]    = max(TFAfinalodd(:, i));
                        [maxeven(i), indmaxeven(i)]  = max(TFAfinaleven(:, i));
                        
                        % 4FP
                        if ENABLE_4FP==1
                            maxodd(i)   = convertToFp(maxodd(i), 0, FP4_w, FP4_i);
                            maxeven(i)  = convertToFp(maxeven(i), 0, FP4_w, FP4_i);
                        end
                        
                        t1 = maxodd(i) - TFAfinalodd(indmaxeven(i), i);
                        t2 = maxeven(i) - TFAfinaleven(indmaxodd(i), i);
                        if ENABLE_4FP==1
                            t1 = convertToFp(t1, 0, FP4_w, FP4_i);
                            t2 = convertToFp(t2, 0, FP4_w, FP4_i); 
                        end
                        
                        R(i) = t1 + t2;
                        if ENABLE_4FP==1, R(i) = convertToFp(R(i), 0, FP4_w, FP4_i); end
                    end

                    [val, delaysel] = max(R); % calculating max of R and Selecting the two bins corresponding to high and low frequency

                    binsel1 = indmaxeven(delaysel);
                    binsel2 = indmaxodd(delaysel);
                    
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
                %if(DISPLAY_STUFF==1), ['start of data detection'], end

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
                            grzL = goertzel_mod_kprim(WindowedData, iL(q,j), 64, ENABLE_FPgrz, FPgrz_w, FPgrz_i);
                            grzH = goertzel_mod_kprim(WindowedData, iH(q,j), 64, ENABLE_FPgrz, FPgrz_w, FPgrz_i);
                        else
                            grzL = resgrzms(q,j,i,2);
                            grzH = resgrzms(q,j,i,1);
                        end
                        
                        if(USE_SPECIAL_MAGNITUDE_DETEC==0)
                            if ENABLE_5FP==1
                                grzL = convertToFp(grzL, 1, FP5_w, FP5_i);
                                grzH = convertToFp(grzH, 1, FP5_w, FP5_i);
                            end
                            
                            grzL = abs(grzL);
                            grzH = abs(grzH);
                            
                            % 5FP
                            % values coming before this operation are between 0 and 23
                            if ENABLE_5FP==1
                                grzL = convertToFp(grzL, 0, FP5_w, FP5_i);
                                grzH = convertToFp(grzH, 0, FP5_w, FP5_i);
                            end
                        else
                            if(ENABLE_5FP==1)
                                grzL = convertToFp(grzL, 1, FP5_w, FP5_i);
                                grzH = convertToFp(grzH, 1, FP5_w, FP5_i);
                            end
                            
                            grzLR = real(grzL);
                            grzLI = imag(grzL);
                            grzHR = real(grzH);
                            grzHI = imag(grzH);
                            
                            grzLR = grzLR^2;
                            grzLI = grzLI^2;
                            grzHR = grzHR^2;
                            grzHI = grzHI^2;
                            
                            if(ENABLE_5FP==1)
                                grzLR = convertToFp(grzLR, 0, FP5_w, FP5_i);
                                grzLI = convertToFp(grzLI, 0, FP5_w, FP5_i);
                                grzHR = convertToFp(grzHR, 0, FP5_w, FP5_i);
                                grzHI = convertToFp(grzHI, 0, FP5_w, FP5_i);
                            end
                            
                            grzL  = grzLR+grzLI;
                            grzH  = grzHR+grzHI;
                            
                            if(ENABLE_5FP==1)
                                grzL = convertToFp(grzL, 0, FP5_w, FP5_i);
                                grzH = convertToFp(grzH, 0, FP5_w, FP5_i);
                            end
                            
                            grzL  = sqrt(grzL);
                            grzH  = sqrt(grzH);
                            
                            if(ENABLE_5FP==1)
                                grzL = convertToFp(grzL, 0, FP5_w, FP5_i);
                                grzH = convertToFp(grzH, 0, FP5_w, FP5_i);
                            end
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
                    datadetect_LOADED = readFromFileTB_COMPLETE_SYS(NoOfPckts, length(ebn), LengthDataPckt-PreambleLength-2, USE_MULTIPLE_TESTBENCHES_COMPLETE_SYS);
                    FLAG_COMPLETE_SYS_LOADED_ALREADY = 1;
                end
                
                datadetect_adj(q,j,:) = [preamble', squeeze(datadetect_LOADED(q, j, :))']';
                datadetect = datadetect_adj(q,j,:);
            end
%**************************************************************************

%||||||||||||||||||||||||||||| BER Calculation
%||||||||||||||||||||||||||||%%%%%%%MODIFIED%%%%%%%%%
            error1=0;
            error2=0;
            error3=0;                
            for i = PreambleLength+1 : LengthDataPckt-3
                if datadetect(i) ~= dataq(q,i)
                   error1 = error1+1;
                end
                if datadetect(i-1) ~= dataq(q,i)
                   error2 = error2+1;
                end
                if datadetect(i) ~= dataq(q,i+1)
                   error3= error3+1;
                end
            end
            
            ber(q,j) = min([error3,error1,error2])/(LengthDataPckt-2-PreambleLength);
%||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        end
    end
    
    berfinal                = zeros(length(FsVector), length(ebn));  % initializing "berfinal" which is BER result from all packets
    berfinal(freqindex,:)   = sum(ber(1:end, :), 1)/NoOfPckts;       % averaging BER results of all packets
    if(DISPLAY_STUFF==1)
        [" ===== BER ===== "]
    	[ebn; berfinal].'
    end
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
        writeToFileTB_PD_DATA_ACQUISITION(DATA_INPUT_SYNCHRONIZATION, FPfft_w, FPfft_w-FPfft_i, NoOfPckts, length(ebn));
    end
    
    if SAVE_DATA_GOERTZEL==1
        writeToFileTB_GOERTZEL2(iH, iL, INPUT_DATA_DETECTION, 6, FPgrz_w, FPgrz_w-FPgrz_i);
    end
    
    if SAVE_DD_DATA_ACQUISITION==1
        writeToFileTB_DD_DATA_ACQUISITION(tmprx, FPgrz_w, FPgrz_w-FPgrz_i, NoOfPckts, length(ebn), ImposedDelay);
    end
    
    if SAVE_COMPLETE_SYS==1
        writeToFileTB_COMPLETE_SYS(tmprx, FPfft_w, FPfft_w-FPfft_i, FPgrz_w, FPgrz_w-FPgrz_i, NoOfPckts, length(ebn), ImposedDelay, USE_MULTIPLE_TESTBENCHES_COMPLETE_SYS );
    end
    
if(DISPLAY_STUFF==1)
%     load gong.mat;
%     sound(y(1:1200));

    [" ===== BER ===== "]
    [ebn; berfinal].'
    
    %toc
end

output_function = berfinal;

end