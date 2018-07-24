`timescale 10 ns/1 ns
module bin2dec_duty
(
  input clk_50M, 
  input rst, 
  input [6:0]duty_bin,  
  output reg [7:0] duty_number
);

reg[18:0] temp_duty_bin;

always @ (posedge clk_50M or negedge rst)  begin
    if(!rst) begin
        temp_duty_bin = 0;
        duty_number = 0;
    end
    else if(duty_bin!=0) begin
        temp_duty_bin = 0;
        temp_duty_bin[6:0] = duty_bin;
        repeat(7) begin
            if(temp_duty_bin[10:7]>4)
                temp_duty_bin[10:7] = temp_duty_bin[10:7] + 2'b11;
            if(temp_duty_bin[14:11]>4)
                temp_duty_bin[14:11] = temp_duty_bin[14:11] + 2'b11;
            if(temp_duty_bin[18:15]>4)
                temp_duty_bin[18:15] = temp_duty_bin[18:15] + 2'b11;
            temp_duty_bin = temp_duty_bin<<1;   
        end
        duty_number = temp_duty_bin[14:7];
    end
    else begin
        duty_number = 0;
    end
end
endmodule