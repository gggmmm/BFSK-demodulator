function [ output ] = readFromFileTB_FFT_ZP( qmax, jmax, kmax, imax )
    fileID = fopen('/home/giovanni/Desktop/matlab/RESULTS_TB_FFT_ZP.txt','r');
    output = zeros(qmax,jmax,4,64);
    for q=1:qmax
        for j=1:jmax
            ['reading fft zp']
            [q j]
            
            for k=1:kmax
                for i=1:imax
                    for l=1:64
                        y = fgetl(fileID);
                        v = y(2:end);
                        if y(1)=='1'
                            s = -1;
                        else
                            s = 1;
                        end
                        r=s*bin2dec(v)/128;

                        y = fgetl(fileID);
                        v = y(2:end);
                        if y(1)=='1'
                            s = -1;
                        else
                            s = 1;
                        end
                        im=s*bin2dec(v)/128;

                        output(q, j, k, i, l) = complex(r,im);
                    end
                end
            end
        end
    end

    fclose(fileID);
end

