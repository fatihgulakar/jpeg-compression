function [z] = zigzag(M)
ind = reshape(1:numel(M), size(M));
ind = fliplr(spdiags(fliplr(ind)));
ind(:,1:2:end) = flipud( ind(:,1:2:end) );
ind(ind==0) = [];
z = M(ind);
end

