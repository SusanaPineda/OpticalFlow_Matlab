function [ X_d, Y_d, u_d, v_d ] = Horn_Schunk( alpha, f1, f2, iteraciones,d)
%Calculo del flujo optico mediante el algoritmo de Horn y Schunck

u = zeros(size(f1));
v = zeros(size(f2));

%Calculo de Ix, Iy It de las imagenes completasIx
Ix_f1 = conv2(f1,[-1 0 1; -2 0 2; -1 0 1], 'same'); %Derivada parcial en x con sobel
Iy_f1 = conv2(f1, [-1 -2 -1; 0 0 0 ; 1 2 1], 'same'); %Derivada parcial en y con sobel

Ix_f2 = conv2(f2,[-1 0 1; -2 0 2; -1 0 1], 'same'); %Derivada parcial en x con sobel
Iy_f2 = conv2(f2, [-1 -2 -1; 0 0 0 ; 1 2 1],'same'); %Derivada parcial en y con sobel

Ix = Ix_f1 + Ix_f2;
Iy = Iy_f1 + Iy_f2;

%It = conv2(f1, ones(2), 'same') + conv2(f2, -ones(2), 'same');
It = f1-f2;

mask = [1/9 1/9 1/9; 1/9 1/9 1/9; 1/9 1/9 1/9];

for i = 1:iteraciones
     u_prom = conv2(u, mask, 'same');
     v_prom = conv2(v, mask, 'same');
     
     u =  u_prom - ( Ix .* ((Ix .* u_prom) + (Iy .* v_prom) + It )) ./ ( alpha.^2 + Ix.^2 + Iy.^2);
     v =  v_prom - ( Iy .* ((Ix .* u_prom) + (Iy .* v_prom) + It )) ./ ( alpha.^2 + Ix.^2 + Iy.^2);
end
img_size = size(f1);
u_d = u(1:d:end, 1:d:end);
v_d = v(1:d:end, 1:d:end);

[X,Y] = meshgrid(1:img_size(2), 1:img_size(1));
X_d = X(1:d:end,1:d:end);
Y_d = Y(1:d:end,1:d:end);
end

