%频域增强
%低通滤波 
I=imread('saturn.png'); 
figure,imshow(I) 
I2=imnoise(I,'salt'); 
figure,imshow(I2) 
f=double(I2); 
g=fft2(f); 
g=fftshift(g); 
[N1,N2]=size(g); 
n=2; 
d0=50; n1=fix(N1/2); 
n2=fix(N2/2); 
for i=1:N1 
    for j=1:N2 
        d=sqrt((i-n1)^2+(j-n2)^2); 
        h=1/(1+0.414*(d/d0)^(2*n)); 
        result(i,j)=h*g(i,j); 
    end 
end 
 
result=ifftshift(result); 
X2=ifft2(result); 
X3=uint8(real(X2)); 
figure,imshow(X3) 
%高通滤波) 
I=imread('picture2.png'); 
figure,imshow(I) 
f=double(I); 
g=fft2(f); 
g=fftshift(g); 
[N1,N2]=size(g); 
n=2; 
d0=50; 
n1=fix(N1/2); 
n2=fix(N2/2); 
for i=1:N1 
    for j=1:N2 
        d=sqrt((i-n1)^2+(j-n2)^2); 
        if d==0             h=0; 
        else 
            h=1/(1+(d0/d)^(2*n)); 
        end 
        result(i,j)=h*g(i,j); 
    end 
end 
result=ifftshift(result); 
X2=ifft2(result); 
X3=uint8(real(X2)); 
figure,imshow(X3) 