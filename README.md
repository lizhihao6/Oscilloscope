# 频率计
## 文件说明
frequencey.v  
频率和占空比部分，可以根据频率大小，自动切换采样方法以提高精度，输出频率的二进制

bin2dec.v    
把输出的频率转换为十进制，并把十进制的每一位转换为四位二进制表示，便于后续VGA显示

main.v    
把各个模块整合

RAM_set.v    
VGA显示的内存初始化

time_difference.v    
计算两路同频率输入的时间差（相位差）

vga_char_display.v     
vga字符显示