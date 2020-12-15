function [ X ] = fft_zp_8_56( x, USE_FP, w, i )
    X = zeros(64, 1);
    N = 64;
    
    if USE_FP==1
        x = convertToFp(x, 1, w, i);
    end
    
    if isrow(x)==1
        x = transpose(x);
    end
    
    if length(x) == 8
        %       STAGE 1 (transfers)
        stage1          = zeros(N, 1);
        
        stage1(1:8)     = x; % 0 1 2 3 4 5 6 7
        stage1(9:16)    = x; % 0 1 2 3 4 5 6 7
        
        % =================================================================
        W               = (exp(-2i*pi/(N/2)) .^ (0:7)).';
        if USE_FP==1, W = convertToFp(W,  1, w, i); end
        stage1(17:24)   = x .* W;           % a b c d e f g h
        stage1(25:32)   = stage1(17:24);    % a b c d e f g h
        
        % =================================================================
        W               = (exp(-2i*pi/(N)) .^ (0:7)).';
        if USE_FP==1, W = convertToFp(W,  1, w, i); end
        stage1(33:40)   = x .* W;           % i j k l m n o p
        stage1(41:48)   = stage1(33:40);    % i j k l m n o p
        
        % =================================================================
        W               = (exp(-2i*pi/(N/2)) .^ (0:7)).';
        if USE_FP==1, W = convertToFp(W,  1, w, i); end
        stage1(49:56)   = stage1(33:40) .* W;   % q r s t u v w x
        stage1(57:64)   = stage1(49:56);        % q r s t u v w x
        
        stage1 = convertToFp(stage1, 1, w, i);
        
        %       STAGE 2
        stage2 = zeros(N, 1);
        jump = 8;
        for j=1:2:8
            sb1 = (j-1)*jump+1;
            eb1 = j*jump;
            sb2 = eb1 + 1;
            eb2 = eb1 + jump;
            stage2(sb1 : eb1)   = butterfly(0, transpose(stage1(sb1 : eb1)), N/4, USE_FP, w, i);
            stage2(sb2 : eb2)   = butterfly(1, transpose(stage1(sb2 : eb2)), N/4, USE_FP, w, i);
        end
       
        %       STAGE 3
        stage3 = zeros(N, 1);
        jump = 4;
        for j=1:2:16
            sb1 = (j-1)*jump+1;
            eb1 = j*jump;
            sb2 = eb1 + 1;
            eb2 = eb1 + jump;
            stage3(sb1 : eb1)   = butterfly(0, transpose(stage2(sb1 : eb1)), N/8, USE_FP, w, i);
            stage3(sb2 : eb2)   = butterfly(1, transpose(stage2(sb2 : eb2)), N/8, USE_FP, w, i);
        end
        
        %       STAGE 4
        stage4 = zeros(N, 1);
        jump = 2;
        for j=1:2:32
            sb1 = (j-1)*jump+1;
            eb1 = j*jump;
            sb2 = eb1 + 1;
            eb2 = eb1 + jump;
            stage4(sb1 : eb1)   = butterfly(0, transpose(stage3(sb1 : eb1)), N/16, USE_FP, w, i);
            stage4(sb2 : eb2)   = butterfly(1, transpose(stage3(sb2 : eb2)), N/16, USE_FP, w, i);
        end
        
        br = GenerateBitReverse(64);
        
        for j=1:64
            X(br(j)+1) = stage4(j);
        end
    else
        sprintf('ERROR x does not have length of 8');
    end
end

