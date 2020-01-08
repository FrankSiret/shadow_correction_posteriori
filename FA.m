function FA(img)
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
[Background]=Polinomios(I);

%% Constante de normalización
Ca= -mean (Background(:));
waitbar(2/5,h);

%% Creando el componente aditivo y Eliminación ruido aditivo
Sa = Background+Ca;
Ne= I - Sa;
waitbar(3/5,h);

%% Visualizacion de los resultados
level = graythresh(Ne);
bw2 = im2bw(Ne,level);
bw2 = bwareaopen(bw2, 50);
waitbar(4/5,h);

fig=figure('Name','Imagen Original','NumberTitle','off');
set(fig,'OuterPosition',[0 0 683 768]);
subplot(2,2,1), imshow(I), title('Imagen');
subplot(2,2,2), imshow(bw), title('Umbralización')
subplot(2,2,3), imhist(I), title('Histograma');
subplot(2,2,4), plot(I(3*size(I,1)/5,:)), title('Perfil de intensidad');

fig1=figure('Name','Ajuste de Polinomio Aditivo','NumberTitle','off');
set(fig1,'OuterPosition',[683 0 683 768]);
subplot(2,2,1), imshow(bw2), title('Umbralización')
subplot(2,2,2), imhist(Ne), title('Histograma');
subplot(2,2,3), plot(Ne(3*size(Ne,1)/5,:)), title('Perfil de intensidad');
subplot(2,2,4), imshow(Sa, []), title('Componente multiplicativo');

fig2=figure('Name','Imagen resultante del Ajuste de Polinomio Aditivo','NumberTitle','off');
set(fig2,'OuterPosition',[500 100 540 540]);
subplot(1,1,1), imshow(Ne, []), title('Imagen resultante');

waitbar(5/5,h);
set(h,'Visible','off');

%% Guardar
save(Ne);