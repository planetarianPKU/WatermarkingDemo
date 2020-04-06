%load woman
%[X,map]=imread('C:\Users\16000\Desktop\target_figure.png');
%clc
%clear
function [marking_inverse] = decomposed_the_marking_1024(inverse_figure_2,coff,mode,X_origin)

%coff=10;%强度
%两串256长度的随机序列用作密匙
spread_sig_1=coff*[1;1;-1;1;1;-1;-1;1;1;1;1;-1;-1;-1;1;1;-1;1;-1;1;1;1;-1;-1;1;-1;-1;-1;-1;1;1;1;1;-1;1;1;1;-1;1;1;1;1;-1;1;-1;-1;-1;-1;-1;1;-1;-1;-1;-1;-1;-1;1;-1;1;1;-1;1;1;1;1;1;-1;-1;1;1;-1;1;1;1;-1;-1;-1;1;-1;1;1;1;-1;1;-1;-1;1;1;-1;-1;1;-1;1;-1;1;-1;1;-1;-1;1;-1;-1;1;-1;-1;-1;1;-1;1;-1;-1;-1;-1;1;-1;-1;1;1;-1;1;-1;-1;-1;1;1;1;1;1;-1;1;-1;1;1;-1;1;-1;-1;1;-1;1;-1;-1;1;1;1;1;1;1;-1;-1;-1;-1;-1;-1;-1;1;1;-1;1;1;-1;1;-1;1;-1;-1;-1;1;-1;-1;1;-1;1;1;1;1;-1;-1;1;-1;1;1;-1;-1;-1;1;-1;-1;-1;1;1;-1;-1;1;1;-1;-1;-1;1;1;1;-1;-1;-1;-1;1;1;-1;-1;-1;-1;-1;1;1;1;-1;1;1;-1;-1;-1;-1;1;-1;1;-1;1;1;-1;-1;1;-1;-1;1;1;1;-1;-1;1;1;1;-1;1;-1;1;-1;1;1;1;1;1;1;1;1;-1;1]';%[mseq(2,8,1,1);1]';%*[-1;0;0;-1;0;1;0;1;0;1;-1;0;0;0;0;0]';%mseq(2,3,2,1);
spread_sig_2=coff*[1;-1;1;-1;1;1;1;-1;-1;1;1;1;-1;-1;1;-1;-1;1;1;-1;1;-1;1;-1;-1;-1;-1;1;1;-1;1;1;1;-1;-1;-1;-1;-1;1;1;-1;-1;-1;-1;1;1;1;-1;-1;-1;1;1;-1;-1;1;1;-1;-1;-1;1;-1;-1;-1;1;1;-1;1;-1;-1;1;1;1;1;-1;1;-1;-1;1;-1;-1;-1;1;-1;1;-1;1;1;-1;1;1;-1;-1;-1;-1;-1;-1;-1;1;1;1;1;1;1;-1;-1;1;-1;1;-1;-1;1;-1;1;1;-1;1;-1;1;1;1;1;1;-1;-1;-1;1;-1;1;1;-1;-1;1;-1;-1;-1;-1;1;-1;1;-1;-1;-1;1;-1;-1;1;-1;-1;1;-1;1;-1;1;-1;1;-1;-1;1;1;-1;-1;1;-1;1;1;1;-1;1;-1;-1;-1;1;1;1;-1;1;1;-1;-1;1;1;1;1;1;-1;1;1;-1;1;-1;-1;-1;-1;-1;-1;1;-1;-1;-1;-1;-1;1;-1;1;1;1;1;-1;1;1;1;-1;1;1;1;1;-1;-1;-1;-1;1;-1;-1;1;1;1;-1;1;-1;1;1;-1;-1;-1;1;1;1;1;-1;-1;1;1;-1;1;1;-1;1;1;1;1;1;1;1;1;-1;1]';%[mseq(2,8,1,2);1]';%[0;0;1;-1;-1;0;-1;0;1;-1;0;0;0;1;0;1]';%mseq(2,3,2,4);

%单极小波分解
[c_2,s_2]=wavedec2(inverse_figure_2,1,'haar');
[H1_2,V1_2,D1_2] = detcoef2('all',c_2,s_2,1);
A1_2 = appcoef2(c_2,s_2,'haar',1);

sig_decomposed_total_figure=[];

%选择模式，1为原图模式，需要给原图
if mode == 0
    marked_minor=A1_2;

else
    
    [c_origin,s_origin]=wavedec2(X_origin,1,'haar');
    [H1_origin,V1_origin,D1_origin] = detcoef2('all',c_origin,s_origin,1);
    A1_origin = appcoef2(c_origin,s_origin,'haar',1); 
    marked_minor=A1_2-A1_origin;
end
sig_decomposed_total=[];
i=0;
for j = 1:512
sig_decomposed=[];
result_1_all=[];
result_2_all=[];

%用密匙与加水印的图片互相关提取水印
for k = 1:256:512
    result_1=xcorr(marked_minor(i+j,k:k+255),spread_sig_1,0);
    result_2=xcorr(marked_minor(i+j,k:k+255),spread_sig_2,0);
    result_1_all=[result_1_all result_1];
    result_2_all=[result_2_all result_2];

    if abs(result_1)>abs(result_2)
        sig_decomposed=[sig_decomposed 0];
    elseif abs(result_1)<abs(result_2)
        sig_decomposed=[sig_decomposed 255];
    elseif abs(result_1)==abs(result_2)
        sig_decomposed=[sig_decomposed 255];
    end
   
end
sig_decomposed_total=[sig_decomposed_total;sig_decomposed];

end

sig_decomposed_total_figure=[];
for i = 1:32:512
    sig_decomposed_total_figure=[sig_decomposed_total_figure sig_decomposed_total(i:i+31,:)];
end
%figure
marking_inverse=iarnold(sig_decomposed_total_figure,8);
%imshow(marking_inverse)