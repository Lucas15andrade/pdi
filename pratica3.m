close all
clear all


pkg load image

% Criando uma imagem cinza a partir de uma colorida

im = imread('C:\Users\lucas\Desktop\lenna.jpg');
imCinza = rgb2gray(im);
figure(1)
imshow(imCinza)

j=1;

% Código para reduzir a imagem
for x=1:2:size(imCinza,1) %Percorrendo de 2 em 2 a imagem cinza(grande) e colocando esses valores numa matriz menor
  i = 1;
  for y=1:2:size(imCinza,2)
    imReduzida(j,i) = imCinza(x,y);
    i++;
  end
  j++;
end

figure(2)
imshow(imReduzida)

% Código encerrado

% Criando uma matriz só com zeros (preto)

imAmpliada = zeros(size(imCinza,1), size(imCinza,2) );
%ImAmpliada = zeros (size(imCinza1),size(imCinza,2));

% Mostrando a imagem preta

%figure(3)
%imshow(imAmpliada)

% Criando uma imagem do tamanho original (grande) e aplicando os valores da reduziada a ela.
% Percorrendo a imagem reduzida, de 1 em 1 e aplicando na imagem imAmpliada.
% A contagem de A e B faz com que quando vinher a ser inserido, seja de 2 em 2.

b = 1;
for x = 1: size(imReduzida,1)
  
  a = 1;
  for y = 1: size(imReduzida,2)
  imAmpliada(b, a) = imReduzida(x, y);
  a = a + 2;
  end
  b = b + 2;
end
  
figure(3)
imshow(uint8(imAmpliada))
imwrite(uint8(imAmpliada),'C:\Users\lucas\Desktop\lennaAmpliada.jpg');

imVizinho = uint8(imAmpliada);

for x = 1:2: size(imVizinho,1)
  for y = 2: size(imVizinho,2)
  
    if(imVizinho(x,y) == 0)
      if(imVizinho(x,y-1) ~= 0)
        imVizinho(x,y) = imVizinho(x,y-1);
      elseif(imVizinho(x-1,y-1) ~= 0)
        imVizinho(x,y) = imVizinho(x-1,y-1);
      elseif(imVizinho(x-1,y) ~= 0)
        imVizinho(x,y) = imVizinho(x-1,y);
      endif
    endif
  endfor
endfor

for x=2:2:size(imVizinho,1)
  for y=1:size(imVizinho,2)
    if(imVizinho(x,y) == 0)
      imVizinho(x,y) = imVizinho(x-1,y);
    endif
   endfor
endfor

figure(4)
imshow(imVizinho)
imwrite(uint8(imVizinho),'C:\Users\lucas\Desktop\lennaVizinho.jpg');