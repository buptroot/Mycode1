clear all
close all
clc
%��ֵƽ���˲� ����
I=imread('bigmoon.jpg'); 
imgray=rgb2gray(I)                 %ת��Ϊ�Ҷ�ͼ��
J=imnoise(imgray,'salt',0.02); 

subplot(331);imshow(imgray)
title('�Ҷ�ͼ��')
subplot(333);imshow(J) 
title('����ͼ��')
K1=filter2(fspecial('average',3),J)/255; 
K2=filter2(fspecial('average',5),J)/255; 
K3=filter2(fspecial('average',7),J)/255; 
subplot(334);imshow(K1) 
title('3*3��ֵ')
subplot(335);imshow(K2) 
title('5*5')
subplot(336);imshow(K3)
title('7*7')
%��ֵƽ���˲�  ������
K4=ordfilt2(J,5,ones(3,3)); 
K5=ordfilt2(J,5,ones(5,5)); 
K6=ordfilt2(J,5,ones(7,7)); 
subplot(337);imshow(K4) 
title('3*3��ֵ')
subplot(338);imshow(K5) 
title('5*5')
subplot(339);imshow(K6)
title('7*7')




