function writeToFileTB_FFT( datainput, w, append )
    if append==1
        mode = 'a';
    else
        mode = 'w';
    end

    fileID = fopen('/home/giovanni/Desktop/matlab/STIMULI_TB_FFT.txt', mode);
    
    for i=1:length(datainput)
        r  = real(datainput(i));
        im = imag(datainput(i));
                    
        % ======= REAL =======
        sr = sign(r);
        tr = floor(abs(r));
        if sr >= 0
            sr = '0';
        else
            sr = '1';
        end
        valr = [sr, dec2bin(tr,w)];
        fprintf(fileID,'%s\n', valr);

        % ====== IMAG ======
        sr = sign(im);
        tr = floor(abs(im));
        if sr >= 0
            sr = '0';
        else
            sr = '1';
        end
        valr = [sr, dec2bin(tr,w)];
        fprintf(fileID,'%s\n', valr);
    end
    
    fclose(fileID);
end