clc
close all
clear all

pkg load image

im = imread('C:\Andrade\PDI\Praticas\mulherNeg.jpg');
figure(1)
imshow(im)

roi = imread('C:\Andrade\PDI\Praticas\ROI_circular.jpg');
figure(2)
imshow(roi)

roiBW = zeros(size(roi,1), size(roi,2));

for x=1:size(roi,1)
  for y=1:size(roi,2)
    if(roi(x,y)>126)
      roiBW(x,y) = 1;
    endif
  endfor
endfor

figure(3)
imshow(roiBW)

imOpArit = im.*roiBW;

figure(4)
imshow(imOpArit)

mulherNormal = 255-imOpArit;

figure(9)
imshow(mulherNormal)

imBack = imread('C:\Andrade\PDI\Praticas\flores.jpg');
figure(5)
imshow(imBack)

imOperConj = max(imOpArit, imBack);
figure(6)
imshow(imOperConj)

imOperConj = 255-imOperConj;
figure(7)
imshow(imOperConj)

tam = size(imOperConj, 2)+1;

%tam = uint8(tam)

%for x=1:size(imOperConj, 1)
  for y=1:size(imOperConj, 2)
    imEspelhada(:, y, :) = imOperConj(:, tam-y,:);
  endfor
%endfor

figure(8)
imshow(imEspelhada)

tamEsp = size(mulherNormal,2)+1;

for x=1:size(mulherNormal,2)
  mulherEspelhada(:, x, :) = mulherNormal(:, tamEsp-x, :);
endfor

figure(10)
imshow(mulherEspelhada);

tamFlor = size(imBack,2)+1;

for x=1:size(imBack,2)
  backEspelhada(:, x, :) = imBack(:, tamFlor-x, :);
endfor

figure(11)
imshow(backEspelhada)

for x=1:size(roiBW, 1)
  for y=1:size(roiBW, 2)
    if(roiBW(x,y) == 1)
      imFinal(x,y,:) = mulherEspelhada(x,y,:);
    else
      imFinal(x,y,:) = backEspelhada(x,y,:);
    endif
  endfor
endfor

%imFinal = max(backEspelhada, mulherEspelhada);
figure(12)
imshow(imFinal)

% Código de rotação da imagem

%for x=1:size(imFinal, 1)
  %for y=1:size(imFinal, 2)
    %imRotacao(x, y, :) = imFinal(y,(size(imFinal,2)+1)-x,:);
  %endfor
%endfor

tamRotacao = size(imFinal,2)+1;

for x=1:size(imFinal, 1)
  for y=1:size(imFinal, 2)
    imRotacao(x, y, :) = imFinal(y, tamRotacao-x, :);
  endfor
endfor

figure(13)
imshow(imRotacao)

imwrite(uint8(imRotacao), 'C:\Users\lucas\Desktop\virada.png');