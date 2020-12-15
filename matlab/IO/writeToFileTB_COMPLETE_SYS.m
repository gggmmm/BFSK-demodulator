function writeToFileTB_COMPLETE_SYS( datainput, w_fft, f_fft, w_grz, f_grz, qmax, jmax, ImposedDelay, USE_MULTIPLE_TESTBENCHES )
% f: number of bit for the fractionary part
% w: wordlength of the whole fixed-point
    if USE_MULTIPLE_TESTBENCHES==0
        fileID = fopen('/home/giovanni/Desktop/matlab/STIMULI_TB_COMPLETE_SYS.txt','w');
    end

    for q=1:qmax
        for j=1:jmax
            ['w COMPLETE SYS']
            [q j]
            
            if USE_MULTIPLE_TESTBENCHES==1
                filename = "/home/giovanni/Desktop/matlab/vunit_tb_demodultor/STIMULI_TB_COMPLETE_SYS_q"+q+"j"+j+".txt";
                fileID = fopen(filename,'w');
            end
            
            preamble    = squeeze( datainput(q, j, 1:119) )   * 2^f_fft;
            payload     = squeeze( datainput(q, j, 120:end-2*8) ) * 2^f_grz;
            
            data = [preamble.', payload.'];
            datar = real( data );
            datai = imag( data );
            
            for l=1:length(datar)
                % ====      REAL PART       ====
                sr = sign(datar(l));
                tr = round(abs(datar(l)));
                if sr >= 0
                    sr = '0';
                else
                    sr = '1';
                end
                valr = [sr, dec2bin(tr, w_fft)];
                fprintf(fileID,'%s\n', valr);

                % ====      IMAGINARY PART  ====
                sr = sign(datai(l));
                tr = round(abs(datai(l)));
                if sr >= 0
                    sr = '0';
                else
                    sr = '1';
                end
                valr = [sr, dec2bin(tr, w_fft)];
                fprintf(fileID,'%s\n', valr);
            end
            
            if USE_MULTIPLE_TESTBENCHES==1
                fclose(fileID);
            end
        end
    end
    
    if USE_MULTIPLE_TESTBENCHES==0
        fclose(fileID);
    end
end