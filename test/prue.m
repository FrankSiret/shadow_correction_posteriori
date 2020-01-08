function prue()
background=imread('im1 orig.png');
background=rgb2gray(background);
% background=im2double(background);
figure, surf(double(background(1:8:end,1:8:end))),zlim([0 255]);
end

