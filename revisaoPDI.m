close all
clear all

pkg load image

texturaOriginal = imread('C:\Andrade\PDI\Revisao\textura.jpg');
mascara = imread('C:\Andrade\PDI\Revisao\mascara.jpg');
listras = imread('C:\Andrade\PDI\Revisao\listras.jpg');
assinatura = imread('C:\Andrade\PDI\Revisao\assinatura.jpg');

listrasNeg = 255-listras;

figure(1)
imshow(texturaOriginal)

tamOrigi = size(texturaOriginal,2)+1;

%Primeiro é feito o espelhamento da imagem
for x=1:size(texturaOriginal,2)
  textEpelhada(:, x, :) = texturaOriginal(:, tamOrigi-x, :);
endfor

figure(2)
imshow(textEpelhada)

%Depois é rotacionado 1 vez

for x=1:size(textEpelhada,1)
  for y=1:size(textEpelhada,2)
    textFinal(x,y, :) = textEpelhada(y, tamOrigi-x, :);
  endfor
endfor

figure(3)
imshow(textFinal)

figure(4)
imshow(mascara)

textFinalBorda = textFinal;

for x=1:20
  textFinalBorda(x, :, :) = textFinal(x, :, :) + (textFinal(x, :, :) * 0.7);
endfor

%for x=1:size(textFinal,1)
  %for y=1:size(textFinal,2)
    %textFinalBorda(x,y)
  %endfor
%endfor

figure(5)
imshow(textFinalBorda)

%criando mascara final

%imFinal = mascara;

%Código para deixar igual a atividade
for x=1:size(mascara,1)
  for y=1:size(mascara,2)
    if(((mascara(x,y,:)) > 120) && ((mascara(x,y,:) < 140)))
      imFinal(x,y,:) = textFinalBorda(x,y,:);
    elseif(((mascara(x,y,:)) > 180) && ((mascara(x,y,:) < 200)))
      imFinal(x,y,:) = listrasNeg(x,y,:);
    elseif((mascara(x,y,:)) > 250)
      imFinal(x,y,:) = listras(x,y,:);
    endif
  endfor
endfor

%Código para deixar transparente

%for x=1:size(mascara,1)
  %for y=1:size(mascara,2)
    %if(((mascara(x,y,:)) > 120) && ((mascara(x,y,:) < 140)))
      %imFinal(x,y,:) = textFinalBorda(x,y,:);
    %elseif(((mascara(x,y,:)) > 180) && ((mascara(x,y,:) < 200)))
      %imFinal(x,y,:) = listrasNeg(x,y,:);
    %elseif((mascara(x,y,:)) > 250)
      %imFinal(x,y,:) = max(listras(x,y, :),textFinalBorda(x,y, :));
    %endif
  %endfor
%endfor

figure(6)
imhist(mascara);

figure(7)
imshow(listrasNeg)

figure(8)
imshow(imFinal)

for x=1:size(assinatura,1)
  for y=1:size(assinatura,2)
    if assinatura(x,y)>126
      imbw(x,y) = 1;
     else
       imbw(x,y) = 0;
    endif
  endfor
endfor
  

img = imFinal.*imbw;

figure(9)
imshow(img)

figure(10)
imshow(assinatura)

tamTeste = size(listras,2)+1;

for x=1:size(listras,1)
  for y=2:size(listras,2)-1
    imBorrada(x,y,:) = listras(x,y-1,:)+ listras(x,y+1,:)/2;
  endfor
endfor

figure(11)
imshow(imBorrada)