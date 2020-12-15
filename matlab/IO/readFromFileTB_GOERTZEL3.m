function [ output ] = readFromFileTB_GOERTZEL3( f, size )
    fileID = fopen('/home/giovanni/Desktop/matlab/RESULTS_TB_GOERTZEL3.txt','r');
    
    div = 2^f;
    
    for k=1:size
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

        output(k) = complex(r,im);
    end

    fclose(fileID);
end