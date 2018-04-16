close all
clear all

pkg load image

im = imread('C:\Users\lucas\Desktop\lenna.jpg');
imCinza = rgb2gray(im);
figure(1)
imshow(imCinza)

%size(imCinza)

for x=1:size(imCinza,1)
  for y=1:size(imCinza,2)
    imEscura(x,y) = imCinza(x,y)+(imCinza(x,y)*0.4);
  end
end

figure(2)
imshow(imEscura)

for x=1:size(imCinza,1)
  for y=1:size(imCinza,2)
    imClara(x,y) = imCinza(x,y)-(imCinza(x,y)*0.4);
  end
end

figure(3)
imshow(imClara)