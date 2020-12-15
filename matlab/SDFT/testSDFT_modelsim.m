M = 8;
L = 119;
N = 64;
a = 2;
f = 7;
w = 12;

wr = 1; % 0 write, 1 read

input = complex(randi([-a,a],L,1), randi([-a,a],L,1));

if wr==0
    writeToFileTB_SDFT_RESONATOR(input, f, w);
    res = fft(input(end-(M-1):end), N);
    plot(abs(res));
    hold on;
else
    o = readFromFileTB_SDFT_RESONATOR(N, f);
    plot(abs(o));
end