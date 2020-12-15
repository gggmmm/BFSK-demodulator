function writeToFileTB_PREAMBLE_DETECTOR( datainput, w, f, qmax, jmax, kmax, imax )
    datainput = datainput*(2^f);    
    
    fileID = fopen('/home/giovanni/Desktop/matlab/STIMULI_TB_PREAMBLE_DETECTOR.txt','w');
    
    for q=1:qmax
        for j=1:jmax
            ['w PD']
            [q j]
            
            for k=1:kmax
                for i=1:imax
                    r  = real(datainput(q, j, k, i, :));
                    im = imag(datainput(q, j, k, i, :));
                    
                    for l=1:8
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
        end
    end
    
    fclose(fileID);
end