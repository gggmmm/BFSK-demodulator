tic

special_mag_sync    = 1;
special_mag_detec   = 0;
fft_zp              = 1;

en1 = 1;
enfft = 1;
en2 = 1;
en3 = 0;
en4 = 0;
engrz = 0;
en5 = 0;

ADCbit = 8;
enADC = 1;

fp1f = 4;
fp1i = 4;
fpfftf = 7;
fpffti= 5;
fp2f = 0;
fp2i = 0;
fp3f = 0;
fp3i = 0;
fp4f = 0;
fp4i = 0;
fpgrzf = 0;
fpgrzi = 0;
fp5f = 0;
fp5i= 0;

if isempty(who('reference_ber')) %plot the theoretical curve only once
    figure('name','Magnitude sync comparison');
    reference_ber = [0.36428    0.30752     0.23929     0.17286     0.11792     0.076568    0.045705 ...
                     0.024046   0.010676    0.003895    0.0010839   0.0002173   2.8429e-05  1.9881e-06];
    semilogy(1:14, reference_ber,'LineWidth',2.0,'DisplayName','reference');
    xlabel('E_b/N_0 [dB]');
    ylabel('BER');
    hold on;
end

integer_part    = [6:11];
fractional_part = [0:4];

for i=1:length(integer_part)
    [integer_part(i) fractional_part(i)]

    fp2f = fractional_part(i);
    fp2i = integer_part(i);

    tic

    berfinalbck = executer( ADCbit, special_mag_sync, special_mag_detec, fft_zp,    ...
                            enADC, en1, en2, en3, en4, en5, enfft, engrz,           ...
                            fp1f, fp1i, fpfftf, fpffti,                             ...
                            fp2f, fp2i, fp3f, fp3i, fp4f, fp4i,                     ...
                            fpgrzf, fpgrzi, fp5f, fp5i);
    toc

    s = string(string(integer_part(i))+"|"+string(fractional_part(i)));
    semilogy(1:14, berfinalbck,'LineWidth',1.4,'DisplayName',s);
end

load gong.mat;
sound(y(1:1500));

toc