function [ output ] = readFromFileTB_GOERTZEL2( f, qmax, jmax,  length_packet  )
    fileID = fopen('/home/giovanni/Desktop/matlab/RESULTS_TB_GOERTZEL2.txt','r');
    
    div = 2^f;
    
    output = zeros(qmax, jmax, length_packet, 2);
    
    for q=1:qmax
        for j=1:jmax
            ['reading grz']
            [q j]
            for k=1:length_packet
                for i=1:2 % i=1 => iH, i=2 => iL
                    % REAL PART
                    y = fgetl(fileID);
                    v = y(2:end);
                    if y(1)=='1'
                        s = -1;
                    else
                        s = 1;
                    end
                    r = s*bin2dec(v)/div;
                    
                    % IMAGINARY PART
                    y = fgetl(fileID);
                    v = y(2:end);
                    if y(1)=='1'
                        s = -1;
                    else
                        s = 1;
                    end
                    im = s*bin2dec(v)/div;

                    output(q, j, k, i) = complex(r,im);
                end
            end
        end
    end

    fclose(fileID);
end