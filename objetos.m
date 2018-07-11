close all
clear all
clc

pkg load image

img = imread('C:\Andrade\PDI\Prova2\prv2.jpg');
figure('Name','Imagem Original')
imshow(img)

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

img2 = img;

figure('Name','Imagem Original')
imshow(R)
figure('Name','Imagem Original')
imshow(G)
figure('Name','Imagem Original')
imshow(B)

figure('Name','Histograma imagem original 1')
imhist(R)

figure('Name','Histograma imagem original 2')
imhist(G)

figure('Name','Histograma imagem original 3')
imhist(B)

for x=1:size(img,1)
  for y=1:size(img,2)
    if((R(x,y) > 126) &&(G(x,y) < 126) && (B(x,y) < 126))
      img2(x,y,1) = 0;
      img2(x,y,2) = 0;
      img2(x,y,3) = 0;
    endif
    if((R(x,y) > 126) &&(G(x,y) > 126) && (B(x,y) < 126))
      img2(x,y,1) = 0;
      img2(x,y,2) = 0;
      img2(x,y,3) = 0;
    endif
  endfor
endfor

figure('Name','Imagem Original')
imshow(img2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B = [1 1 1; 1 1 1; 1 1 1];

img2 = double(rgb2gray(img2));

final = img2;

for y=1:10
  
  for i=2:size(img2,1)-1
    for j=2:size(img2,2)-1
      %if(img2(x,y) < 126)
        if(img2(i,j)==1) %se o pixel central da vizinhança de A = 1, deve ser analizado
          vizA = [img2(i-1,j-1) img2(i-1,j) img2(i-1,j+1);...
                img2(i,j-1) img2(i,j) img2(i,j+1);...
                img2(i+1,j-1) img2(i+1,j) img2(i+1,j+1)];
          if (sum(sum(vizA==B))!=9) % se todos os pixels são iguais entre a vizinhança de A e B
            final(i,j,:)=0;
          endif    
        %endif
      endif
    end
  end
  img2 = final;
end

figure('Name','Imagem Finalizada Dilatada')
imshow(uint8(final))