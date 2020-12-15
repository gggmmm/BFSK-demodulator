tic

special_mag_sync    = 0;
special_mag_detec   = 0;
fft_zp              = 0;

enAdc   = 1;
en1     = 0;
enfft   = 0;
en2     = 0;
en3     = 0;
en4     = 0;
engrz   = 0;
en5     = 0;

fp1f   = 4; fpfftf = 7; fp2f   = 3;  fp3f   = 3; fp4f   = 1; fpgrzf = 5; fp5f   = 3;
fp1i   = 4; fpffti = 5; fp2i   = 10; fp3i   = 7; fp4i   = 7; fpgrzi = 7; fp5i   = 7;


if isempty(who('reference_ber')) %plot the theoretical curve only once
    figure('name','Whole system comparison');
    reference_ber = [0.36428    0.30752     0.23929     0.17286     0.11792     0.076568    0.045705 ...
                     0.024046   0.010676    0.003895    0.0010839   0.0002173   2.8429e-05  1.9881e-06];
    semilogy(1:14, reference_ber,'LineWidth',2.0,'DisplayName','reference');
    xlabel('E_b/N_0 [dB]');
    ylabel('BER');
    hold on;
end

for i=[4 5 6 7 8]
    [repelem(i,20)]

    tic

    berfinalbck = executer( i, special_mag_sync, special_mag_detec, fft_zp,            ...
                            enAdc, en1, en2, en3, en4, en5, enfft, engrz,                  ...
                            fp1f, fp1i, fpfftf, fpffti,                 ...
                            fp2f, fp2i, fp3f, fp3i, fp4f, fp4i,   ...
                            fpgrzf, fpgrzi, fp5f, fp5i);
    toc

    s = string(i);
    semilogy(1:14, berfinalbck,'LineWidth',1.4,'DisplayName',s);
end

load gong.mat;
sound(y(1:1500));

toc