N = 10 %Samples

t1 = N / 48000;

f0 = 10000;
f1 = 12000;

t = linspace(0, t1, N);

y = chirp(t,f0,t1,f1) ./ N

y_hex = hex(fi(y, 1, 16, 15))