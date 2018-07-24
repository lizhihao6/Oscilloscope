`timescale 10 ns/1 ns

module bin2dec
(
    input clk_50M, 
    input rst, 
    input [27:0]bin,
    input [6:0] duty_bin,
    output reg [31:0] number,
    output reg [7:0] duty_number
);


reg[63:0] temp_bin;
reg[18:0] temp_duty_bin;
always @ (posedge clk_50M or negedge rst) begin

    if(!rst) begin
        temp_bin = 64'b0;
        number = 32'b0;
        
        temp_duty_bin = 19'b0;
        duty_number = 8'b0;
        $monitor("number = %b",number);
    end
    
    else if(bin || duty_bin) begin
        temp_bin = 64'b0;
        temp_bin[27:0] = bin;
        repeat(28) begin
                if(temp_bin[28+3:28]>4)
                    temp_bin[28+3:28] = temp_bin[28+3:28] + 2'b11;
                if(temp_bin[32+3:32]>4)
                    temp_bin[32+3:32] = temp_bin[32+3:32] + 2'b11;
                if(temp_bin[36+3:36]>4)
                    temp_bin[36+3:36] = temp_bin[36+3:36] + 2'b11;
                if(temp_bin[40+3:40]>4)
                    temp_bin[40+3:40] = temp_bin[40+3:40] + 2'b11;
                if(temp_bin[44+3:44]>4)
                    temp_bin[44+3:44] = temp_bin[44+3:44] + 2'b11;                            
                if(temp_bin[48+3:48]>4)
                    temp_bin[48+3:48] = temp_bin[48+3:48] + 2'b11;                            
                if(temp_bin[52+3:52]>4)
                    temp_bin[52+3:52] = temp_bin[52+3:52] + 2'b11;      
                if(temp_bin[56+3:56]>4)
                    temp_bin[56+3:56] = temp_bin[56+3:56] + 2'b11;      
                if(temp_bin[60+3:60]>4)
                    temp_bin[60+3:60] = temp_bin[60+3:60] + 2'b11;                                                                                           
            temp_bin = temp_bin<<1;
            end
        number = temp_bin[59:28];
        
        temp_duty_bin = 19'b0;
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
        number = 0;
        duty_number = 0;    
    end

end


endmodule