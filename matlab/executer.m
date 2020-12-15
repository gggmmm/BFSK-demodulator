function output_exec = executer(    adc_num_bit, special_mag_sync, special_mag_detec, fft_zp,...
                                    enAdc, en1, en2, en3, en4, en5, enfft, engrz, fp1f, fp1i, fpfftf, fpffti, ...
                                    fp2f, fp2i, fp3f, fp3i, fp4f, fp4i, fpgrzf, fpgrzi, fp5f, fp5i)

    reps = floor([repelem(100,8) repelem(250,6) repelem(300,8) repelem(310,8)]/1);
    ebn  = [1 2 3 4 5 6 7 8 9 9 10 10 11 11 12 12 12 12 13 13 13 13 14 14 14 14 14 14 14 14];
    numbers = unique(ebn);
    count = hist(ebn,numbers);
    
    parfor index_parfor=1:length(ebn)
            berfinal_this(index_parfor) = ssDem(adc_num_bit, ebn(index_parfor),reps(index_parfor), ...
                                                special_mag_sync, special_mag_detec, fft_zp, ...
                                                enAdc, en1, en2, en3, en4, en5, enfft, engrz, fp1f, fp1i, fpfftf, fpffti, ...
                                                fp2f, fp2i, fp3f, fp3i, fp4f, fp4i, fpgrzf, fpgrzi, fp5f, fp5i);
    end
    
    output_exec = zeros(1,14);
    
    cebn    = 9;
    start   = 9;
    add     = 2;
    for i=start:start+add-1
        output_exec(cebn) = output_exec(cebn)+berfinal_this(i);
    end
    output_exec(cebn) = output_exec(cebn)/add;
    
    cebn    = 10;
    start   = start+add;
    add     = 2;
    for i=start:start+add-1
        output_exec(cebn) = output_exec(cebn)+berfinal_this(i);
    end
    output_exec(cebn) = output_exec(cebn)/add;
    
    cebn    = 11;
    start   = start+add;
    add     = 2;
    for i=start:start+add-1
        output_exec(cebn) = output_exec(cebn)+berfinal_this(i);
    end
    output_exec(cebn) = output_exec(cebn)/add;
    
    cebn    = 12;
    start   = start+add;
    add     = 4;
    for i=start:start+add-1
        output_exec(cebn) = output_exec(cebn)+berfinal_this(i);
    end
    output_exec(cebn) = output_exec(cebn)/add;
    
    cebn    = 13;
    start   = start+add;
    add     = 4;
    for i=start:start+add-1
        output_exec(cebn) = output_exec(cebn)+berfinal_this(i);
    end
    output_exec(cebn) = output_exec(cebn)/add;
    
    cebn    = 14;
    start   = start+add;
    add     = 8;
    for i=start:start+add-1
        output_exec(cebn) = output_exec(cebn)+berfinal_this(i);
    end
    output_exec(cebn) = output_exec(cebn)/add;
    
    output_exec(1:8) = berfinal_this(1:8);
end