A_img = imread('apple.jpg');
E_img = imread('eye.jpg');

imshow(E_img);
h = drawellipse('Center',[520,610],'SemiAxes',[323,178],'Color','red');
mask = createMask(h);
imwrite(mask, 'EyeMask.bmp', 'bmp');


% You Must Create this bmp in order to load it
% 1's where you want the mask to be 'on' and 0's for 'off'
M_img = imread('EyeMask.bmp');


% Convert to double
A = im2double(A_img); 
E = im2double(E_img);
M = im2double(M_img);
%display the images in a 1,2 matrix subplot
figure
subplot(1,3,1)
imshow(A)
subplot(1,3,2)
imshow(E)
subplot(1,3,3)
imshow(M)

A_GP = myGaussianPyramid(A,11); %Create pyramid of Apple
E_GP = myGaussianPyramid(E,11); %Create Pyramid of Orange
M_GP = myGaussianPyramid(M,11); %Create Pyramid of Mask 

A_LP = myLaplacianPyramid(A_GP);
E_LP = myLaplacianPyramid(E_GP);

% we want to create a Composite Laplacian Pyramid of L_LP and O_LP
% And to do this we will use the Pyramid of masks created above - M_GP.

for k = 1:length(A_LP)
    AE_LP{k} = (E_LP{k} .* M_GP{k}) + ...
        (A_LP{k} .* (1 - M_GP{k}));
end

% Now we can reconstruct this composited Laplacian Pyramid
AE_Comp = myReconFromPyramid(AE_LP);

figure(4)
subplot(1,3,1)
imshow(A_img)
subplot(1,3,2)
imshow(E_img)
subplot(1,3,3)
imshow(AE_Comp{1})

