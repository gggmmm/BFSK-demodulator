function [output] = readFromFileTB_DD_DATA_ACQUISITION( f, qmax, jmax, dim )
    fileID = fopen('/home/giovanni/Desktop/matlab/RESULTS_TB_DD_DATA_ACQUISITION.txt','r');
    
    f = 2^f;
    
    for q=1:qmax
        for j=1:jmax
            ['r DD ACQUISITION']
            [q j]
            
            for k=1:dim
                for l=1:8
                    y = fgetl(fileID);
                    v = y(2:end);
                    if y(1)=='1'
                        s = -1;
                    else
                        s = 1;
                    end
                    r = s*bin2dec(v)/f;

                    y = fgetl(fileID);
                    v = y(2:end);
                    if y(1)=='1'
                        s = -1;
                    else
                        s = 1;
                    end
                    im = s*bin2dec(v)/f;

                    output(q, j, k, l) = complex(r,im);
                end
            end
        end
    end

    fclose(fileID);
end