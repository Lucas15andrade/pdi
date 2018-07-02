clear all
close all
clc

%filename = "dadosSementes.txt";
%fid = fopen (filename, "w");


pkg load image

caminhoImagens = 'C:\Andrade\PDI\ProjetoFinal\ImagensRed\sementes';
extensao = '.jpg';
caminho = 'C:\Andrade\PDI\ProjetoFinal\imgSementes\imgSem';
ext = '.jpg';
for dor=5:5
  
  %dor = 1;
  ln = dor;
  ln = num2str(ln);
  
  

  img = imread(strcat(caminhoImagens,ln,extensao));

  figure('Name','Sementes: Original')
  imshow(img)

  R = img(:,:,1);
  G = img(:,:,2);
  B = img(:,:,3);

% figure, imshow((R-B)>1);

  imBin = ((R-B)>1);

  figure('Name','Imagem binarizada')
  imshow(imBin)

  imBin = double(imBin);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  D = imBin;

  rotulo = 2;
  rotulosIguais(1,1) = 0;
  %rotulosIguais(2,1) = 0;
  r = 1; %indice do vetor rotulos Iguais
  imRotulo = D; %imagem cópia para armazenar os rotulos
  for(i=2:size(D,1))
    for(j=2:size(D,2))
      if(D(i,j)==1)
        if((D(i-1,j)==0)&&(D(i,j-1)==0))
          rotulo+=10; % novo rotulo (soma de 10 em 10)
          imRotulo(i,j)=rotulo;
        else
          if((D(i-1,j)==1)&&(D(i,j-1)==0))
            imRotulo(i,j)=imRotulo(i-1,j);
          else
            if((D(i-1,j)==0)&&(D(i,j-1)==1))
              imRotulo(i,j)=imRotulo(i,j-1);
            else
              if(((D(i-1,j)==1)&&(D(i,j-1)==1))&&(imRotulo(i-1,j)==imRotulo(i,j-1)))
                imRotulo(i,j)=imRotulo(i-1,j);
              else
                if(((D(i-1,j)==1)&&(D(i,j-1)==1))&&(imRotulo(i-1,j)!=imRotulo(i,j-1)))
                  %os vizinhos são rotulados e os rotulos são diferentes...
                  imRotulo(i,j)=imRotulo(i-1,j); %insere o rotulo de um dos vizinhos
                  eq1 = imRotulo(i-1,j); 
                  eq2 = imRotulo(i,j-1);
                  % guardar rotulos equivalentes - erro
                  ultimaLinha = size(rotulosIguais,1);
                  ultimaColuna = size(rotulosIguais,2);
                  [l1,c1]=find(rotulosIguais==eq1); %busca o 1o elemento
                  [l2,c2]=find(rotulosIguais==eq2); %busca o 2o elemento
                  if ((isempty(l1))&&(isempty(l2))) %não achou nenhum dos elementos
                    rotulosIguais(ultimaLinha+1,1) = eq1;
                    rotulosIguais(ultimaLinha+1,2) = eq2;
                  else
                    if ((!isempty(l1))&&(isempty(l2))) %não achou o 1o elemento
                      rotulosIguais(l1,ultimaColuna+1) = eq2;
                    else
                      if ((isempty(l1))&&(!isempty(l2))) %não achou o 2o elemento
                        rotulosIguais(l2,ultimaColuna+1) = eq1;
                      end
                    end
                  end
                end  
              end
            end
          end
        end
      end
    end
  end

%  figure('Name','Imagem Rotulada com erros')
%  imshow(uint8(imRotulo), [min(min(imRotulo)), max(max(imRotulo))])

  %retirar erros de equivalências de rótulos
  for(i=2:size(imRotulo,1))
    for(j=2:size(imRotulo,2))
      if(imRotulo(i,j)!=0)
        [l,c]=find(rotulosIguais==imRotulo(i,j)); %procura o elemento nos erros
        if(!isempty(l))
          imRotulo(i,j) = rotulosIguais(l,1);
        end
      end
    end
  end

  qtdRegioes =  size(unique(imRotulo),1)-1; %-1 para desconsiderar o fundo
  %imDouble = imRotulo;
  %imRotulo = uint8(imRotulo);
%  figure('Name','Imagem Rotulada 2')
%  imshow(imRotulo, [min(min(imRotulo)) max(max(imRotulo))])
  %imwrite(imRotulo, 'E:\EAJ\2018\PDI\Aulas\Aula 3-relacoes\imRotulo.jpg');

