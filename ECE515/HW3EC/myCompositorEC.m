% Burt and Adelson Pyramid Compositing
%
% Atanas Delevski Extra Credit Component of ECE 515 HW#3
%   3/3/2020
%   

clear all

S_img = imread('shark.jpg');
S_img = imresize(S_img, [1024, 1024]);
B_img = imread('bmw.jpg');
B_img = imresize(B_img, [1024, 1024]);
% Convert to double
S = im2double(S_img); 
B = im2double(B_img);
% display the images in a 1,2 matrix subplot
figure(1)
% subplot(1,2,1)
imshow(S)
% subplot(1,2,2)
% imshow(B)

h = drawellipse('Center',[512,512],'SemiAxes',[600,150],'Color','red');
% % 145,185,899,302
% % 137,174,903,318
mask = createMask(h);
figure
imshow(mask)


S_GP = myGaussianPyramid(S,11); %Create pyramid of Shark
B_GP = myGaussianPyramid(B,11); %Create Pyramid of BMW
M_GP = myGaussianPyramid(mask,11); %Create Pyramid of Mask 

S_LP = myLaplacianPyramid(S_GP);
B_LP = myLaplacianPyramid(B_GP);


for k = 1:length(S_LP)
    SB_LP{k} = (B_LP{k} .* M_GP{k}) + ...
        (S_LP{k} .* (1 - M_GP{k}));
end

SB_Comp = myReconFromPyramid(SB_LP);

figure
subplot(1,3,1)
imshow(S_img)
subplot(1,3,2)
imshow(B_img)
subplot(1,3,3)
imshow(SB_Comp{1})
