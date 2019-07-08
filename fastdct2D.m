function [output] = fastdct2D(block)
temp = zeros(8,8);
output = zeros(8,8);
for i=1:8
    temp(i,:) = fastdct8(block(i,:));
end
for i=1:8
    output(:,i) = fastdct8(temp(:,i));
end
end


%TODO: 
