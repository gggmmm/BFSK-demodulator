tic

special_mag_sync    = 0;
special_mag_detec   = 0;
fft_zp              = 0;

adcBit  = 8;

enAdc   = 0;
en1     = 0;
enfft   = 0;
en2     = 0;
en3     = 0;
en4     = 0;
engrz   = 0;
en5     = 0;

% % RUN 1 -- smallest values at 28/9
fp1f(1)   = 4; fpfftf(1) = 7; fp2f(1)   = 2;  fp3f(1)   = 2; fp4f(1)   = 0; fpgrzf(1) = 5; fp5f(1)   = 2;
fp1i(1)   = 4; fpffti(1) = 5; fp2i(1)   = 7;  fp3i(1)   = 6; fp4i(1)   = 7; fpgrzi(1) = 7; fp5i(1)   = 6;
num_of_bit(1) = 64
% 
% %RUN 2 
% fp1f(2)   = 4; fpfftf(2) = 7; fp2f(2)   = 3;  fp3f(2)   = 2; fp4f(2)   = 0; fpgrzf(2) = 5; fp5f(2)   = 2;
% fp1i(2)   = 4; fpffti(2) = 5; fp2i(2)   = 8;  fp3i(2)   = 6; fp4i(2)   = 7; fpgrzi(2) = 7; fp5i(2)   = 6;
% %num_of_bit(2) = 66
% 
% %RUN 3
% fp1f(3)   = 4; fpfftf(3) = 7; fp2f(3)   = 3;  fp3f(3)   = 2; fp4f(3)   = 0; fpgrzf(3) = 5; fp5f(3)   = 2;
% fp1i(3)   = 4; fpffti(3) = 5; fp2i(3)   = 9;  fp3i(3)   = 7; fp4i(3)   = 7; fpgrzi(3) = 7; fp5i(3)   = 6;
% %num_of_bit(3) = 68
% 
% %RUN 4 
% fp1f(4)   = 4; fpfftf(4) = 7; fp2f(4)   = 3;   fp3f(4)   = 3; fp4f(4)   = 0; fpgrzf(4) = 5; fp5f(4)   = 2;
% fp1i(4)   = 4; fpffti(4) = 5; fp2i(4)   = 10;  fp3i(4)   = 7; fp4i(4)   = 7; fpgrzi(4) = 7; fp5i(4)   = 6;
% %num_of_bit(4) = 70
% 
% %RUN 5
% fp1f(5)   = 4; fpfftf(5) = 7; fp2f(5)   = 3;   fp3f(5)   = 3; fp4f(5)   = 0; fpgrzf(5) = 5; fp5f(5)   = 3;
% fp1i(5)   = 4; fpffti(5) = 5; fp2i(5)   = 10;  fp3i(5)   = 7; fp4i(5)   = 7; fpgrzi(5) = 7; fp5i(5)   = 7;
% %num_of_bit(5) = 72
% 
% %RUN 6
% fp1f(6)   = 4; fpfftf(6) = 7; fp2f(6)   = 3;   fp3f(6)   = 3; fp4f(6)   = 1; fpgrzf(6) = 5; fp5f(6)   = 3;
% fp1i(6)   = 4; fpffti(6) = 5; fp2i(6)   = 11;  fp3i(6)   = 7; fp4i(6)   = 7; fpgrzi(6) = 7; fp5i(6)   = 7;
% %num_of_bit(6) = 74
% 
% %RUN 7
% fp1f(7)   = 4; fpfftf(7) = 7; fp2f(7)   = 3;   fp3f(7)   = 3; fp4f(7)   = 2; fpgrzf(7) = 5; fp5f(7)   = 3;
% fp1i(7)   = 4; fpffti(7) = 5; fp2i(7)   = 11;  fp3i(7)   = 7; fp4i(7)   = 7; fpgrzi(7) = 7; fp5i(7)   = 7;
% %num_of_bit(7) = 75
% 
% %RUN 8
% fp1f(8)   = 4; fpfftf(8) = 7; fp2f(8)   = 5;   fp3f(8)   = 3; fp4f(8)   = 2; fpgrzf(8) = 5; fp5f(8)   = 4;
% fp1i(8)   = 4; fpffti(8) = 5; fp2i(8)   = 11;  fp3i(8)   = 7; fp4i(8)   = 7; fpgrzi(8) = 7; fp5i(8)   = 7;
% %num_of_bit(8) = 78
% 
% %RUN 9
% fp1f(9)   = 4; fpfftf(9) = 7; fp2f(9)   = 5;   fp3f(9)   = 4; fp4f(9)   = 2; fpgrzf(9) = 5; fp5f(9)   = 4;
% fp1i(9)   = 4; fpffti(9) = 5; fp2i(9)   = 11;  fp3i(9)   = 8; fp4i(9)   = 7; fpgrzi(9) = 7; fp5i(9)   = 7;
% %num_of_bit(9) = 80
% 
% %RUN 10
% fp1f(10)   = 4; fpfftf(10) = 7; fp2f(10)   = 7;   fp3f(10)   = 4; fp4f(10)   = 2; fpgrzf(10) = 5; fp5f(10)   = 4;
% fp1i(10)   = 4; fpffti(10) = 5; fp2i(10)   = 11;  fp3i(10)   = 8; fp4i(10)   = 7; fpgrzi(10) = 7; fp5i(10)   = 7;
% %num_of_bit(10) = 82
% 
% %RUN 11
% fp1f(11)   = 4; fpfftf(11) = 7; fp2f(11)   = 0;   fp3f(11)   = 0; fp4f(11)   = 0; fpgrzf(11) = 5; fp5f(11)   = 0;
% fp1i(11)   = 4; fpffti(11) = 5; fp2i(11)   = 11;  fp3i(11)   = 8; fp4i(11)   = 7; fpgrzi(11) = 7; fp5i(11)   = 7;
% %num_of_bit(11) = 65
% 
% %RUN 12
% fp1f(12)   = 4; fpfftf(12) = 7; fp2f(12)   = 12;   fp3f(12)   = 10; fp4f(12)   = 10; fpgrzf(12) = 5; fp5f(12)   = 10;
% fp1i(12)   = 4; fpffti(12) = 5; fp2i(12)   = 12;  fp3i(12)   = 10; fp4i(12)   = 10; fpgrzi(12) = 7; fp5i(12)   = 10;
% %num_of_bit(12) = 116
% 
% %RUN 13
% fp1f(13)   = 5; fpfftf(13) = 7; fp2f(13)   = 7;   fp3f(13)   = 4; fp4f(13)   = 2; fpgrzf(13) = 5; fp5f(13)   = 4;
% fp1i(13)   = 3; fpffti(13) = 5; fp2i(13)   = 11;  fp3i(13)   = 8; fp4i(13)   = 7; fpgrzi(13) = 7; fp5i(13)   = 7;
% %num_of_bit(13) = 82

