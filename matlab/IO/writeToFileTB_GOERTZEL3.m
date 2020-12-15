function writeToFileTB_GOERTZEL3( datainput, w, f, om )
% f: number of bit for the fractionary part
% w: wordlength of the whole fixed-point
% om: opening mode https://nl.mathworks.com/help/matlab/ref/fopen.html#btrnibn-1-permission

    datainput = datainput*(2^f);
    
    fileID = fopen('/home/giovanni/Desktop/matlab/STIMULI_TB_GOERTZEL3.txt', om);
    
    r_t     = real(datainput);
    im_t    = imag(datainput);

    for l=1:length(datainput)
        sr = sign(r_t(l));
        tr = floor(abs(r_t(l)));
        if sr >= 0
            sr = '0';
        else
            sr = '1';
        end
        valr = [sr, dec2bin(tr,w)];
        fprintf(fileID,'%s\n', valr);

        sr = sign(im_t(l));
        tr = floor(abs(im_t(l)));
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