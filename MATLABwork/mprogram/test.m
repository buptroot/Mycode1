clear all
close all
clc

% �������ݵ�֡�ṹ
% IRIM_WID = 384;
% IRIM_HEI = 288;
FRAME_LEN = 111746;     % ÿ��ͼ�������word��
FRAME_HEAD_LEN	= 2;
ROW_HEAD_LEN = 2;
ROW_TAIL_LEN = 2;
FRAME_WIDTH = 388;
FRAME_HEIGHT = 288;	

% ȡ��1��У������
fid = fopen('�Ⱥ�����Ƶ_st.dat', 'rb');
stIm = zeros(288, 384);
for i = 1:32,
    % ����һ֡
    tmpIm = fread(fid, FRAME_LEN, 'int16');
    % ȥ����ͷ
    tmpIm = tmpIm(3:end);
    % �ϳ�ͼ��ṹ
    tmpIm = reshape(tmpIm, FRAME_WIDTH, FRAME_HEIGHT);
    tmpIm = tmpIm( 3:end-2, :);
    tmpIm = tmpIm';
    stIm = stIm + tmpIm;
end
stIm = stIm/32;



fid = fopen('�Ⱥ�����Ƶ.dat', 'rb');
fseek(fid, 0, 'eof');
fLen = ftell(fid);
frewind(fid);

frameNum = fLen/FRAME_LEN/2;

for i = 1:50,
    % ����һ֡
    tmpIm = fread(fid, FRAME_LEN, 'int16');
    % ȥ����ͷ
    tmpIm = tmpIm(3:end);
    % �ϳ�ͼ��ṹ
    tmpIm = reshape(tmpIm, FRAME_WIDTH, FRAME_HEIGHT);
    tmpIm = tmpIm(3:end-2, :);
    tmpIm = double(tmpIm');
    
    % ��ʾ1
    dispIm = tmpIm-min(tmpIm(:));
    dispIm = dispIm/max(dispIm(:));
    dispIm = uint8(floor(dispIm*255.1));
    subplot(221);imshow(uint8(dispIm));
    title('ԭʼͼ��');
    % ȥ����
    tmpIm(abs(tmpIm)>1.3*mean(tmpIm(:)))=mean(tmpIm(:));
    % ��ʾ2
    dispIm = tmpIm-min(tmpIm(:));
    dispIm = dispIm/max(dispIm(:));
    dispIm = uint8(floor(dispIm*255.1));
    subplot(222);imshow(uint8(dispIm));
    title('ȥ����ͼ��');
    
    % ����һ��У��
    tmpIm = tmpIm-stIm;
    tmpIm(abs(tmpIm)>3*mean(tmpIm(:)))=mean(tmpIm(:));
    % ��ʾ3
    tmpIm = tmpIm-min(tmpIm(:));
    tmpIm = tmpIm/max(tmpIm(:));
    tmpIm = uint8(floor(tmpIm*255.1));
    subplot(223);imshow(uint8(tmpIm));
    title('1��У��ͼ��');
    
    
    % ͼ����ǿ
    tmpIm = adapthisteq(tmpIm);
    subplot(224);imshow(uint8(tmpIm));
    title('��ǿͼ��');
   
    drawnow
end


% 	for(row = 0; row < FRAME_HEIGHT; row ++)
% 		for(col = 2; col < FRAME_WIDTH-2; col ++)
% 			tmpImData_I16[row*IRIM_WID + col-2] =  tmpFrameData_I16[row*FRAME_WIDTH + col + 2];




