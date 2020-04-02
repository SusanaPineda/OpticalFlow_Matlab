clc
clear all

%% Lucas Kanade
directorio = dir('Combo_4_(C4)/*png');

for k = 1:length(directorio)-1
    im1 = directorio(k).name;
    img_1 = imread(strcat('Combo_4_(C4)/',im1));
    img_1 = im2double(rgb2gray(img_1));
    
    im2 = directorio(k+1).name;
    img_2 = imread(strcat('Combo_4_(C4)/',im2));
    img_2 = im2double(rgb2gray(img_2));
    
    % funcion de flujo óptico de lucas Kanade (tamaño de ventana, frame_1,
    % frame_2, distancia señalizaciones
    [X, Y, u, v] = lucas_kanade(3,img_1,img_2,20);

    figure(1);
    imshow(img_2);

    hold on;
    quiver(X, Y, u, v, 'y');
    hold off;
    pause(0.001);
end

%% Lucas Kanade mediante ecuación
directorio = dir('Combo_4_(C4)/*png');

for k = 1:length(directorio)-1
    im1 = directorio(k).name;
    img_1 = imread(strcat('Combo_4_(C4)/',im1));
    img_1 = im2double(rgb2gray(img_1));
    
    im2 = directorio(k+1).name;
    img_2 = imread(strcat('Combo_4_(C4)/',im2));
    img_2 = im2double(rgb2gray(img_2));
    
    % funcion de flujo óptico de lucas Kanade (tamaño de ventana, frame_1,
    % frame_2, distancia señalizaciones
    [X, Y, u, v] = lucas_kanade2(3,img_1,img_2,20);

    figure(1);
    imshow(img_2);

    hold on;
    quiver(X, Y, u, v, 'y');
    hold off;
    pause(0.001);
end

%% Metodo H&S
directorio = dir('Combo_4_(C4)/*png');
alpha = 0.1;

for k = 1:length(directorio)-1
    im1 = directorio(k).name;
    img_1 = imread(strcat('Combo_4_(C4)/',im1));
    img_1 = im2double(rgb2gray(img_1));
    
    im2 = directorio(k+1).name;
    img_2 = imread(strcat('Combo_4_(C4)/',im2));
    img_2 = im2double(rgb2gray(img_2));
    
    % funcion de flujo óptico de lucas Kanade (tamaño de ventana, frame_1,
    % frame_2, distancia señalizaciones
    [X, Y, u, v] = Horn_Schunck(alpha,img_1,img_2,10,20);

    figure(1);
    imshow(img_2);

    hold on;
    quiver(X, Y, u, v, 'y');
    hold off;
    pause(0.001);
end