function writeToFileTB_DD_DATA_ACQUISITION( datainput, w, f, qmax, jmax, ImposedDelay )
% f: number of bit for the fractionary part
% w: wordlength of the whole fixed-point
    datainput = datainput*2^f;
    fileID = fopen('/home/giovanni/Desktop/matlab/STIMULI_TB_DD_DATA_ACQUISITION.txt','w');

    for q=1:qmax
        for j=1:jmax
            ['w DD ACQUISITION']
            [q j]
            
            datar = real( datainput(q, j, 120:end-2*8+ImposedDelay) );
            datai = imag( datainput(q, j, 120:end-2*8+ImposedDelay) );
            dim = length(datar);
            
            for l=1:dim
                % ====      REAL PART       ====
                sr = sign(datar(l));
                tr = round(abs(datar(l)));
                if sr >= 0
                    sr = '0';
                else
                    sr = '1';
                end
                valr = [sr, dec2bin(tr ,w)];
                fprintf(fileID,'%s\n', valr);

                % ====      IMAGINARY PART  ====
                sr = sign(datai(l));
                tr = round(abs(datai(l)));
                if sr >= 0
                    sr = '0';
                else
                    sr = '1';
                end
                valr = [sr, dec2bin(tr, w)];
                fprintf(fileID,'%s\n', valr);
            end
        end
    end
    fclose(fileID);
end