function writeToFileTB_SDFT_RESONATOR( datainput, f, w )
% f: number of bit for the fractionary part
% w: wordlength of the whole fixed-point
    fileID = fopen('/home/giovanni/Desktop/matlab/SDFT/s/STIMULI_TB_SDFT_RESONATOR.txt','w');

    datainput = datainput * 2^f;
    datar = real(datainput);
    datai = imag(datainput);
    for q=1:length(datainput)
        % ====      REAL PART       ====
        sr = sign(datar(q));
        tr = round(abs(datar(q)));
        if sr >= 0
            sr = '0';
        else
            sr = '1';
        end
        valr = [sr, dec2bin(tr, w)];
        fprintf(fileID,'%s\n', valr);

        % ====      IMAGINARY PART  ====
        sr = sign(datai(q));
        tr = round(abs(datai(q)));
        if sr >= 0
            sr = '0';
        else
            sr = '1';
        end
        valr = [sr, dec2bin(tr, w)];
        fprintf(fileID,'%s\n', valr);
    end
    
    fclose(fileID);
end