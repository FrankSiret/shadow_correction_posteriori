function MFM(img)
%% Leer imagen
h=waitbar(0,'Procesando...');
addpath(genpath(cd));
I = imread(img);
if size(I, 3)==3
    I=rgb2gray(I);
end
I = im2double(I);

%% Umbralizacion de la imagen original sin correccion de sombras
level = graythresh(I);
bw = im2bw(I,level);
bw = bwareaopen(bw, 50);
waitbar(1/5,h);

%% 
se = strel('disk',20); 
n=20;
for i=1:n
    dilate = imdilate (I,se);
end
for i=1:n
    erode = imerode(dilate,se);
end
waitbar(2/5,h);

%% Componente multiplicativo
L = log(I);
lf=fspecial('gaussian',[400 400], 350);
lpf=imfilter(L,lf,'replicate','same');
E = exp(lpf);
waitbar(3/5,h);

%% ---------------------%
M = 1/(mean(I(:)));
D = I./E; 
M1 = mean (D(:));
Cm = M * M1; 

%% Eliminación del ruido multiplicativo
Sm = erode*Cm; 
Ne = I./Sm; 
waitbar(4/5,h);

%% Visualizacion de los resultados
level = graythresh(Ne);
bw2 = im2bw(Ne,level);
bw2 = bwareaopen(bw2, 50);

fig=figure('Name','Imagen Original','NumberTitle','off');
set(fig,'OuterPosition',[0 0 683 768]);
subplot(2,2,1), imshow(I), title('Imagen');
subplot(2,2,2), imshow(bw), title('Umbralización')
subplot(2,2,3), imhist(I), title('Histograma');
subplot(2,2,4), plot(I(3*size(I,1)/5,:)), title('Perfil de intensidad');

fig1=figure('Name','Filtrado Morfológico Multiplicativo','NumberTitle','off');
set(fig1,'OuterPosition',[683 0 683 768]);
subplot(2,2,1), imshow(bw2), title('Umbralización')
subplot(2,2,2), imhist(Ne), title('Histograma');
subplot(2,2,3), plot(Ne(3*size(Ne,1)/5,:)), title('Perfil de intensidad');
subplot(2,2,4), imshow(Sm, []), title('Componente multiplicativo');

fig2=figure('Name','Imagen resultante del Filtrado Morfológico Multiplicativo','NumberTitle','off');
set(fig2,'OuterPosition',[500 100 540 540]);
subplot(1,1,1), imshow(Ne, []), title('Imagen resultante');

waitbar(5/5,h);
set(h,'Visible','off');

%% Guardar
save(Ne);

end

