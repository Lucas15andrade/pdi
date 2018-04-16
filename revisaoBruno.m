close all
clear all

pkg load image

mascara = imread('C:\Andrade\PDI\Revisao\mascara3.jpg');
img = imread('C:\Andrade\PDI\Revisao\img2.jpg');
textura = imread('C:\Andrade\PDI\Revisao\text4.jpg');
assinatura = imread('C:\Andrade\PDI\Revisao\assinatura400.png');

figure(1)
imshow(mascara)

figure(2)
imshow(img)

figure(3)
imshow(textura)

figure(4)
imshow(assinatura)

textNeg = 255-textura;

figure(5)
imshow(textNeg)

tamImg = size(img,2)+1;

%Espelhar as laterais
for x=1:size(img,2)
  imgEspelhada(:, x, :) = img(:, tamImg-x, :);
endfor

%Espelhar as partes superiores e inferiores
%for x=1:size(img,2)
  %imgEspelhada(x, :, :) = img(tamImg-x, :, :);
%endfor

figure(6)
imshow(imgEspelhada)

for x=1:size(imgEspelhada,1)
  for y=1:size(imgEspelhada,2)
    imgRot1(x,y,:) = imgEspelhada(y, tamImg-x, :);
  endfor
endfor

figure(7)
imshow(imgRot1)

for x=1:size(imgEspelhada,1)
  for y=1:size(imgEspelhada,2)
    imgRot2(x,y,:) = imgRot1(y, tamImg-x, :);
  endfor
endfor

figure(8)
imshow(imgRot2)

imgFinal = imgRot2;

for x=1:size(imgRot2,1)
  for y=1:size(imgRot2,2)
    if(x >= 1 && x <= 22)
      imgFinal(x,y,:) = imgFinal(x,y,:).*0.7;
    elseif(y >= 1 && y <= 22)
      imgFinal(x,y,:) = imgFinal(x,y,:).*0.7;
    elseif(x >= 378 && x <= 400)
      imgFinal(x,y,:) = imgFinal(x,y,:).*0.7;
    elseif(y >= 378 && y <= 400)
      imgFinal(x,y,:) = imgFinal(x,y,:).*0.7;
    elseif(y >= 190 && y <= 210)
      imgFinal(x,y,:) = imgFinal(x,y,:).*0.7;  
    endif
  endfor
endfor

figure(9)
imshow(imgFinal)

figure(10)
imhist(mascara)

%Entre 120 e 140

imgBorrada = double(imgRot2);
imgRot2 = double(imgRot2);

for x=2:size(imgRot2,1)-1
  for y=2:size(imgRot2,2)-1
    imgBorrada(x,y,:) = ((imgRot2(x-1,y-1,:) + imgRot2(x-1,y,:) + imgRot2(x-1,y+1,:) ...
    + imgRot2(x,y-1,:) + imgRot2(x,y+1,:) + imgRot2(x+1,y-1,:) + imgRot2(x+1,y,:) ...
    + imgRot2(x+1,y+1,:))/8);
  endfor
endfor

for x=1:size(mascara,1)
  for y=1:size(mascara,2)
    if(mascara(x,y,:) > 120 && mascara(x,y,:) < 140)
      imgCompleta(x,y,:) = imgFinal(x,y,:);
    elseif(mascara(x,y,:) > 60 && mascara(x,y,:) < 100)
      imgCompleta(x,y,:) = textura(x,y,:);
    elseif(mascara(x,y,:) > 150 && mascara(x,y,:) < 170)
      imgCompleta(x,y,:) = textNeg(x,y,:);
    elseif(mascara(x,y,:) > 250)
      imgCompleta(x,y,:) = imgBorrada(x,y,:);
    endif
  endfor
endfor

figure(11)
imshow(imgCompleta)

figure(12)
imshow(uint8(imgBorrada))

assinaturaB = zeros(size(assinatura,1), size(assinatura,2));

for x=1:size(assinatura,1)
  for y=1:size(assinatura,2)
    if(assinatura(x,y) > 126)
      assinaturaB(x,y) = 1;
    endif
  endfor
endfor

final = imgCompleta.*assinaturaB;

imwrite(uint8(final), 'C:\Users\lucas\Desktop\borrado.png');

imFaixa = imgRot2;

for x=1:size(imgRot2,1)
  for y=1:size(imgRot2,2)
    if(x == y)
      imFaixa(x,y,:) = 255;
    endif
  endfor
endfor

for x=1:size(imgRot2,1)
  for y=1:size(imgRot2,2)
    if(imFaixa(x,y,:) == 255)
      %imFaixa(x,y-1,:) = 255;
      %imFaixa(x,y-2,:) = 255;
      imFaixa(x,y+1,:) = 255;
      imFaixa(x,y+2,:) = 255;
      break;
    endif
  endfor
endfor

for x=1:size(imgRot2,1)
  for y=1:size(imgRot2,2)
    if(imFaixa(x,y,:) == 255)
      
    endif
  endfor
endfor

figure(13)
imshow(uint8(imFaixa))

imwrite(uint8(imFaixa), 'C:\Users\lucas\Desktop\faixa.png');