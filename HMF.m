function HMF(img)
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

%% Suavizando la imagen
lf=fspecial('gaussian',[10 10], 10);
Im=imfilter(I,lf,'replicate','same');

%% Construyendo el exponente
L=log(I);
lf=fspecial('gaussian',[300 300], 300);
lpf=imfilter(L,lf,'replicate','same');
E=exp(lpf);
waitbar(2/5,h);

%% Construyendo la constante de normalizacion
M = mean(Im(:));
M1 = 1/M;
D = Im./E; 
M2 = mean (D(:));
Cm = M1 * M2; 
waitbar(3/5,h);

%% Realizando el metodo
Sm = E * Cm; 
Ne = I./Sm; 
waitbar(4/5,h);

%% Visualización de los resultados
level = graythresh(Ne);
bw2 = im2bw(Ne,level);
bw2 = bwareaopen(bw2, 50);

fig=figure('Name','Imagen Original','NumberTitle','off');
set(fig,'OuterPosition',[0 0 683 768]);
subplot(2,2,1), imshow(I), title('Imagen');
subplot(2,2,2), imshow(bw), title('Umbralización')
subplot(2,2,3), imhist(I), title('Histograma');
subplot(2,2,4), plot(I(3*size(I,1)/5,:)), title('Perfil de intensidad');

fig1=figure('Name','Filtrado Homomórfico','NumberTitle','off');
set(fig1,'OuterPosition',[683 0 683 768]);
subplot(2,2,1), imshow(bw2), title('Umbralización')
subplot(2,2,2), imhist(Ne), title('Histograma');
subplot(2,2,3), plot(Ne(3*size(Ne,1)/5,:)), title('Perfil de intensidad');
subplot(2,2,4), imshow(Sm, []), title('Componente multiplicativo');

fig2=figure('Name','Imagen resultante del Filtrado Homomórfico','NumberTitle','off');
set(fig2,'OuterPosition',[500 100 540 540]);
subplot(1,1,1), imshow(Ne, []), title('Imagen resultante');


waitbar(5/5,h);
set(h,'Visible','off');

%% Guardar
save(Ne);

end