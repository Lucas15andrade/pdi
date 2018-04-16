close all
clear all

pkg load image

im = imread('C:\Users\lucas\Desktop\lenna.jpg');

img = rgb2gray(im);


cont = 0;

for(x = 1:size(img,1))
  for(y = 1:size(img,2))
    img(x,y) = img(x,y) + cont;
  endfor
  cont++;
endfor

figure(1)
imshow(img)