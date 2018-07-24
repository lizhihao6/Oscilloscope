`timescale 10 ns/1 ns

module main
(
  input clk_100M, 
  input rst, 
  input sign_in_0,
  input sign_in_1, 
  output [3:0] r,  
  output [3:0] g,  
  output [3:0] b,  
  output hs,  
  output vs,
  output [14:0]temp
);


reg clk_50M;
always @(posedge clk_100M or negedge rst) begin

    if (!rst)
        clk_50M <= 0;
    else
        clk_50M <= ~clk_50M;

end


wire   [27:0] freq_0;  //ﾆｵﾂﾊﾊ莎ﾟ
wire   [31:0] freq_dec_0; //bin2decｺﾖﾎｻﾊｮｽﾆﾆｵﾂﾊﾊ莎ﾟ
wire   [6:0] duty_0; //ﾕｼｿﾕｱﾈﾊ莎ﾟ
wire   [7:0] duty_dec_0; //bin2decｺﾖﾎｻﾊｮｽﾆﾆｵﾂﾊﾊ莎ﾟ
frequency  FreQ_0( 
    .clk_100M(clk_100M),
    .rst(rst),
    .sign_in(sign_in_0),
    .freq(freq_0),
    .duty(duty_0)
);
				  
bin2dec B2D_0(
    .clk_50M(clk_50M),
    .rst(rst),
    .bin(freq_0),
    .number(freq_dec_0),
    .duty_bin(duty_0),
    .duty_number(duty_dec_0)
);


wire   [27:0] freq_1;  //ﾆｵﾂﾊﾊ莎ﾟ
wire   [31:0] freq_dec_1; //bin2decｺﾖﾎｻﾊｮｽﾆﾆｵﾂﾊﾊ莎ﾟ
wire   [6:0] duty_1; //ﾕｼｿﾕｱﾈﾊ莎ﾟ
wire   [7:0] duty_dec_1; //bin2decｺﾖﾎｻﾊｮｽﾆﾆｵﾂﾊﾊ莎ﾟ
frequency  FreQ_1( 
    .clk_100M(clk_100M),
    .rst(rst),
    .sign_in(sign_in_1),
    .freq(freq_1),
    .duty(duty_1)
);
				  
bin2dec B2D_1(
    .clk_50M(clk_50M),
    .rst(rst),
    .bin(freq_1),
    .number(freq_dec_1),
    .duty_bin(duty_1),
    .duty_number(duty_dec_1)
);


wire   [31:0] differ;			
time_difference P_D(
    .clk_100M(clk_100M),
    .rst(rst),
    .sign0(sign_in_0),
    .sign1(sign_in_1),
    .out(differ)
);


vga_char_display VGA(  
    .clk(clk_50M),  
    .rst(rst),
    .f_0(freq_dec_0),
    .duty_0(duty_dec_0),
    .f_1(freq_dec_1),
    .duty_1(duty_dec_1),
    .differ(differ),
    .r(r),  
    .g(g),  
    .b(b),  
    .hs(hs),  
    .vs(vs)  
);  

endmodule