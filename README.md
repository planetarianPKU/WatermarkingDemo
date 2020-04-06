# WatermarkingDemo
Use the DWT method to add an watermarking on picture.

这里是HDTT，为了给图片加水印，我开启了这个项目。如果你有问题，请发送邮件至邮箱：HDTT@pku.edu.cn.

add_and_decomposed.m是主程序。

marking_the_figure_1024.m和decomposed_themarking_1024.m是用于在图片中添加水印并从图片中分解水印的功能。

arnold和iarnold是用于进行arnold转换的函数。

图片和水印都必须是1024*1024的图片。

测试图片使用一张深色图和一张浅色图。

测试水印使用二值图片。



The add_and_decomposed.m is the main program.

The marking_the_figure_1024.m and the decomposed_the marking_1024.m is the function which are used to add the watermarking in the picture and decomposed the watermarking from the picture.

The arnold and iarnold are the function used to make arnold transform.

The figure and the watermarking must be the 1024*1024 size.

The test picture uses a dark picture and a light picture.

The test watermark uses binary images.




Citations:

[1] Piotr (2020). Inverse and direct Arnold transform (https://www.mathworks.com/matlabcentral/fileexchange/35144-inverse-and-direct-arnold-transform), MATLAB Central File Exchange. Retrieved April 6, 2020.

[2] Giedrius Buracas (2020). m-sequence generation program (https://www.mathworks.com/matlabcentral/fileexchange/990-m-sequence-generation-program), MATLAB Central File Exchange. Retrieved April 6, 2020.

[3] https://www.mathworks.com/help/wavelet/ref/dwt2.html
