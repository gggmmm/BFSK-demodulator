function output = readFromFileTB_SDFT_RESONATOR( N, f )
    fileID = fopen('/home/giovanni/Desktop/matlab/SDFT/s/RESULTS_TB_SDFT_RESONATOR.txt','r');
        
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
    
    output = output / 2^f;
    fclose(fileID);
end