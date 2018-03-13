clear all
close all
clc

% 红外数据的帧结构
% IRIM_WID = 384;
% IRIM_HEI = 288;
FRAME_LEN = 111746;     % 每桢图像包含的word数
FRAME_HEAD_LEN	= 2;
ROW_HEAD_LEN = 2;
ROW_TAIL_LEN = 2;
FRAME_WIDTH = 388;
FRAME_HEIGHT = 288;	

% 取得1点校正数据
fid = fopen('热红外视频_st.dat', 'rb');
stIm = zeros(288, 384);
for i = 1:32,
    % 读出一帧
    tmpIm = fread(fid, FRAME_LEN, 'int16');
    % 去掉枕头
    tmpIm = tmpIm(3:end);
    % 合成图像结构
    tmpIm = reshape(tmpIm, FRAME_WIDTH, FRAME_HEIGHT);
    tmpIm = tmpIm( 3:end-2, :);
    tmpIm = tmpIm';
    stIm = stIm + tmpIm;
end
stIm = stIm/32;



fid = fopen('热红外视频.dat', 'rb');
fseek(fid, 0, 'eof');
fLen = ftell(fid);
frewind(fid);

frameNum = fLen/FRAME_LEN/2;

for i = 1:50,
    % 读出一帧
    tmpIm = fread(fid, FRAME_LEN, 'int16');
    % 去掉枕头
    tmpIm = tmpIm(3:end);
    % 合成图像结构
    tmpIm = reshape(tmpIm, FRAME_WIDTH, FRAME_HEIGHT);
    tmpIm = tmpIm(3:end-2, :);
    tmpIm = double(tmpIm');
    
    % 显示1
    dispIm = tmpIm-min(tmpIm(:));
    dispIm = dispIm/max(dispIm(:));
    dispIm = uint8(floor(dispIm*255.1));
    subplot(221);imshow(uint8(dispIm));
    title('原始图像');
    % 去坏点
    tmpIm(abs(tmpIm)>1.3*mean(tmpIm(:)))=mean(tmpIm(:));
    % 显示2
    dispIm = tmpIm-min(tmpIm(:));
    dispIm = dispIm/max(dispIm(:));
    dispIm = uint8(floor(dispIm*255.1));
    subplot(222);imshow(uint8(dispIm));
    title('去坏点图像');
    
    % 进行一点校正
    tmpIm = tmpIm-stIm;
    tmpIm(abs(tmpIm)>3*mean(tmpIm(:)))=mean(tmpIm(:));
    % 显示3
    tmpIm = tmpIm-min(tmpIm(:));
    tmpIm = tmpIm/max(tmpIm(:));
    tmpIm = uint8(floor(tmpIm*255.1));
    subplot(223);imshow(uint8(tmpIm));
    title('1点校正图像');
    
    
    % 图像增强
    tmpIm = adapthisteq(tmpIm);
    subplot(224);imshow(uint8(tmpIm));
    title('增强图像');
   
    drawnow
end


% 	for(row = 0; row < FRAME_HEIGHT; row ++)
% 		for(col = 2; col < FRAME_WIDTH-2; col ++)
% 			tmpImData_I16[row*IRIM_WID + col-2] =  tmpFrameData_I16[row*FRAME_WIDTH + col + 2];




