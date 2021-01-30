function A_GP = myGaussianPyramid(A,num_levels)

% Big assumptions
% Input image is a power of 2!
% We will not handle special cases!
% We will not follow Burt and Adelson completely.
%

A_GP{1} = A; % Set lowest level of pyramid equal to original image
for k = 2:num_levels
    % Set next higher level to a filtered and downsampled version
    % Then store these iteratively into cells
    A_GP{k} = imresize(A_GP{k-1}, 0.5, 'lanczos3');
end

end
