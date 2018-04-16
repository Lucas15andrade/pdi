close all
clear all
clc

pkg load image

mascara = imread('C:\Users\lucas\Desktop\11\mascara1.jpg');
listras = imread('C:\Users\lucas\Desktop\11\img2.jpg');
foto = imread('C:\Users\lucas\Desktop\11\foto2.jpg');
assinatura = imread('C:\Users\lucas\Desktop\11\ass.jpg');
%assinaturaEfeito = rgb2gray(assinatura);

%Código para rotacionar a imagem

tamImg = size(foto,2)+1;

for x=1:size(foto,1)
  for y=1:size(foto,2)
    fotoBorradaRot1(x,y,:) = foto(y,tamImg-x,:);
  endfor
endfor

fotoBorradaRot1 = double(fotoBorradaRot1);

%Código para borrar a imagem
for x=2:size(foto,1)-1
  for y=2:size(foto,2)-1
    fotoBorrada(x,y,:) = ((fotoBorradaRot1(x-1,y-1,:) + fotoBorradaRot1(x-1,y,:) + fotoBorradaRot1(x-1,y+1,:) ...
    + fotoBorradaRot1(x,y-1,:) + fotoBorradaRot1(x,y+1,:) + fotoBorradaRot1(x+1,y-1,:) + fotoBorradaRot1(x+1,y,:) ...
    + fotoBorradaRot1(x+1,y+1,:))/8);
  endfor
endfor

figure(1)
imshow(uint8(fotoBorradaRot1))

figure(2)
imshow(uint8(fotoBorrada))

fotoNeg = 255-fotoBorradaRot1;

figure(3)
imshow(uint8(fotoNeg))

%Clareando a imagem de listras
listrasClara = listras + 60;

figure(4)
imshow(uint8(listrasClara))

figure(5)
imshow(mascara)

assinaturaB = zeros(size(assinatura,1), size(assinatura,2));

for x=1:size(assinatura,1)
  for y=1:size(assinatura,2)
    if(assinatura(x,y,:) < 128)
      assinaturaB(x,y,:) = 1;
    elseif(assinatura(x,y,:) > 128)  
      assinaturaB(x,y) = 0;
    endif
  endfor
endfor


%assinaturaB = uint8(assinaturaB);
%assinaturaEfeito = rgb2gray(assinaturaB);

cont = 100;

%for x=1:size(assinaturaB,1)
  %for y=1:size(assinaturaB,2)
    %if(assinaturaB(x,y,:) == 1)
      %assinaturaB(x,y,:) += cont;
    %endif  
  %endfor
  %cont++;
%endfor

%Entre 60 e 100


ass = zeros(400,400);
%200 por 100


i=1;
%for x=1:size(ass,1)
  %j=1;
  %for y=1:size(ass,2)
    %if(x > 200 && x <232)
      %if(y > 100 && y < 159)
        %ass(x,y) = assinaturaB(i,y);
        %i++;
      %endif
      %j++;
    %endif
    %j++;
  %endfor
%endfor


a = 1;
c = 1;

%Preenchendo a imagem final com as respectivas imagem em cada cor de acordo com a máscara.
for x=1:size(mascara,1)
  
  for y=1:size(mascara,2)
    if(mascara(x,y,:) >= 60 && mascara(x,y,:) <= 100)
      imgFinal(x,y,:) = fotoBorradaRot1(x,y,:);
      if(x >= 1 && x <= 13)
        imgFinal(x,y,:) = fotoNeg(x,y,:);
      elseif(y >= 1 && y <= 13)
        imgFinal(x,y,:) = fotoNeg(x,y,:);
      elseif(x >= 388 && x <= 400)
        imgFinal(x,y,:) = fotoNeg(x,y,:);
      elseif(y >= 388 && y <= 400)
        imgFinal(x,y,:) = fotoNeg(x,y,:); 
      endif
      elseif(mascara(x,y,:) >= 0 && mascara(x,y,:) <= 20)
        imgFinal(x,y,:) = listrasClara(x,y,:);
      elseif(mascara(x,y,:) >= 180 && mascara(x,y,:) <= 200)
        imgFinal(x,y,:) = fotoBorrada(x,y,:);
      elseif(mascara(x,y,:) >= 120 && mascara(x,y,:) <= 140)
        
        
    elseif(mascara(x,y,:) > 200)
      imgFinal(x,y,:) = 255;
    endif
  endfor
  
endfor

figure(6)
imshow(uint8(imgFinal))



figure(7)
imshow(assinaturaB)

figure(8)
imshow(uint8(assinatura))

imwrite(uint8(imgFinal), 'C:\Users\lucas\Desktop\prova.png');