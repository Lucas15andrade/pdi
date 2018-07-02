close all
clear all
clc

pkg load image

img = imread('C:\Andrade\PDI\ProjetoFinal\img\feijao.jpg');
figure('Name','Imagem Original')
imshow(img)

imgBin = im2bw(img);

figure('Name','Imagem Binarizada')
imshow(imgBin)

x1 = 0;
y1 = 0;

%vetor = zeros(size(imgBin,1));
cont = 1;

teste = zeros(size(imgBin,1), size(imgBin,2), 3);

for x=1:size(imgBin,1)
  for y=1:size(imgBin,2)
    if(imgBin(x,y) == 0)
      cont++;
      x1 = x;
      y1 = y;
      if(cont == 2)
        teste(x,y,1) = 255;
        teste(x,y,2) = 255;
        teste(x,y,3) = 255;
        a = x;
        b = y;

      endif
    endif
  endfor  
endfor

teste(x1,y1,1) = 255;
teste(x1,y1,2) = 255;
teste(x1,y1,3) = 255;

c = x1;
d = y1;

D = sqrt(((a-c)^2) + ((b-d)^2));

cont2 = 1;

for y=1:size(imgBin,2)
  for x=1:size(imgBin,1)
    if(imgBin(x,y) == 0)
      cont2++;
      %x1 = x;
      y2 = y;
      x2 = x;
      if(cont2 == 2)
        teste(x,y,1) = 255;
        teste(x,y,2) = 255;
        teste(x,y,3) = 255;
        a = x;
        b = y;
      endif
    endif
  endfor  
endfor

teste(x2,y2,1) = 255;
teste(x2,y2,2) = 255;
teste(x2,y2,3) = 255;

c = x2;
d = y2;

D2 = sqrt(((a-c)^2) + ((b-d)^2));

figure('Name','Imagem Original')
imshow(img)

figure('Name','Imagem teste')
imshow(uint8(teste))

imwrite(teste, 'C:\Users\lucas\Desktop\teste.jpg');

