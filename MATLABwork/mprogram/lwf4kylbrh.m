%线性锐化滤波器 
%拉普拉斯变换 
I=imread('saturn.png'); 
h=fspecial('laplacian'); 
I2=filter2(h,I); 
imshow(I) 
figure,imshow(I2) 
%对比度增强锐化滤波器 
h01=fspecial('unsharp',0.5); 
I3=filter2(h01,I)/255; 
figure,imshow(I3) 


%非线性锐化滤波器 
x1=imread('rbc.jpg'); 
figure,imshow(x1) 
h1=fspecial('sobel'); 
j1=filter2(h1,x1); 
figure,imshow(j1) 
j2=conv2(x1,h1); 
figure,imshow(j2) 
h2=fspecial('prewitt'); 
j3=filter2(h2,x1); 
figure,imshow(j3) 
h3=fspecial('log'); 
j4=filter2(h3,x1); 
figure,imshow(j4) 