% %RUN 14
% fp1f(1)   = 4; fpfftf(1) = 7; fp2f(1)   = 5;   fp3f(1)   = 5; fp4f(1)   = 5; fpgrzf(1) = 5; fp5f(1)   = 5;
% fp1i(1)   = 4; fpffti(1) = 5; fp2i(1)   = 12;  fp3i(1)   = 10; fp4i(1)   = 10; fpgrzi(1) = 7; fp5i(1)   = 10;
% num_of_bit(1) = 94;

% %RUN 15
% fp1f(2)   = 4; fpfftf(2) = 7; fp2f(2)   = 5;   fp3f(2)   = 5; fp4f(2)   = 5; fpgrzf(2) = 5; fp5f(2)   = 5;
% fp1i(2)   = 4; fpffti(2) = 5; fp2i(2)   = 10;  fp3i(2)   = 8; fp4i(2)   = 9; fpgrzi(2) = 7; fp5i(2)   = 8;
% num_of_bit(2) = 87;

% %RUN 16
% fp1f(2)   = 4; fpfftf(2) = 7; fp2f(2)   = 5;   fp3f(2)   = 5; fp4f(2)   = 5; fpgrzf(2) = 5; fp5f(2)   = 5;
% fp1i(2)   = 4; fpffti(2) = 5; fp2i(2)   = 9;  fp3i(2)   = 8; fp4i(2)   = 9; fpgrzi(2) = 7; fp5i(2)   = 8;
% num_of_bit(2) = 94;

