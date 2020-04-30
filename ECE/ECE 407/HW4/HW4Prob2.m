mu = [0 0];
sigma = [1 -0.75; -0.75 1];


x1 = -10:0.2:10;
x2 = -10:0.2:10;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

y = mvnpdf(X,mu,sigma);
y = reshape(y,length(x2),length(x1));


surf(x1,x2,y)
caxis([min(y(:))-0.5*range(y(:)),max(y(:))])
axis([-3 3 -3 3 0 0.4])
xlabel('x1')
ylabel('x2')
zlabel('Probability Density')



