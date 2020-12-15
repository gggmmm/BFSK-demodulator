function writeToFileTB_PD_DATA_ACQUISITION( datainput, w, f, qmax, jmax )
    datainput = datainput*(2^f);    
    
    fileID = fopen('/home/giovanni/Desktop/matlab/STIMULI_TB_PD_DATA_ACQUISITION.txt','w');
    
    for q=1:qmax
        for j=1:jmax
            ['w DATA ACQUISITION']
            [q j]
            
            r  = real(datainput(q, j, :));
            im = imag(datainput(q, j, :));
            dim = length(r);
            
            for l=1:dim
                % ======= REAL =======
                sr = sign(r( l ));
                tr = floor(abs(r( l )));
                if sr >= 0
                    sr = '0';
                else
                    sr = '1';
                end
                valr = [sr, dec2bin(tr,w)];
                fprintf(fileID,'%s\n', valr);

                % ====== IMAG ======
                sr = sign(im( l ));
                tr = floor(abs(im( l )));
                if sr >= 0
                    sr = '0';
                else
                    sr = '1';
                end
                valr = [sr, dec2bin(tr,w)];
                fprintf(fileID,'%s\n', valr);
            end
        end
    end
    
    fclose(fileID);
end