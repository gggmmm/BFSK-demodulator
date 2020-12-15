function writeToFileTB_EOA( datainput, w, f, qmax, jmax, kmax, imax )
% f: number of bit for the fractionary part
% w: wordlength of the whole fixed-point
    datainput = datainput*(2^f);
    
    fileID = fopen('/home/giovanni/Desktop/matlab/STIMULI_TB_EOA.txt','w');
    
    for q=1:qmax
        for j=1:jmax
            for k=1:kmax
                for i=1:imax
                    r_t = real(datainput(q,j,k,i,:));
                    im_t = imag(datainput(q,j,k,i,:));
                    
                    for z=1:length(r_t) % should be 8 anyway
                        sr = sign(r_t(z));
                        tr = floor(abs(r_t(z)));
                        if sr >= 0
                            sr = '0';
                        else
                            sr = '1';
                        end
                        valr = [sr, dec2bin(tr,w)];
                        fprintf(fileID,'%s\n', valr);

                        sr = sign(im_t(z));
                        tr = floor(abs(im_t(z)));
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