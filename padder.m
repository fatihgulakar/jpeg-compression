function [padded] = padder(image)

% Function applies zero padding in case dimensions of the image
% is not divisible to 8.

s = size(image);
rowRemainder = rem(s(1), 8);
colRemainder = rem(s(2), 8);

if(rowRemainder == 0)
    r = 0;
else
    r = 8 - rowRemainder;
end

if(colRemainder == 0)
    c = 0;
else
    c = 8 - colRemainder;
end

padded = zeros(s(1) + r, s(2) + c);
padded(1:s(1), 1:s(2)) = image;