%  title(strcat('Quantidade de Regioes (foreground): ',int2str(qtdRegioes)))

  objetos = unique(imRotulo);

  % Código para separar a moeda

  for x=1:size(imRotulo,1)
    for y=1:size(imRotulo,2)
      if(imRotulo(x,y) == objetos(2))
        moedas(x,y) = 1;
      else
        moedas(x,y) = 0;
      endif
    endfor
  endfor

%  figure('Name','Imagem da moeda')
%  imshow(moedas)

  % Fim 

  %Calcular a largura e altura da moeda

  cont = 1;
  area = 0;
  imgBin = moedas;
  teste = zeros(size(imgBin,1), size(imgBin,2), 3);

  for x=1:size(imgBin,1)
    for y=1:size(imgBin,2)
      if(imgBin(x,y) == 1)
        area++;
      endif
    endfor  
  endfor

  for x=1:size(imgBin,1)
    for y=1:size(imgBin,2)
      if(imgBin(x,y) == 1)
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
  larguraMoeda = D;

  cont2 = 1;

  for y=1:size(imgBin,2)
    for x=1:size(imgBin,1)
      if(imgBin(x,y) == 1)
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

%  figure('Name','Imagem teste')
%  imshow(uint8(teste))

  imwrite(teste, 'C:\Users\lucas\Desktop\teste2.jpg');

  largura1 = 2.5;
  altura1 = 2.5;

  largura2 = D;
  altura2 = D2;

  %Fim

  matrizSementes = zeros(size(imRotulo,1), size(imRotulo,2), size(objetos,1)-2);

  %Separando cada semente em uma imagem

  cont = 1;

  for z=3:size(objetos,1)
    for x=1:size(imRotulo,1)
      for y=1:size(imRotulo,2)
          if(objetos(z) == imRotulo(x,y))
            matrizSementes(x,y,cont) = 1;
          else
            matrizSementes(x,y,cont) = 0;
          endif
        endfor
    endfor
    cont++;
  endfor

%

%Implementação do código que roda todas as dimensões da imagem
contSementes = 1;
for p=1:size(objetos,1)-2
  
  l = p;
  l = num2str(l);
  

  %sementes = zeros(size(imgBin,1), size(imgBin,2));
  
  sementes = matrizSementes(:,:,p);
  imgSementeUn = zeros(size(matrizSementes,1), size(matrizSementes,2), 3);
  
  

  %Calcular a largura e altura das sementes

  cont = 1;
  area2 = 0;
  imgBin = sementes;
  teste = zeros(size(imgBin,1), size(imgBin,2), 3);

  for x=1:size(imgBin,1)
    for y=1:size(imgBin,2)
      if(imgBin(x,y) == 1)
        area2++;
        imgSementeUn(x,y,:) = img(x,y,:);
      endif
    endfor  
  endfor
  
  c2 = num2str(l)
  
  imwrite(uint8(imgSementeUn), strcat(caminho,ln,'-',c2,ext));

  for x=1:size(imgBin,1)
    for y=1:size(imgBin,2)
      if(imgBin(x,y) == 1)
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
      if(imgBin(x,y) == 1)
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

%  figure('Name','Imagem teste')
%  imshow(uint8(teste))
%
%  imwrite(teste, 'C:\Users\lucas\Desktop\teste3.jpg');
  %Fim

  larguraSemente1 = (D * largura1) / largura2;
  alturaSemente1 = (D2 * altura1) / altura2;
  areaDaSemente = (larguraMoeda * area2) / area;
  
  disp('Semente: '),disp(p)
  disp('Largura: '),disp(larguraSemente1)
  disp('Altura: '),disp(alturaSemente1)
  disp('Area: '),disp(areaDaSemente)
  
  
  %n1, n2, n3, n4;
  
  n1 = num2str(p);
  n2 = num2str(larguraSemente1);
  n3 = num2str(alturaSemente1);
  n4 = num2str(areaDaSemente);
  
  tudo = strcat('Semente: ',n1,' \nLargura: ',n2,' \nAltura: ',n3,' \nArea: ',n4);
  
  %fputs (fid, tudo);
%
endfor
%fclose (fid);
%Fim do código que roda todas as dimensões da matrizSementes
endfor
%endfor