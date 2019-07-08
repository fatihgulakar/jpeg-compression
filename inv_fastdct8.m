function [output] = inv_fastdct8(vector)
v15 = vector(1) / 0.353553390593273762200422;
v26 = vector(2) / 0.254897789552079584470970;
v21 = vector(3) / 0.270598050073098492199862;
v28 = vector(4) / 0.300672443467522640271861;
v16 = vector(5) / 0.353553390593273762200422;
v25 = vector(6) / 0.449988111568207852319255;
v22 = vector(7) / 0.653281482438188263928322;
v27 = vector(8) / 1.281457723870753089398043;

v19 = (v25 - v28) / 2;
v20 = (v26 - v27) / 2;
v23 = (v26 + v27) / 2;
v24 = (v25 + v28) / 2;

v7  = (v23 + v24) / 2;
v11 = (v21 + v22) / 2;
v13 = (v23 - v24) / 2;
v17 = (v21 - v22) / 2;

v8 = (v15 + v16) / 2;
v9 = (v15 - v16) / 2;

v18 = (v19 - v20) * 0.382683432365089771728460;
v12 = (v19 * 1.306562964876376527856643 - v18) / (0.541196100146196984399723 * 0.382683432365089771728460 - 0.541196100146196984399723 * 1.306562964876376527856643 - 1.306562964876376527856643 * 0.382683432365089771728460);
v14 = (v18 - v20 * 0.541196100146196984399723) / (0.541196100146196984399723 * 0.382683432365089771728460 - 0.541196100146196984399723 * 1.306562964876376527856643 - 1.306562964876376527856643 * 0.382683432365089771728460);

v6 = v14 - v7;
v5 = v13 / 0.707106781186547524400844 - v6;
v4 = -v5 - v12;
v10 = v17 / 0.707106781186547524400844 - v11;

v0 = (v8 + v11) / 2;
v1 = (v9 + v10) / 2;
v2 = (v9 - v10) / 2;
v3 = (v8 - v11) / 2;

output = [(v0 + v7) / 2, (v1 + v6) / 2, (v2 + v5) / 2, (v3 + v4) / 2, ...
          (v3 - v4) / 2, (v2 - v5) / 2, (v1 - v6) / 2, (v0 - v7) / 2];
end
