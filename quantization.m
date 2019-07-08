function [quantized] = quantization(block,qfactor, isitLumi)
% block:(8x8x3)-YCbCr quantizedY:(8x8x1)-Y quantizedC:(8x8x2)-CbCr
% Standard qua. blocks
if isitLumi == 1
    q50 = [ 16 11 10 16 24 40 51 61;
        12 12 14 19 26 58 60 55;
        14 13 16 24 40 57 69 56;
        14 17 22 29 51 87 80 62; 
        18 22 37 56 68 109 103 77;
        24 35 55 64 81 104 113 92;
        49 64 78 87 103 121 120 101;
        72 92 95 98 112 100 103 99];
else
    q50 = [ 17 18 24 47 99 99 99 99 ;
        18 21 26 66 99 99 99 99 ;
        24 26 56 99 99 99 99 99 ;
        47 66 99 99 99 99 99 99 ;
        99 99 99 99 99 99 99 99 ;
        99 99 99 99 99 99 99 99 ;
        99 99 99 99 99 99 99 99 ;
        99 99 99 99 99 99 99 99 ];
end
if qfactor > 50
    qx = uint8(round(q50.*(ones(8)*(100-qfactor)/50)));    
elseif qfactor < 50
    qx = uint8(round(q50.*(ones(8)*(50/qfactor))));
elseif qfactor == 50
    qx = q50;
end

quantized = round(block./qx);
end

