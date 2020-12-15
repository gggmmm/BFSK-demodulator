function writeToFileTB_DATA_DETECTION( iH, iL, datainput, index_width, w, f)
% f: number of bit for the fractionary part
% w: wordlength of the whole fixed-point
% index_width: number of bit to represent the index
        
    dim = size(datainput);
    datainput = datainput*2^f;
    fileID = fopen('/home/giovanni/Desktop/matlab/STIMULI_TB_DATA_DETECTION.txt','w');
    
    for q=1:dim(1)
        for j=1:dim(2)
            ['writing data detection']
            [q j]
            
            index = dec2bin(iH(q,j), index_width);
            fprintf(fileID,'%s\n', index);
            
            index = dec2bin(iL(q,j), index_width);
            fprintf(fileID,'%s\n', index);
            
            for i=1:dim(3)                
                r_t     = squeeze( real(datainput(q,j,i,:)) );
                im_t    = squeeze( imag(datainput(q,j,i,:)) );
                
                for l=1:8
                    % ====      REAL PART       ====
                    sr = sign(r_t(l));
                    tr = round(abs(r_t(l)));
                    if sr >= 0
                        sr = '0';
                    else
                        sr = '1';
                    end
                    valr = [sr, dec2bin(tr,w)];
                    fprintf(fileID,'%s\n', valr);
                    
                    % ====      IMAGINARY PART  ====
                    sr = sign(im_t(l));
                    tr = round(abs(im_t(l)));
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
    
    fclose(fileID);
end