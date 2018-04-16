close all
clear all

pkg load image

%Lendo a imagem original
im = imread('C:\Andrade\PDI\Praticas\objetos.jpg');

figure(1)
imshow(im)

%Criando imagem preta que servirá de máscara
imBW = zeros(size(im,1), size(im,2));

imFinal = zeros(size(im,1), size(im,2));

%figure(2)
%imshow(imBW)


%Percorrendo a imagem original e marcando na máscara onde a intensidade é maior que 126
%Ou seja marcando como 1 branco e 0 preto
for x=1:size(im,1)
  for y=1:size(im,2)
  
    if(im(x,y) > 126)
      imBW(x,y) = 1;
    endif
  endfor 
endfor

figure(2)
imshow(imBW)

cont = 10;

for x=2:size(imBW,1)
  for y=2:size(imBW,2)
  
    if(imBW(x,y) == 1)
      
      if((imBW(x-1,y) == 0) && (imBW(x, y-1) == 0))
        cont+=7;
        imFinal(x,y) = cont;    
      else
        if((imBW(x-1,y) == 1) && (imBW(x,y-1) == 0))
          imFinal(x,y) = imFinal(x-1, y);
        elseif((imBW(x-1, y) == 0) && (imBW(x, y-1) == 1))
            imFinal(x,y) = imFinal(x, y-1);
          %endif
        endif
      endif
      
        if((imBW(x-1,y) == 1) && (imBW(x, y-1) == 1))
          if(imFinal(x-1,y) == imFinal(x, y-1))
            imFinal(x,y) = imFinal(x-1,y);
          else
            imFinal(x,y) = imFinal(x-1,y);
          endif
        endif
        
        %if((imBW(x-1,y) == 1) == (imBW(x, y-1) == 1))
         % if(imFinal(x-1,y) ~= imFinal(x, y-1))
          %  imFinal(x,y) = imFinal(x-1,y);
          %endif
        %endif
        
    endif
  endfor 
endfor


figure(3)
imshow(uint8(imFinal))

imwrite(uint8(imFinal), 'C:\Users\lucas\Desktop\final.png');