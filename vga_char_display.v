// vga_char_display.v  
`timescale 10 ns/1 ns
  
module vga_char_display(  
    input clk,  
    input rst,
    input [31:0] f_0,
    input [7:0] duty_0,
    input [31:0] f_1,
    input [7:0] duty_1,
    input [31:0] differ,
    output reg [3:0] r,  
    output reg [3:0] g,  
    output reg [3:0] b,  
    output reg hs,  
    output reg vs  
    );  
    
    parameter H_sync_pulse = 96;
    parameter H_back_porch = 48;
    parameter H_front_porch = 16;
    parameter H_visiable_area = 640;
    parameter H_whole_line = H_sync_pulse+H_back_porch+H_visiable_area+H_front_porch;

    parameter V_sync_pulse = 2;
    parameter V_back_porch = 33;
    parameter V_front_porch = 10;
    parameter V_visiable_area = 480;
    parameter V_whole_frame = V_sync_pulse+V_back_porch+V_visiable_area+V_front_porch;

    // 显示器可显示区域  
    parameter UP_BOUND = V_sync_pulse + V_back_porch;  
    parameter DOWN_BOUND = V_sync_pulse + V_back_porch + V_visiable_area;  
    parameter LEFT_BOUND = H_sync_pulse + H_back_porch;  
    parameter RIGHT_BOUND = H_sync_pulse + H_back_porch + H_visiable_area;  
  
    // 屏幕中的显示区域  
    parameter up_pos_1 = 267;  
    parameter down_pos_1 = 274;  
    parameter left_pos_1 = 457;  
    parameter right_pos_1 = 540;  

    parameter up_pos_2 = 276;  
    parameter down_pos_2 = 283;  
    parameter left_pos_2 = 457;  
    parameter right_pos_2 = 504;  

    parameter up_pos_3 = 285;  
    parameter down_pos_3 = 292;  
    parameter left_pos_3 = 457;  
    parameter right_pos_3 = 540;  

    parameter up_pos_4 = 294;  
    parameter down_pos_4 = 301;  
    parameter left_pos_4 = 457;  
    parameter right_pos_4 = 504;  

    parameter up_pos_5 = 303;  
    parameter down_pos_5 = 310;  
    parameter left_pos_5 = 457;  
    parameter right_pos_5 = 540;  


    reg clk_25M;  
    reg [9:0] hcount, vcount;  
    wire [7:0] p[83:0]; 
    wire [7:0] q[48:0];
    wire [7:0] s[83:0]; 
    wire [7:0] t[48:0];
    wire [7:0] u[83:0];
  
	RAM_set ram_1_F (
        .clk(clk),
        .rst(rst),
        .data(6'b00_1111),
        .col0(p[0]),
        .col1(p[1]),
        .col2(p[2]),
        .col3(p[3]),
        .col4(p[4]),
        .col5(p[5]),
        .col6(p[6])
    );
    RAM_set ram_1_colon (
        .clk(clk),
        .rst(rst),
        .data(6'b11_1111),
        .col0(p[7]),
        .col1(p[8]),
        .col2(p[9]),
        .col3(p[10]),
        .col4(p[11]),
        .col5(p[12]),
        .col6(p[13])
    );
    RAM_set ram_1_7 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_0[31] , f_0[30] , f_0[29] , f_0[28] }),
        .col0(p[14]),
        .col1(p[15]),
        .col2(p[16]),
        .col3(p[17]),
        .col4(p[18]),
        .col5(p[19]),
        .col6(p[20])
    );
    RAM_set ram_1_6 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_0[27] , f_0[26] , f_0[25] , f_0[24] }),
        .col0(p[21]),
        .col1(p[22]),
        .col2(p[23]),
        .col3(p[24]),
        .col4(p[25]),
        .col5(p[26]),
        .col6(p[27])
    );
    RAM_set ram_1_5 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_0[23] , f_0[22] , f_0[21] , f_0[20] }),
        .col0(p[28]),
        .col1(p[29]),
        .col2(p[30]),
        .col3(p[31]),
        .col4(p[32]),
        .col5(p[33]),
        .col6(p[34])
    );
    RAM_set ram_1_4 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_0[19] , f_0[18] , f_0[17] , f_0[16] }),
        .col0(p[35]),
        .col1(p[36]),
        .col2(p[37]),
        .col3(p[38]),
        .col4(p[39]),
        .col5(p[40]),
        .col6(p[41])
    );
    RAM_set ram_1_3 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_0[15] , f_0[14] , f_0[13] , f_0[12] }),
        .col0(p[42]),
        .col1(p[43]),
        .col2(p[44]),
        .col3(p[45]),
        .col4(p[46]),
        .col5(p[47]),
        .col6(p[48])
    );
    RAM_set ram_1_2 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_0[11] , f_0[10] , f_0[9] , f_0[8] }),
        .col0(p[49]),
        .col1(p[50]),
        .col2(p[51]),
        .col3(p[52]),
        .col4(p[53]),
        .col5(p[54]),
        .col6(p[55])
    );
    RAM_set ram_1_1 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_0[7] , f_0[6] , f_0[5] , f_0[4] }),
        .col0(p[56]),
        .col1(p[57]),
        .col2(p[58]),
        .col3(p[59]),
        .col4(p[60]),
        .col5(p[61]),
        .col6(p[62])
    );
    RAM_set ram_1_0 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_0[3] , f_0[2] , f_0[1] , f_0[0] }),
        .col0(p[63]),
        .col1(p[64]),
        .col2(p[65]),
        .col3(p[66]),
        .col4(p[67]),
        .col5(p[68]),
        .col6(p[69])
    );
    RAM_set ram_1_H (
        .clk(clk),
        .rst(rst),
        .data(6'b01_0001),
        .col0(p[70]),
        .col1(p[71]),
        .col2(p[72]),
        .col3(p[73]),
        .col4(p[74]),
        .col5(p[75]),
        .col6(p[76])
    );
    RAM_set ram_1_Z (
        .clk(clk),
        .rst(rst),
        .data(6'b10_0011),
        .col0(p[77]),
        .col1(p[78]),
        .col2(p[79]),
        .col3(p[80]),
        .col4(p[81]),
        .col5(p[82]),
        .col6(p[83])
    );
	RAM_set ram_2_D (
        .clk(clk),
        .rst(rst),
        .data(6'b00_1101),
        .col0(q[0]),
        .col1(q[1]),
        .col2(q[2]),
        .col3(q[3]),
        .col4(q[4]),
        .col5(q[5]),
        .col6(q[6])
    );
    RAM_set ram_2_U (
        .clk(clk),
        .rst(rst),
        .data(6'b01_1110),
        .col0(q[7]),
        .col1(q[8]),
        .col2(q[9]),
        .col3(q[10]),
        .col4(q[11]),
        .col5(q[12]),
        .col6(q[13])
    );
    RAM_set ram_2_T (
        .clk(clk),
        .rst(rst),
        .data(6'b01_1101),
        .col0(q[14]),
        .col1(q[15]),
        .col2(q[16]),
        .col3(q[17]),
        .col4(q[18]),
        .col5(q[19]),
        .col6(q[20])
    );
    RAM_set ram_2_Y (
        .clk(clk),
        .rst(rst),
        .data(6'b10_0010),
        .col0(q[21]),
        .col1(q[22]),
        .col2(q[23]),
        .col3(q[24]),
        .col4(q[25]),
        .col5(q[26]),
        .col6(q[27])
    );
    RAM_set ram_2_colon (
        .clk(clk),
        .rst(rst),
        .data(6'b11_1111),
        .col0(q[28]),
        .col1(q[29]),
        .col2(q[30]),
        .col3(q[31]),
        .col4(q[32]),
        .col5(q[33]),
        .col6(q[34])
    );
    RAM_set ram_2_2 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , duty_0[7] , duty_0[6] , duty_0[5] , duty_0[4] }),
        .col0(q[35]),
        .col1(q[36]),
        .col2(q[37]),
        .col3(q[38]),
        .col4(q[39]),
        .col5(q[40]),
        .col6(q[41])
    );
    RAM_set ram_2_1 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , duty_0[3] , duty_0[2] , duty_0[1] , duty_0[0] }),
        .col0(q[42]),
        .col1(q[43]),
        .col2(q[44]),
        .col3(q[45]),
        .col4(q[46]),
        .col5(q[47]),
        .col6(q[48])
    );

    RAM_set ram_3_F (
        .clk(clk),
        .rst(rst),
        .data(6'b00_1111),
        .col0(s[0]),
        .col1(s[1]),
        .col2(s[2]),
        .col3(s[3]),
        .col4(s[4]),
        .col5(s[5]),
        .col6(s[6])
    );
    RAM_set ram_3_colon (
        .clk(clk),
        .rst(rst),
        .data(6'b11_1111),
        .col0(s[7]),
        .col1(s[8]),
        .col2(s[9]),
        .col3(s[10]),
        .col4(s[11]),
        .col5(s[12]),
        .col6(s[13])
    );
    RAM_set ram_3_7 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_1[31] , f_1[30] , f_1[29] , f_1[28] }),
        .col0(s[14]),
        .col1(s[15]),
        .col2(s[16]),
        .col3(s[17]),
        .col4(s[18]),
        .col5(s[19]),
        .col6(s[20])
    );
    RAM_set ram_3_6 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_1[27] , f_1[26] , f_1[25] , f_1[24] }),
        .col0(s[21]),
        .col1(s[22]),
        .col2(s[23]),
        .col3(s[24]),
        .col4(s[25]),
        .col5(s[26]),
        .col6(s[27])
    );
    RAM_set ram_3_5 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_1[23] , f_1[22] , f_1[21] , f_1[20] }),
        .col0(s[28]),
        .col1(s[29]),
        .col2(s[30]),
        .col3(s[31]),
        .col4(s[32]),
        .col5(s[33]),
        .col6(s[34])
    );
    RAM_set ram_3_4 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_1[19] , f_1[18] , f_1[17] , f_1[16] }),
        .col0(s[35]),
        .col1(s[36]),
        .col2(s[37]),
        .col3(s[38]),
        .col4(s[39]),
        .col5(s[40]),
        .col6(s[41])
    );
    RAM_set ram_3_3 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_1[15] , f_1[14] , f_1[13] , f_1[12] }),
        .col0(s[42]),
        .col1(s[43]),
        .col2(s[44]),
        .col3(s[45]),
        .col4(s[46]),
        .col5(s[47]),
        .col6(s[48])
    );
    RAM_set ram_3_2 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_1[11] , f_1[10] , f_1[9] , f_1[8] }),
        .col0(s[49]),
        .col1(s[50]),
        .col2(s[51]),
        .col3(s[52]),
        .col4(s[53]),
        .col5(s[54]),
        .col6(s[55])
    );
    RAM_set ram_3_1 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_1[7] , f_1[6] , f_1[5] , f_1[4] }),
        .col0(s[56]),
        .col1(s[57]),
        .col2(s[58]),
        .col3(s[59]),
        .col4(s[60]),
        .col5(s[61]),
        .col6(s[62])
    );
    RAM_set ram_3_0 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , f_1[3] , f_1[2] , f_1[1] , f_1[0] }),
        .col0(s[63]),
        .col1(s[64]),
        .col2(s[65]),
        .col3(s[66]),
        .col4(s[67]),
        .col5(s[68]),
        .col6(s[69])
    );
    RAM_set ram_3_H (
        .clk(clk),
        .rst(rst),
        .data(6'b01_0001),
        .col0(s[70]),
        .col1(s[71]),
        .col2(s[72]),
        .col3(s[73]),
        .col4(s[74]),
        .col5(s[75]),
        .col6(s[76])
    );
    RAM_set ram_3_Z (
        .clk(clk),
        .rst(rst),
        .data(6'b10_0011),
        .col0(s[77]),
        .col1(s[78]),
        .col2(s[79]),
        .col3(s[80]),
        .col4(s[81]),
        .col5(s[82]),
        .col6(s[83])
    );
	RAM_set ram_4_D (
        .clk(clk),
        .rst(rst),
        .data(6'b00_1101),
        .col0(t[0]),
        .col1(t[1]),
        .col2(t[2]),
        .col3(t[3]),
        .col4(t[4]),
        .col5(t[5]),
        .col6(t[6])
    );
    RAM_set ram_4_U (
        .clk(clk),
        .rst(rst),
        .data(6'b01_1110),
        .col0(t[7]),
        .col1(t[8]),
        .col2(t[9]),
        .col3(t[10]),
        .col4(t[11]),
        .col5(t[12]),
        .col6(t[13])
    );
    RAM_set ram_4_T (
        .clk(clk),
        .rst(rst),
        .data(6'b01_1101),
        .col0(t[14]),
        .col1(t[15]),
        .col2(t[16]),
        .col3(t[17]),
        .col4(t[18]),
        .col5(t[19]),
        .col6(t[20])
    );
    RAM_set ram_4_Y (
        .clk(clk),
        .rst(rst),
        .data(6'b10_0010),
        .col0(t[21]),
        .col1(t[22]),
        .col2(t[23]),
        .col3(t[24]),
        .col4(t[25]),
        .col5(t[26]),
        .col6(t[27])
    );
    RAM_set ram_4_colon (
        .clk(clk),
        .rst(rst),
        .data(6'b11_1111),
        .col0(t[28]),
        .col1(t[29]),
        .col2(t[30]),
        .col3(t[31]),
        .col4(t[32]),
        .col5(t[33]),
        .col6(t[34])
    );
    RAM_set ram_4_2 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , duty_1[7] , duty_1[6] , duty_1[5] , duty_1[4] }),
        .col0(t[35]),
        .col1(t[36]),
        .col2(t[37]),
        .col3(t[38]),
        .col4(t[39]),
        .col5(t[40]),
        .col6(t[41])
    );
    RAM_set ram_4_1 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , duty_1[3] , duty_1[2] , duty_1[1] , duty_1[0] }),
        .col0(t[42]),
        .col1(t[43]),
        .col2(t[44]),
        .col3(t[45]),
        .col4(t[46]),
        .col5(t[47]),
        .col6(t[48])
    );
    RAM_set ram_5_D (
        .clk(clk),
        .rst(rst),
        .data(6'b00_1101),
        .col0(u[0]),
        .col1(u[1]),
        .col2(u[2]),
        .col3(u[3]),
        .col4(u[4]),
        .col5(u[5]),
        .col6(u[6])
    );
    RAM_set ram_5_colon (
        .clk(clk),
        .rst(rst),
        .data(6'b11_1111),
        .col0(u[7]),
        .col1(u[8]),
        .col2(u[9]),
        .col3(u[10]),
        .col4(u[11]),
        .col5(u[12]),
        .col6(u[13])
    );
    RAM_set ram_5_7 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , differ[31] , differ[30] , differ[29] , differ[28] }),
        .col0(u[14]),
        .col1(u[15]),
        .col2(u[16]),
        .col3(u[17]),
        .col4(u[18]),
        .col5(u[19]),
        .col6(u[20])
    );
    RAM_set ram_5_6 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , differ[27] , differ[26] , differ[25] , differ[24] }),
        .col0(u[21]),
        .col1(u[22]),
        .col2(u[23]),
        .col3(u[24]),
        .col4(u[25]),
        .col5(u[26]),
        .col6(u[27])
    );
    RAM_set ram_5_5 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , differ[23] , differ[22] , differ[21] , differ[20] }),
        .col0(u[28]),
        .col1(u[29]),
        .col2(u[30]),
        .col3(u[31]),
        .col4(u[32]),
        .col5(u[33]),
        .col6(u[34])
    );
    RAM_set ram_5_4 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , differ[19] , differ[18] , differ[17] , differ[16] }),
        .col0(u[35]),
        .col1(u[36]),
        .col2(u[37]),
        .col3(u[38]),
        .col4(u[39]),
        .col5(u[40]),
        .col6(u[41])
    );
    RAM_set ram_5_3 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , differ[15] , differ[14] , differ[13] , differ[12] }),
        .col0(u[42]),
        .col1(u[43]),
        .col2(u[44]),
        .col3(u[45]),
        .col4(u[46]),
        .col5(u[47]),
        .col6(u[48])
    );
    RAM_set ram_5_2 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , differ[11] , differ[10] , differ[9] , differ[8] }),
        .col0(u[49]),
        .col1(u[50]),
        .col2(u[51]),
        .col3(u[52]),
        .col4(u[53]),
        .col5(u[54]),
        .col6(u[55])
    );
    RAM_set ram_5_1 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , differ[7] , differ[6] , differ[5] , differ[4] }),
        .col0(u[56]),
        .col1(u[57]),
        .col2(u[58]),
        .col3(u[59]),
        .col4(u[60]),
        .col5(u[61]),
        .col6(u[62])
    );
    RAM_set ram_5_0 (
        .clk(clk),
        .rst(rst),
        .data({ 1'b0 , 1'b0 , differ[3] , differ[2] , differ[1] , differ[0] }),
        .col0(u[63]),
        .col1(u[64]),
        .col2(u[65]),
        .col3(u[66]),
        .col4(u[67]),
        .col5(u[68]),
        .col6(u[69])
    );
    RAM_set ram_5_L (
        .clk(clk),
        .rst(rst),
        .data(6'b01_0101),
        .col0(u[70]),
        .col1(u[71]),
        .col2(u[72]),
        .col3(u[73]),
        .col4(u[74]),
        .col5(u[75]),
        .col6(u[76])
    );
    RAM_set ram_5_S (
        .clk(clk),
        .rst(rst),
        .data(6'b01_1100),
        .col0(u[77]),
        .col1(u[78]),
        .col2(u[79]),
        .col3(u[80]),
        .col4(u[81]),
        .col5(u[82]),
        .col6(u[83])
    );
      
    // 获得像素时钟25MHz  
    always @ (posedge clk or negedge rst) begin  
        if (!rst)  
            clk_25M <= 0;  
        else  
            clk_25M = ~clk_25M;
    end  
    
    // 产生H时钟
    always @(posedge clk_25M or negedge rst) begin
        if(!rst) begin
            hcount <= 0;
            hs <= 0;
        end
        else begin
            if ( hcount <= H_sync_pulse-1)begin
                hs <= 0;
                hcount <= hcount + 1;
            end
            else if (hcount == H_whole_line-1)begin
                hcount <= 0;
            end
            else begin
                hs <= 1;
                hcount <= hcount + 1;
            end
        end
    end

    // 产生V时钟
    always @(negedge hs or negedge rst) begin
        if(!rst) begin
            vcount <= 0;
            vs <= 0;
        end
        else begin
            if ( vcount <= V_sync_pulse-1) begin
                vs <= 0;
                vcount <= vcount + 1;
            end
            else if (vcount == V_whole_frame-1) begin
                vcount <= 0;
            end
            else begin
                vs <= 1;
                vcount <= vcount + 1;
            end
        end
    end

      
    // 设置显示信号值  
    always @ (posedge clk_25M or negedge rst)  
    begin  
        if (!rst) begin  
            r <= 0;  
            g <= 0;  
            b <= 0;  
        end  
        else if (vcount>=UP_BOUND && vcount<=DOWN_BOUND  
                && hcount>=LEFT_BOUND && hcount<=RIGHT_BOUND) begin  
            if (vcount>=up_pos_1 && vcount<=down_pos_1  
                    && hcount>=left_pos_1 && hcount<=right_pos_1) begin  
                if (p[hcount-left_pos_1][vcount-up_pos_1]) begin  
                    r <= 4'b1111;  
                    g <= 4'b1111;  
                    b <= 4'b1111;  
                end  
                else begin  
                    r <= 4'b0000;  
                    g <= 4'b0000;  
                    b <= 4'b0000;  
                end  
            end
            else if (vcount>=up_pos_2 && vcount<=down_pos_2  
                    && hcount>=left_pos_2 && hcount<=right_pos_2) begin  
                if (q[hcount-left_pos_2][vcount-up_pos_2]) begin
                    r <= 4'b1111;  
                    g <= 4'b1111;  
                    b <= 4'b1111;  
                end  
                else begin  
                    r <= 4'b0000;  
                    g <= 4'b0000;  
                    b <= 4'b0000;  
                end  
            end
            else if (vcount>=up_pos_3 && vcount<=down_pos_3  
                    && hcount>=left_pos_3 && hcount<=right_pos_3) begin  
                if (s[hcount-left_pos_3][vcount-up_pos_3]) begin
                    r <= 4'b1111;  
                    g <= 4'b1111;  
                    b <= 4'b1111;  
                end  
                else begin  
                    r <= 4'b0000;  
                    g <= 4'b0000;  
                    b <= 4'b0000;  
                end  
            end    
            else if (vcount>=up_pos_4 && vcount<=down_pos_4  
                    && hcount>=left_pos_4 && hcount<=right_pos_4) begin  
                if (t[hcount-left_pos_4][vcount-up_pos_4]) begin
                    r <= 4'b1111;  
                    g <= 4'b1111;  
                    b <= 4'b1111;  
                end  
                else begin  
                    r <= 4'b0000;  
                    g <= 4'b0000;  
                    b <= 4'b0000;  
                end  
            end     
            else if (vcount>=up_pos_5 && vcount<=down_pos_5  
                    && hcount>=left_pos_5 && hcount<=right_pos_5) begin  
                if (u[hcount-left_pos_5][vcount-up_pos_5]) begin
                    r <= 4'b1111;  
                    g <= 4'b1111;  
                    b <= 4'b1111;  
                end  
                else begin  
                    r <= 4'b0000;  
                    g <= 4'b0000;  
                    b <= 4'b0000;  
                end  
            end     
            else begin  
                r <= 4'b0000;  
                g <= 4'b0000;  
                b <= 4'b0000;  
            end  
        end  
        else begin  
            r <= 4'b0000;  
            g <= 4'b0000;  
            b <= 4'b0000;  
        end  
    end  
  
endmodule  