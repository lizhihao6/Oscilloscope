`timescale 10 ns/1 ns

module _frequency
(
  input clk_100M, rst, sign_in, 
  output [27:0] freq,
  output [6:0] duty
);


reg clk_1Hz;
reg [31:0] clk_count;
parameter CLK_COUNT = 500_000_00; //äťżççćśĺç¨500_000ĺ ĺżŤéĺşŚďźçťźĺçćśĺ?ćšć?500_000_00
always @ (posedge clk_100M or negedge rst) begin
    
    if (!rst) begin
        clk_count  <= 0;
	    clk_1Hz <= 1;
        $monitor("_freq = %d",freq);
    end
    
    else if (clk_count == CLK_COUNT) begin
        clk_count <= 0;
        clk_1Hz <= ~clk_1Hz;
    end
    
    else
        clk_count <= clk_count + 1;

end


reg _sign, last_sign;
reg [31:0] counter;
reg [31:0] max_counter;
always @(posedge clk_100M or negedge rst) begin

    if(!rst) begin
        _sign <= 0;
        last_sign <= 1;
        counter <= 0;
        max_counter <= 0;
    end
 
    else begin
        if(!last_sign & _sign) begin
            max_counter <= counter;
            counter <= 0;
        end
        else begin
            counter <= counter + 1;
        end
    _sign <= sign_in;
    last_sign <= _sign;
    end

end

wire [31:0] freq_out;
assign freq = freq_out[27:0];
div freq_div(
  .a(32'd100_000_000),
  .b(max_counter),
  .clk(clk_100M),
  .out(freq_out)
);




reg clk_s1, clk_s2;
always @ (posedge clk_100M or negedge rst) begin
    
    if (!rst) begin
        clk_s1 <= 0;
        clk_s2 <= 0;
    end

    else begin
        clk_s1 <= clk_1Hz;
        clk_s2 <=  clk_s1;
    end

end


reg [31:0] pos;
reg [31:0] sum;
reg [31:0] maxpos;
reg [31:0] maxsum;
wire isPos;
wire pulse_1Hz =  !clk_s2 & clk_s1;
assign isPos = sign_in & 1;
always @ (posedge clk_100M or negedge rst) begin

    if (!rst) begin
        sum <= 0;
        pos <= 0;
        maxsum <= 0;
        maxpos <= 0;
    end

    else begin
        if (pulse_1Hz) begin
            maxpos = pos;
            maxsum = sum;
            sum = 0;
            pos = 0;
        end
        else begin
            if(isPos)
                pos = pos + 1;
            sum = sum + 1;
        end
    end
    
end

wire [31:0] maxsum_div_100;
div sum_div(
  .a(maxsum),
  .b(32'd100),
  .clk(clk_100M),
  .out(maxsum_div_100)
);

wire [31:0] duty_out;
assign duty = duty_out[6:0];
div duty_div(
  .a(maxpos),
  .b(maxsum_div_100),
  .clk(clk_100M),
  .out(duty_out)
);

endmodule