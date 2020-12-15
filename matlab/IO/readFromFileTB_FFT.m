function [ output ] = readFromFileTB_FFT( N, f )
    fileID = fopen('/home/giovanni/Desktop/matlab/RESULTS_TB_FFT.txt','r');
    output = zeros(N,1);
    
    for l=1:N
        y = fgetl(fileID);
        v = y(2:end);
        if y(1)=='1'
            s = -1;
        else
            s = 1;
        end
        r=s*bin2dec(v);

        y = fgetl(fileID);
        v = y(2:end);
        if y(1)=='1'
            s = -1;
        else
            s = 1;
        end
        im=s*bin2dec(v);

        output(l) = complex(r,im);
    end

    %output = output / 2^f;
    tmp = zeros(N,1);
    for i=1:N
        indices = GenerateBitReverse(N);
        tmp(indices(i)+1) = output(i);
    end
    output = tmp;
    fclose(fileID);
end

