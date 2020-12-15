function datadetected = readFromFileTB_COMPLETE_SYS( qmax, jmax, dim, USE_MULTIPLE_TESTBENCHES )
    if USE_MULTIPLE_TESTBENCHES==0
        fileID = fopen('/home/giovanni/Desktop/matlab/RESULTS_TB_COMPLETE_SYS.txt','r');
    end
    datadetected = zeros(qmax, jmax);
    
    for q=1:qmax
        for j=1:jmax
            ['r COMPLETE SYS']
            [q j]
            
            if USE_MULTIPLE_TESTBENCHES==1
                filename = "/home/giovanni/Desktop/matlab/vunit_tb_demodultor/RESULTS_TB_COMPLETE_SYS_q"+q+"j"+j+".txt";
                fileID = fopen(filename,'r');
            end
            
            for i=1:dim
                y = fgetl(fileID);
                if y=='1'
                    datadetected(q, j, i) = 1;
                elseif y=='0'
                    datadetected(q, j, i) = 0;
                else
                    ['ERROR READING COMPLETE SYS'];
                end
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