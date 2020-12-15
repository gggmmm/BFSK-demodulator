tic

clc
addpath(genpath('../BitReversePermutation'));
addpath(genpath('../FixedPointConverter'));

N = 64;
NumOfSamples = 2^3;

a = 5;
x = complex(randi([-a,a],NumOfSamples, 1), randi([-a,a],NumOfSamples, 1))'; % random generation of complex numbers
resfft = fft([x, zeros(56,1)']);
plot(abs(resfft));
hold on

for j=[12:-2:6]
    for k=[5]
        reszp = fft_zp_8_56(x, 1, j, k).';
        plot(abs(reszp));

        em = abs( abs(reszp) - abs(resfft) );
        es = reszp - resfft;

        %plot(em)
        [min(em), max(em)] %#ok<NOPTS>
        [min(es), max(es)] %#ok<NOPTS>
    end
end

toc