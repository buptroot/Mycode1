clear all
close all
clc
%直方图均衡化
I=imread('tire.jpg'); 
x1=rgb2gray(I)      
figure,imshow(x1)
j=histeq(x1)
figure,imshow(j)
figure,imhist(j,64)
figure,imhist(x1,64)
%直方图规定化
hgram=100:255
J=histeq(x1,hgram); 
figure,imshow(J) 
figure,imhist(x1,64) 
figure,imhist(J,64)