M = 8;
L = 100;
N = 64;
a = 5;

input = complex(randi([-a,a],L,1), randi([-a,a],L,1));
resSDFT = zeros(N,1);
sub     = zeros(N,1);
subAbs  = zeros(N,1);

for k=1:N
    resSDFT(k) = SDFT(input, k-1, N, M);
end

in = input(end:-1:end-(M-1));
resfft1 = fft(in, N);
resfft2 = fft(input(end-(M-1):end), N);

plot(abs(resSDFT));
% hold on
% plot(abs(resfft1));
hold on
plot(abs(resfft2));

for i=1:N
    sub(i)      = resSDFT(i) - resfft2(i);
    subAbs(i)   = abs(resSDFT(i)) - abs(resfft2(i));
end

['absolute']
max(subAbs)
['complex']
[max(abs(sub)) max(real(sub)) max(imag(sub))]