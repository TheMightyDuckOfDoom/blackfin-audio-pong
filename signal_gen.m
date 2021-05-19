f = @(x) sin(x) ./ x

N = 10
x = linspace(-2,2,N)

sig = f(x) ./ N

x_d = [0,0,0,0,0,0,0,0,0,sig * 0.5,00,0,0,0,0,0,0,0,0,0,0,0,0,0,sig]

[r, l] = xcorr(sig, x_d)

