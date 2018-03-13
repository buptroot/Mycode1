clear all
close all
clc
%均值平滑滤波 线性
I=imread('bigmoon.jpg'); 
imgray=rgb2gray(I)                 %转换为灰度图像
J=imnoise(imgray,'salt',0.02); 

subplot(331);imshow(imgray)
title('灰度图像')
subplot(333);imshow(J) 
title('噪声图像')
K1=filter2(fspecial('average',3),J)/255; 
K2=filter2(fspecial('average',5),J)/255; 
K3=filter2(fspecial('average',7),J)/255; 
subplot(334);imshow(K1) 
title('3*3均值')
subplot(335);imshow(K2) 
title('5*5')
subplot(336);imshow(K3)
title('7*7')
%中值平滑滤波  非线性
K4=ordfilt2(J,5,ones(3,3)); 
K5=ordfilt2(J,5,ones(5,5)); 
K6=ordfilt2(J,5,ones(7,7)); 
subplot(337);imshow(K4) 
title('3*3中值')
subplot(338);imshow(K5) 
title('5*5')
subplot(339);imshow(K6)
title('7*7')




