function [ X ] = butterfly( type, x, N, USE_FP, w, i)
% w: number of bit dedicated to represent the entire number
% i: number of bit to represent the integer part (w = i+f, f bit for the fractional part)
    X = zeros(length(x), 1);
    W = zeros(length(x), 1);
    
    if USE_FP==1, x = convertToFp(x, 1, w, i); end
    
    if isrow(x)==0, x = transpose(x); end
    
    if type == 1 % samples need to be multiplied by the appropriate twiddle factors
        W(1:length(x)) = exp(-2i*pi/N) .^ (0:length(x)-1);
        
        if USE_FP==1, W = convertToFp(W, 1, w, i); end
        
        x = x .*  transpose(W);
        
        if USE_FP==1, x = convertToFp(x, 1, w, i); end
    end
    
    L = length(x)/2;
    for j=1:L
        X(j)    = x(j) + x(j+L);
        X(j+L)  = x(j) - x(j+L);
        
        if USE_FP==1
            X(j)    = convertToFp(X(j)  , 1, w, i);
            X(j+L)  = convertToFp(X(j+L), 1, w, i);
        end
    end
end