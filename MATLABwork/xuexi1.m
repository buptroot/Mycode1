% clear all
% close all
% clc
% x1=imread('picture2.jpg')
% figure,imshow(x1)
% j=imadjust(x1,[0.25,0.6],[],1.2322)
% figure,imshow(j)

clear all
close all
clc
x1=imread('picture2.jpg')
figure,imshow(x1)
j=histeq(x1)
figure,imshow(j)
figure,imhist(j,64)
figure,imhist(x1,64)