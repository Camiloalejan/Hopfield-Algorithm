clc; clear; close all;

alfa = imread('alfa.png'); alfa = rgb2gray(alfa); L = length(alfa);
alfa = double(alfa); alfa = sgn(alfa); 
beta = imread('beta.png'); beta = rgb2gray(beta);
beta = double(beta); beta = sgn(beta);
psi = imread('psi.png'); psi = rgb2gray(psi);
psi = double(psi); psi = sgn(psi); 
goku = imread('Goku.png'); goku = rgb2gray(goku);
goku = double(goku); goku = sgn(goku); 
gl = imread('gl.png'); gl = rgb2gray(gl);
gl = double(gl); gl = sgn(gl); 
omega = imread('omega.png'); omega = rgb2gray(omega);
omega = double(omega); omega = sgn(omega); 
sups = imread('sups.png'); sups = rgb2gray(sups);
sups = double(sups); sups = sgn(sups); 
batman = imread('Batman.png'); batman = rgb2gray(batman); L = length(batman);
batman = double(batman); batman = sgn(batman); 


[m, n] = size(alfa);
P = [alfa(:), beta(:), sups(:), psi(:), goku(:), gl(:), omega(:), batman(:)]; P = sgn(P);
E = sups;
X = imnoise(E,'salt & pepper');
W = P*pinv(P);
V = Recovery(W, X, m, n);

subplot(1,3,1)
imshow(E,'initialmagnification',3000)
subplot(1,3,2)
imshow(X,'initialmagnification',3000)
subplot(1,3,3)
imshow(V,'initialmagnification',3000)

function V = Recovery(W, St, m, n)
count = 0;
flag = true;
while flag == true
V = sgn(W*St(:));
V = reshape(V,[m,n]);
if St == V
    flag = false;
else
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