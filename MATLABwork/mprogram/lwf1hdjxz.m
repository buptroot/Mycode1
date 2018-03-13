clear all
close all
clc
%线性变换增加对比度
X1=imread('picture1.jpg'); 
figure,imshow(X1) 
J=imadjust(X1,[0.2,0.6],[],1.2) 
figure,imshow(J)
%图像反转
f1=200; 
g1=256; 
figure,plot([0,f1],[g1,0]) 
axis tight,xlabel('f'),ylabel('g') 
title('intensity transformation') 
 
k=g1/f1;
xgray=rgb2gray(X1)
[m,n]=size(xgray); 
X2=double(xgray); 
for i=1:m 
    for j=1:n 
        f=X2(i,j); 
        g(i,j)=0; 
        if(f>=0)&(f<=f1) 
            g(i,j)=g1-k*f; 
        else 
            g(i,j)=0; 
        end 
    end 
end 
figure,imshow(mat2gray(g))
%对数变换
X2=imread('picture2.png'); 
figure,imshow(X2) 
J2=imadjust(X2,[],[0.1 0.8],0.35287) 
figure,imshow(J2)


