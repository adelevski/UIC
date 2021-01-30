
% A = [0 12 2];
% B = [16 16 4];
% C = [12 -12 3];
% D = [0 -36 6];
% E = [-20 -20 5];
% F = [-28 28 7];
% 
% h = [A;B;C;D;E;F];
% 
% c = hom2cart(h);

x = [0 4 4 0 -4 -4];
y = [6 4 -4 -6 -4 4];
figure
plot(x, y, 'x');

grid on
title('Problem 1 Part c')
xlabel('X')
ylabel('Y')
xlim([-15, 15])
ylim([-15, 15])

hold on
plot([0, 4], [6, 4], 'r');
plot([4, 4], [4, -4], 'r');
plot([4, 0], [-4, -6], 'r');
plot([0, -4], [-6, -4], 'r');
plot([-4, -4], [-4, 4], 'r');
plot([-4, 0], [4, 6], 'r');

point_vectors = zeros(3, 6);
point_vectors(1,:) = x;
point_vectors(2,:) = y;
point_vectors(3,:) = 1;

homog_matrix = [  cosd(30)      -0.5*sind(30)   4;
                0.5*sind(30)       cosd(30)     5;
                     0               0          1]; % rot by 30, translate by t=(4, 5) and shear

answer_vector = zeros(3, 1);
answer_matrix = zeros(3, 6);

for i = 1:length(point_vectors)
    temp_vector = point_vectors(:, i);
    answer_vector = homog_matrix*temp_vector;
    answer_matrix(:, i) = answer_vector;
end

new_homog = transpose(answer_matrix);
new_cart = hom2cart(new_homog);
new_mat = transpose(new_cart);
new_x = new_mat(1, :);
new_y = new_mat(2, :);

plot(new_x, new_y, 'x');

grid on
title('Problem 2 Part c')
xlabel('X')
ylabel('Y')
xlim([-15, 15])
ylim([-15, 15])

hold on
plot([2.5, 6.464101615137754], [10.196152422706632, 9.464101615137753], 'b');
plot([6.464101615137754, 8.464101615137753], [9.464101615137753, 2.535898384862246], 'b');
plot([8.464101615137753, 5.5], [2.535898384862246, -0.196152422706632], 'b');
plot([5.5, 1.535898384862246], [-0.196152422706632, 0.535898384862246], 'b');
plot([1.535898384862246, -0.464101615137754], [0.535898384862246, 7.464101615137754], 'b');
plot([-0.464101615137754, 2.5], [7.464101615137754, 10.196152422706632], 'b');




%L1 = (-0.5)*X + (-1)*Y + (6)*W = 0
%L2 =   (1)*X  + (0)*Y + (-4)*W = 0

v1 = [-0.5 -1 6];
v2 = [1 0 -4];

intersect = cross(v1, v2)



