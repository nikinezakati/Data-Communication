
%3.1
[y, Fs] = audioread('name.wav');

N = size(y); % sound size
disp(N)

player = audioplayer(y,Fs);

play(player);

audiowrite('handle.wav',y,Fs);

l=length(y)  %speed

t=l/Fs      %time

%3.2.

zeronois = awgn(y,0)
audiowrite('zero_noise.wav',zeronois,Fs);

tennois = awgn(y,10)
audiowrite('ten_noise.wav',tennois,Fs);


b = fir1(800, .2); 
zero_denoise = filter(b, 1, zeronois); 
audiowrite('zero_denoise.wav',zero_denoise,Fs);

b = fir1(800, .2); 
ten_denoise = filter(b, 1, tennois); 
audiowrite('ten_denoise.wav',ten_denoise,Fs);

[x, fsx] = audioread('name.wav');   % load an audio file
[y, fsy] = audioread('zero_denoise.wav');   % load an audio file

x = x(:, 1);      % get the first channel
y = y(:, 1);      % get the first channel
nx = length(x);   % signal length
ny = length(y);   % signal length
yPad  = y;
yCrop = y;
xPad  = x;
xCrop = x;
if nx > ny
    yPad(nx) = 0;
    xCrop    = xCrop(1:ny);
elseif nx < ny
    xPad(ny) = 0;
    yCrop    = yCrop(1:nx);
end
c1 = corrcoef(xPad, yPad);
c2 = corrcoef(xCrop, yCrop);


[z, fsz] = audioread('ten_denoise.wav');   % load an audio file

x = x(:, 1);      % get the first channel
z = z(:, 1);      % get the first channel
nx = length(x);   % signal length
nz = length(z);   % signal length
zPad  = z;
zCrop = z;
xPad  = x;
xCrop = x;
if nx > nz
    zPad(nx) = 0;
    xCrop    = xCrop(1:nz);
elseif nx < nz
    xPad(nz) = 0;
    zCrop    = zCrop(1:nx);
end
c1 = corrcoef(xPad, zPad);
c2 = corrcoef(xCrop, zCrop);


%3.3.
symbols=unique(y);
bins = hist(y,symbols)
p=bins/length(y)
dict = huffmandict(symbols,p);
code = huffmanenco(y,dict);

sig = huffmandeco(code,dict);
isequal(y,sig)

audiowrite('handle_code.wav',code,Fs);


