function recon = myReconFromPyramid(A_LP)

recon = cell(size(A_LP));
% Set the number of levels to be the number of elements
num_levels = numel(A_LP);
% Set first iteration of reconstructed output to highest Laplacian
recon{num_levels} = A_LP{num_levels};
% Now iterate through each level
for k = (num_levels - 1) : -1 : 1
   recon{k} = A_LP{k} + imresize(recon{k+1}, 2, 'lanczos3');
end
end