%MADE BY HDTT
%必须是1024*1024的图片
[X,map]=imread('2732x2048-Background-HD-Wallpaper-104.jpg');
%X=X(:,:,2);
X=X(1:1024,1:1024,:);
X_origin=X;
%取绿色单通道
X_mark=X(1:1024,1:1024,2);
%取水印
[marking map]=imread('D:\HDTT\marking\HDTT_water_1024_2.png');
%系数，模式，压缩比例
coff = 4;mode=0;pixel_target=720;
%添加水印
inverse_figure=mark_the_figure_1024(X_mark,marking,coff);
%压缩攻击
inverse_figure_resized=imresize(inverse_figure,pixel_target/1024);    
inverse_figure_resized=imresize(inverse_figure_resized,1024/pixel_target);
%提取水印
marking=decomposed_the_marking_1024(inverse_figure_resized,coff,mode,X_origin(:,:,2));
X(:,:,2)=inverse_figure;

figure,set(gcf,'unit','normalized','position',[0,0,0.9,0.9]);
subplot(1,3,1),imshow(X_origin);title('原图')
subplot(1,3,2),imshow(X);title('加水印后的图');
subplot(1,3,3),imshow(imresize(marking,1024/32));title('提取水印');

%下面是处理视频的废弃代码，用于提取视频帧加水印
%figure,imshow(X)
%{
v = VideoReader('光的波动 ‐ Made with Clipchamp.mp4');
coff = 8;%强度
pixel_target=720;%压缩后的大小
mode=0;%模式,0不使用原图，1使用原图

for i = 1:200:2000
    frame = read(v,i);%读取帧
    
    frame_mark_zone = frame(28:28+1023,448:448+1023,:);%读取1920*1080的1024*1024方块
    frame_mark_zone_marked = frame_mark_zone(:,:,2);%加在2通道上
    %添加水印
    inverse_figure=mark_the_figure_1024(frame_mark_zone_marked,marking,coff);
    %压缩攻击
    inverse_figure_resized=imresize(inverse_figure,pixel_target/1024);    
    inverse_figure_resized=imresize(inverse_figure_resized,1024/pixel_target);
    %提取水印
    marking_inverse=decomposed_the_marking_1024(inverse_figure_resized,coff,mode,frame_mark_zone_marked);
    %figure,imshow(marking_inverse);
    frame_mark_zone(:,:,2)=inverse_figure;
    frame_marked=frame;
    frame_marked(28:28+1023,448:448+1023,:)=frame_mark_zone;
    figure,set(gcf,'unit','normalized','position',[0,0,0.9,0.9]);
    suptitle(["第";string(i);"张"])
    subplot(2,2,3),imshow(frame_marked);title('加水印图')
    subplot(2,2,1),imshow(frame);title('原图')
    subplot(2,2,[2 4]),imshow(imresize(marking_inverse,1024/64));title('提取的水印')
end
%}
