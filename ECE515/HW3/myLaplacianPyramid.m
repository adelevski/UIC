
function A_LP = myLaplacianPyramid(A_GP)


% Set up the Laplacian Pyramid to be the same cell size
A_LP = cell(size(A_GP));
% Set the number of levels to be the number of elements
num_levels = numel(A_GP);
% Initialize the first Laplacian to be the same as A_GP
A_LP{num_levels} = A_GP{num_levels};
for k = 1:(num_levels-1)
   % Compute each iteration
   A_LP{k}= A_GP{k} - imresize(A_GP{k+1}, 2, 'lanczos3');
   
end

end

