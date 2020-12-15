function [BinLow, BinHigh, delaysel] = readFromFileTB_PREAMBLE_DETECTOR( qmax, jmax )
    fileID = fopen('/home/giovanni/Desktop/matlab/RESULTS_TB_PREAMBLE_DETECTOR.txt','r');
    
    for q=1:qmax
        for j=1:jmax
            ['r PREAMBLE DETECTOR']
            [q j]
            
            y = fgetl(fileID);
            BinLow(q, j) = bin2dec(y);
            
            y = fgetl(fileID);
            BinHigh(q, j) = bin2dec(y);
            
            y = fgetl(fileID);
            delaysel(q, j) = bin2dec(y) +1;
        end
    end

    fclose(fileID);
end