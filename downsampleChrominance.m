function [output] = downsampleChrominance(I)

%RGB to YCbCr
Y = 0.299*I(:,:,1) + 0.587*I(:,:,2) + 0.114*I(:,:,3);
Cb = -0.1687*I(:,:,1) - 0.3313*I(:,:,2) + 0.5*I(:,:,3) + 128;
Cr = 0.5*I(:,:,1) - 0.4187*I(:,:,2) -0.0813*I(:,:,3) + 128;

%Chroma subsampling
Cb(:, 2:2:end) = Cb(:, 1:2:end-1);
Cr(:, 2:2:end) = Cr(:, 1:2:end-1);

output(:,:,1) = Y;
output(:,:,2) = Cb;
output(:,:,3) = Cr;


end

