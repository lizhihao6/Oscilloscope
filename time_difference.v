`timescale 10 ns/1 ns

module time_difference(
    input clk_100M,
    input rst,
    input sign0,
    input sign1,
    output reg [31:0] out
);


reg _sign0, _sign1;
always @(posedge clk_100M or negedge rst) begin
    
    if (!rst) begin
        _sign0 <= 0;
        _sign1 <= 0;
    end
    
    else begin
        _sign0 <= sign0;
        _sign1 <= sign1;
    end    
    
end


wire isPos0 = _sign0 & 1;
wire isPos1 = _sign1 & 1;
reg last0;
reg last1;
reg count_en;
always @(posedge clk_100M or negedge rst) begin
    
    if (!rst) begin
        last0 <= 1;
        last1 <= 1;
        count_en <= 0;
    end
    
    else begin
        if(!last0 && isPos0)
            count_en <= 1;
        else if(!last1 && isPos1)
            count_en <= 0;
        else
            count_en <= count_en;
        last0 <= isPos0;
        last1 <= isPos1;
    end
    
end


reg [26:0] differ;
reg [31:0] counter;
reg last_en;
always @(posedge clk_100M or negedge rst) begin

    if (!rst) begin
        differ <= 0;
        counter <= 0;
        last_en <= 0;
    end

    else begin
        if(last_en && !count_en) begin
            differ <= counter;
            counter <= 0;
        end
        else if(count_en)
            counter <= counter + 1;
        else
            differ <= differ;
        last_en <= count_en ;
    end
end


reg[58:0] temp_bin;
always @ (posedge clk_100M or negedge rst) begin

    if(!rst) begin
        temp_bin = 0;
        out = 0;
    end
    
    else if(differ!=0) begin
        temp_bin = 0;
        temp_bin[26:0] = differ;
        repeat(27) begin
                if(temp_bin[27+3:27]>4)
                    temp_bin[27+3:27] = temp_bin[27+3:27] + 2'b11;
                if(temp_bin[31+3:31]>4)
                    temp_bin[31+3:31] = temp_bin[31+3:31] + 2'b11;
                if(temp_bin[35+3:35]>4)
                    temp_bin[35+3:35] = temp_bin[35+3:35] + 2'b11;
                if(temp_bin[39+3:39]>4)
                    temp_bin[39+3:39] = temp_bin[39+3:39] + 2'b11;
                if(temp_bin[43+3:43]>4)
                    temp_bin[43+3:43] = temp_bin[43+3:43] + 2'b11;                            
                if(temp_bin[47+3:47]>4)
                    temp_bin[47+3:47] = temp_bin[47+3:47] + 2'b11;                            
                if(temp_bin[51+3:51]>4)
                    temp_bin[51+3:51] = temp_bin[51+3:51] + 2'b11;      
                if(temp_bin[55+3:55]>4)
                    temp_bin[55+3:55] = temp_bin[55+3:55] + 2'b11;                                                                                             
            temp_bin = temp_bin<<1;
            end
        out = temp_bin[58:27];
    end
    
    else
        out = 0;

end


endmodule
