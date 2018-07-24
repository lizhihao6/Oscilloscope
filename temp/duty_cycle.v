`timescale 10 ns/1 ns

module duty_cycle(
    input clk_50M,
    input sign_in,
    input rst,
    output reg [6:0] out
    );
    
reg[31:0] sum;
reg[31:0] pos;
wire isPos;
reg[4:0] zero;
reg lastPos;

//除法ip核调用设定
reg[31:0] maxsum;
reg[31:0] maxpos;
wire[31:0] divout;

assign isPos = sign_in & 1;

div duty_div(
    .a(maxpos),
    .b(maxsum),
    .clk_50M(clk_50M),
    .out(divout)
);

div duty_div (
    .aclk(clk_50M),                                      // input wire aclk
    .s_axis_divisor_tvalid(zero[4]),    // input wire s_axis_divisor_tvalid
  .s_axis_divisor_tdata(maxsum),      // input wire [63 : 0] s_axis_divisor_tdata
  .s_axis_dividend_tvalid(zero[4]),  // input wire s_axis_dividend_tvalid
  .s_axis_dividend_tdata(maxpos),    // input wire [63 : 0] s_axis_dividend_tdata
  .m_axis_dout_tvalid(dout_tvalid),          // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(divout)            // output wire [127 : 0] m_axis_dout_tdata
);

always @(posedge clk_50M or negedge rst) begin
    if(!rst) begin
        out = 0;
        sum = 0;
        pos = 0;
        maxpos = 0;
        maxsum = 0;
    end
    else begin
        if (dout_tvalid) begin
            out = divout[70:64];
        end
        if(zero>15) begin //十六个sign_in周期的占空比平均
            if(sum!=0) begin

            end
            pos = 0;
            sum = 0;
        end
        else begin
            sum = sum + 1;
            if(isPos)
                pos = pos + 1;
        end
    end
end

always @(posedge clk_50M or negedge rst) begin //清零信号
    if(!rst) begin
        zero = 0;
        lastPos = 0;
     end
     else begin
        if ( !lastPos && isPos ) begin
            zero = zero + 1;
        end
        else if (zero == 16)
            zero = 0;
        else
            zero = zero;
        lastPos = isPos;
     end
end

endmodule
