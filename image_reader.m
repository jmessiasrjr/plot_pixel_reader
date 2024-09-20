%%%%% PLOT READER %%%%%
%
% Identify the position of points on the plot based on their RGB color
%
% Usage: Create an image.jpg file by cropping the original 
% graphic image along the 'x' and 'y' axis line
%

clear all

% percentage of pixels extracted on the image: 0 < n <= 100 
n = 10;

% initial coordinates in 'x' axis line
x0 = 0;
xf = 8;
% initial coordinates in 'y' axis line
y0 = 1;
yf = 1.9;
% RGB color
RGB = [250 255;  % red -- min max
       50 70;    % green -- min max
       20 40];   % blue -- min max

tic

% This function applies bilinear interpolation to store
% n% of the RGB pixel color matched in image.jpg
reader(n, x0, xf, y0, yf, RGB); % red points
Y1 = load('pixel.dat'); 

reader(n/6, x0, xf, y0, yf, [0 10;60 80;120 140]); % blue points
Y2 = load('pixel.dat');

toc

%% ACCURACY TEST %%
% accuracy depends upon the cropping precision and image quality
eqRed  = @(x) exp((x/15)^(3./4)); % red points
eqBlue = @(x) 1 + exp(-x/2); % blue points

for i = 1:81
    X(i) = (i-1)/10;
    Yred(i)  = eqRed(X(i));
    Yblue(i) = eqBlue(X(i));
end

plot(Y1(:,1),Y1(:,2),'ok',X,Yred,'-r','linewidth',2); hold on;
plot(Y2(:,1),Y2(:,2),'sk',X,Yblue,'-b','linewidth',2); hold off;
