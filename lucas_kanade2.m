function [ X_d, Y_d, u_d, v_d] = lucas_kanade2( h, f1, f2,  d )
%Cálculo de flujo optico mediante el metodo de lucas kanade utilizando la
%ecuación de [u v]
%oArgumentos de entrada:ventana de integracion, frames necesarios para el 
%calculo del flujo optico y distancia de las señalizaciones

u = zeros(size(f1));
v = zeros(size(f2));

%Calculo de Ix, Iy It de las imagenes completas
Ix_f1 = conv2(f1,[-1 0 1; -2 0 2; -1 0 1]); %Derivada parcial en x con sobel
Iy_f1 = conv2(f1, [-1 -2 -1; 0 0 0 ; 1 2 1]); %Derivada parcial en y con sobel

Ix_f2 = conv2(f2,[-1 0 1; -2 0 2; -1 0 1]); %Derivada parcial en x con sobel
Iy_f2 = conv2(f2, [-1 -2 -1; 0 0 0 ; 1 2 1]); %Derivada parcial en y con sobel

Ix = Ix_f1 + Ix_f2;
Iy = Iy_f1 + Iy_f2;

It = conv2(f1, ones(2)) + conv2(f2, -ones(2)); 

%Recorremos la imagen con la ventana de integración
centr = round(h/2);
img_size = size(f1);

for i = centr +1:img_size(1)-centr
    for j = centr+1:img_size(2)-centr

        %calculo del sumatorio Ix, Iy, It de la ventana de integración
        Ix_roi = Ix(i-centr:i+centr, j-centr:j+centr);
        Iy_roi = Iy(i-centr:i+centr, j-centr:j+centr);
        It_roi = It(i-centr:i+centr, j-centr:j+centr);
        
        Ix_It_roi = Ix_roi.*It_roi;
        Ix_Iy_roi = Ix_roi.*Iy_roi;
        Iy_It_roi = Iy_roi.*It_roi;
        
        Ix_2 = Ix_roi.*Ix_roi;
        Iy_2 = Iy_roi.*Iy_roi;
        
        sum_IxIt = sum(sum(Ix_It_roi));
        sum_IxIy = sum(sum(Ix_Iy_roi));
        sum_IyIt = sum(sum(Iy_It_roi));
        
        sum_Iy = sum(sum(Iy_2));
        sum_Ix = sum(sum(Ix_2));
        
        u(i,j) = (-sum_Iy * sum_IxIt + sum_IxIy * sum_IyIt) / (sum_Ix * sum_Iy - sum_IxIy * sum_IxIy);
        v(i,j) = (sum_IxIy * sum_IxIt - sum_Ix * sum_IyIt) / (sum_Ix * sum_Iy - sum_IxIy * sum_IxIy);
        
        
        
    end
end


u_d = u(1:d:end, 1:d:end);
v_d = v(1:d:end, 1:d:end);

[X,Y] = meshgrid(1:img_size(2), 1:img_size(1));
X_d = X(1:d:end,1:d:end);
Y_d = Y(1:d:end,1:d:end);


end

