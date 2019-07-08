clear; clc; close;
I = im2double(imread('lena.png'));
qfactor = 50;
% 1- Convert colorspace and chroma subsampling

temp = downsampleChrominance(I);
lumi = temp(:,:,1);
cb = temp(:,:,2);
cr = temp(:,:,3);

% 2- Segmentation - Divide each channel to 8x8 blocks(minimal coding unit)

% Padding with zeros
paddedLumi = padder(lumi);
paddedCb = padder(cb);
paddedCr = padder(cr);
paddedLumi = paddedLumi - 128;
paddedCb = paddedCb - 128;
paddedCr = paddedCr - 128;
[m,n] = size(paddedLumi);

% 3- DCT of each MCU
for i = 1:8:m
    for j = 1:8:n
        blockY = paddedLumi(i:i+7, j:j+7);
        blockCb = paddedCb(i:i+7, j:j+7);
        blockCr = paddedCr(i:i+7, j:j+7);
        dctY(i:i+7, j:j+7) = fastdct2D(blockY);
        dctCb(i:i+7, j:j+7) = fastdct2D(blockCb);
        dctCr(i:i+7, j:j+7) = fastdct2D(blockCr);
    end
end

% 4- Quantization
for i = 1:8:m
    for j = 1:8:n
        tempY = dctY(i:i+7, j:j+7);
        tempCb = dctCb(i:i+7, j:j+7);
        tempCr = dctCr(i:i+7, j:j+7);
        dctQuantizedY(i:i+7, j:j+7) = quantization(tempY, qfactor, 1);
        dctQuantizedCb(i:i+7, j:j+7) = quantization(tempCb, qfactor, 0);
        dctQuantizedCr(i:i+7, j:j+7) = quantization(tempCr, qfactor, 0);        
    end
end
zY = zeros(1,64,m/8,n/8);
zCb = zeros(1,64,m/8,n/8);
zCr = zeros(1,64,m/8,n/8);

% 5- Zig-Zag Scan 
ci = 1;
for i = 1:8:m
    cj = 1;
    for j = 1:8:n
        blockY = dctQuantizedY(i:i+7, j:j+7);
        blockCb = dctQuantizedCb(i:i+7, j:j+7);
        blockCr = dctQuantizedCr(i:i+7, j:j+7);
        zY(:,:,ci,cj) = zigzag(blockY);
        zCb(:,:,ci,cj) = zigzag(blockCb);
        zCr(:,:,ci,cj) = zigzag(blockCr);
        cj = cj+1;
    end
    ci = ci+1;

end

% 6- Differential Pulse Code Modulation for DC
for i = 2:m/8
    for j = 2:n/8
        zY(1, 1, i, j) = zY(1, 1, i, j) - zY(1, 1, i-1, j);
        zCb(1, 1, i, j) = zCb(1, 1, i, j) - zCb(1, 1, i-1, j); 
        zCr(1, 1, i, j) = zCr(1, 1, i, j) - zCr(1, 1, i-1, j); 
    end
end

% 7- Run Length Coding for AC



% 8- Entropy Coding