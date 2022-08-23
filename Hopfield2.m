clc; clear; close all;

alfa = imread('alfa.png'); alfa = rgb2gray(alfa); L = length(alfa);
alfa = double(alfa); alfa = sgn(alfa); alfav = reshape(alfa,[1,L*L]);
beta = imread('beta.png'); beta = rgb2gray(beta);
beta = double(beta); beta = sgn(beta); betav = reshape(beta,[1,L*L]);
% psi = imread('psi.png'); psi = rgb2gray(psi);
% psi = double(psi); psi = sgn(psi); psiv = reshape(psi,[1,L*L]);
% phi = imread('Phi.jpg'); phi = rgb2gray(phi);
% phi = double(phi); phi = sgn(phi); phiv = reshape(phi,[1,L*L]);
% dseta = imread('dseta.png'); dseta = rgb2gray(dseta);
% dseta = double(dseta); dseta = sgn(dseta); dsetav = reshape(dseta,[1,L*L]); 
% omega = imread('omega.png'); omega = rgb2gray(omega); L = length(omega);
% omega = double(omega); omega = sgn(omega); omegav = reshape(omega,[1,L*L]); %Inicialización de Prototipos

D = diag(alfav); %Identidad

W = (alfav'*alfav - D) + (betav'*betav - D) ; %Aprendizaje
E = beta; %Entrada con Ruido
X = imnoise(E,'salt & pepper',1); X = sgn(X); Xv = reshape(X,[1,L*L]);
St = Xv*W;
St = sgn(St); %Función Bipolar
count = 0;
aux = 0;
while aux == 0
    V = sgn(St*W);
    aux = isequal(St,V);
    if aux == 0
        St = V;
    end
    count = count+1;
    S = reshape(V,[L,L]);
end
% V = Recovery(W, V); %Funcion Hopfield
% V = sgn(V);
% V = reshape(V,[L,L]); %Reconstruyendo Matriz

subplot(1,3,1)
imshow(E,'initialmagnification',3000)
subplot(1,3,2)
imshow(X,'initialmagnification',3000)
subplot(1,3,3)
imshow(S,'initialmagnification',3000)


function St = Recovery(W, St)
count = 0;
aux = 0;
while aux == 0
    V = sgn(St*W);
    aux = isequal(St,V);
    if aux == 0
        St = V;
    end
    count = count+1;
end
end

function W = sgn(W)
[m, n] = size(W);
for i = 1:m
    for j = 1:n
        if W(i,j) > 0
            W(i,j) = 1;
        else
            W(i,j) = -1;
        end
    end
end
end