function [ Xkn ] = SDFT( input, k, N, M )
    buffer1 = 0;
    bufferM = zeros(M,1);
    kprim = k*M/N;
    
    exp(-2j*pi*kprim*M/M)*(2^11);
    exp(2j*pi*kprim/M)*(2^11);
    
    for i=1:length(input)
        input(i)
%         if N > M
            firstAdd        = input(i)*exp(-2j*pi*kprim*M/M) - bufferM(end); % modified SDFT
%         else
%             firstAdd        = input(i) - bufferM(end); % original SDFT
%         end
        bufferM(2:end)  = bufferM(1:end-1);  % shift
        bufferM(1)      = input(i);          % insertion
        bufferM;
        secondAdd       = buffer1 + firstAdd;
        Xkn             = secondAdd*exp(2j*pi*kprim/M);
        buffer1 = Xkn;
        ['=============================='];
    end
end

