function datadetected = readFromFileTB_DATA_DETECTION( qmax, jmax, imax )
    fileID = fopen('/home/giovanni/Desktop/matlab/RESULTS_TB_DATA_DETECTION.txt','r');
    datadetected = zeros(qmax, jmax, imax);
    
    for q=1:qmax
        for j=1:jmax
            ['r DATA DETECTION']
            [q j]
            for i=1:imax            
                y = fgetl(fileID);
                if y=='1'
                    datadetected(q, j, i) = 1;
                else
                    datadetected(q, j, i) = 0;
                end
            end
        end
    end

    fclose(fileID);
end