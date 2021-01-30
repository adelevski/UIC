% Burt and Adelson Pyramid Compositing
clear all
%Load Apple and Orange Images ... known to be 1024x1024
A_img = imread('apple.jpg');
O_img = imread('orange.jpg');
% Convert to double
A = im2double(A_img); 
O = im2double(O_img);
%display the images in a 1,2 matrix subplot
% figure(1)
% subplot(1,2,1)
% imshow(A)
% subplot(1,2,2)
% imshow(O)




%     Create a binary mask  1's mean 'On' and 0's mean 'Off'
% M_L Should be a 1024x1024 Matrix with 1's on the left half and 0's on the
% right half

M_L = zeros(1024, 1024);
M_L(:,1:512) = 1;

%M_R should be 1024x1024 Matrix with 0's on the left half and 1's on the
%right half

M_R = zeros(1024, 1024);
M_R(:,513:1024) = 1; 

% Above, M is now a image of half ones and half zeros
figure(2)
subplot(1,3,1)
imshow(M_L) % Mask for left side of image 
xticks([])
yticks([])
axis on
subplot(1,3,2)
imshow(M_R) %Inverse mask - mask for right side of image
xticks([])
yticks([])
axis on
%%%%%  YOUR CODE FOR SIMPLE COMPOSITING GOES HERE %%%%%%
%%%%  Apple on the left and Orange on the right
%%%%% Simple_Comp =  Apple on the left and Orange on the right
%%%%% by using A, O, M_R, and M_L

Simple_Comp = A.*M_L + O.*M_R;

% Show the simple/crude composited image
subplot(1,3,3)
imshow(Simple_Comp)
xticks([])
yticks([])
axis on



% Next, we look at feathering


% Feather the transition over 120 pixels in the center
M_L_feath = zeros(1024, 1024);  
M_L_feath(:,1:512) = 1;
gradiant  = 1/120;
for i=1:1024
    row_var = 1;
    for j=452:572
        row_var = row_var - gradiant;
        M_L_feath(i, j) = row_var;
    end
end

M_R_feath = zeros(1024, 1024);  
M_R_feath(:,513:1024) = 1; 
gradiant  = 1/120;
for i=1:1024
    row_var = 0;
    for j=452:572
        row_var = row_var + gradiant;
        M_R_feath(i, j) = row_var;
    end
end

figure(3)
subplot(1,3,1)
imshow(M_L_feath);
xticks([])
yticks([])
axis on

subplot(1,3,2)
imshow(M_R_feath);
xticks([])
yticks([])
axis on

Feather_Comp = A.*M_L_feath + O.*M_R_feath;

subplot(1,3,3)
imshow(Feather_Comp)
xticks([])
yticks([])
axis on


% We now want to implement a Pyramid roughly like Burt and Adelson

A_GP = myGaussianPyramid(A,11); %Create pyramid of Apple
O_GP = myGaussianPyramid(O,11); %Create Pyramid of Orange
M_L_GP = myGaussianPyramid(M_L,11); %Create Pyramid of Mask 

A_LP = myLaplacianPyramid(A_GP);
O_LP = myLaplacianPyramid(O_GP);

% we want to create a Composite Laplacian Pyramid of L_LP and O_LP
% And to do this we will use the Pyramid of masks created above - M_GP.

for k = 1:length(A_LP)
    AO_LP{k} = (A_LP{k} .* M_L_GP{k}) + ...
        (O_LP{k} .* (1 - M_L_GP{k}));
end

% Now we can reconstruct this composited Laplacian Pyramid
AO_Comp = myReconFromPyramid(AO_LP);
figure(4)
subplot(1,3,1)
imshow(Simple_Comp)
subplot(1,3,2)
imshow(Feather_Comp)
subplot(1,3,3)
imshow(AO_Comp{1})

% YOU CAN REMOVE THE IF STATEMENT AND THIS END ONCE YOU ARE COMPLETE.