% %RUN 17
% fp1f(1)   = 4; fpfftf(1) = 7; fp2f(1)   = 3;  fp3f(1)   = 3; fp4f(1)   = 2; fpgrzf(1) = 5; fp5f(1)   = 3;
% fp1i(1)   = 4; fpffti(1) = 5; fp2i(1)   = 9;  fp3i(1)   = 8; fp4i(1)   = 9; fpgrzi(1) = 7; fp5i(1)   = 8;
% num_of_bit(1) = 77;

% %RUN 18
% fp1f(1)   = 4; fpfftf(1) = 7; fp2f(1)   = 3;  fp3f(1)   = 3; fp4f(1)   = 1; fpgrzf(1) = 5; fp5f(1)   = 2;
% fp1i(1)   = 4; fpffti(1) = 5; fp2i(1)   = 9;  fp3i(1)   = 8; fp4i(1)   = 8; fpgrzi(1) = 7; fp5i(1)   = 7;
% num_of_bit(1) = 73;

% %RUN 19
% fp1f(1)   = 4; fpfftf(1) = 7; fp2f(1)   = 3;  fp3f(1)   = 3; fp4f(1)   = 1; fpgrzf(1) = 5; fp5f(1)   = 2;
% fp1i(1)   = 4; fpffti(1) = 5; fp2i(1)   = 9;  fp3i(1)   = 8; fp4i(1)   = 9; fpgrzi(1) = 7; fp5i(1)   = 8;
% num_of_bit(1) = 75;

%RUN 20
% fp1f(1)   = 4; fpfftf(1) = 7; fp2f(1)   = 3;  fp3f(1)   = 3; fp4f(1)   = 1; fpgrzf(1) = 5; fp5f(1)   = 2;
% fp1i(1)   = 4; fpffti(1) = 5; fp2i(1)   = 8;  fp3i(1)   = 7; fp4i(1)   = 9; fpgrzi(1) = 7; fp5i(1)   = 8;
% num_of_bit(1) = 73;

%RUN 21
% fp1f(2)   = 4; fpfftf(2) = 7; fp2f(2)   = 2;  fp3f(2)   = 2; fp4f(2)   = 1; fpgrzf(2) = 5; fp5f(2)   = 2;
% fp1i(2)   = 4; fpffti(2) = 5; fp2i(2)   = 9;  fp3i(2)   = 8; fp4i(2)   = 9; fpgrzi(2) = 7; fp5i(2)   = 8;
% num_of_bit(2) = 73;

if isempty(who('reference_ber')) %plot the theoretical curve only once
    figure('name','Whole system comparison');
    reference_ber = [0.36428    0.30752     0.23929     0.17286     0.11792     0.076568    0.045705 ...
                     0.024046   0.010676    0.003895    0.0010839   0.0002173   2.8429e-05  1.9881e-06];
    semilogy(1:14, reference_ber,'LineWidth',2.0,'DisplayName','reference');
    xlabel('E_b/N_0 [dB]');
    ylabel('BER');
    hold on;
end

for i=1:length(fp1f)
    [repelem(i,20)]

    tic

    berfinalbck = executer( adcBit, special_mag_sync, special_mag_detec, fft_zp,            ...
                            enAdc, en1, en2, en3, en4, en5, enfft, engrz,                  ...
                            fp1f(i), fp1i(i), fpfftf(i), fpffti(i),                 ...
                            fp2f(i), fp2i(i), fp3f(i), fp3i(i), fp4f(i), fp4i(i),   ...
                            fpgrzf(i), fpgrzi(i), fp5f(i), fp5i(i));
    toc

    s = "RUN "+string(i)+" - "+string(num_of_bit(i))+" bit";
    semilogy(1:14, berfinalbck,'LineWidth',1.4,'DisplayName',s);
end

load gong.mat;
sound(y(1:1500));

toc