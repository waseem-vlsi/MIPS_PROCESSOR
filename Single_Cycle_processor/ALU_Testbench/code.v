`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2026 20:51:33
// Design Name: 
// Module Name: ALU_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module tb_ALU;

    reg [31:0] A, B;
    reg [3:0] ALU_Ctrl;
    wire [31:0] Result;
    wire Zero;

    ALU uut (
        .A(A),
        .B(B),
        .ALU_Ctrl(ALU_Ctrl),
        .Result(Result),
        .Zero(Zero)
    );

    initial begin

        A = 32'hF0F0F0F0; 
        B = 32'h0F0F0F0F; 
        ALU_Ctrl = 4'b0000;
        #10;
        $display("AND Result = %h (Expected 00000000), Zero=%b", Result, Zero);


        ALU_Ctrl = 4'b0001;
        #10;
        $display("OR Result = %h (Expected FFFFFFFF), Zero=%b", Result, Zero);


        A = 32'd10; 
        B = 32'd20; 
        ALU_Ctrl = 4'b0010;
        #10;
        $display("ADD Result = %d (Expected 30), Zero=%b", Result, Zero);


        A = 32'd50; 
        B = 32'd50; 
        ALU_Ctrl = 4'b0110;
        #10;
        $display("SUB Result = %d (Expected 0), Zero=%b", Result, Zero);


        A = 32'd10; 
        B = 32'd20; 
        ALU_Ctrl = 4'b0111;
        #10;
        $display("SLT Result = %d (Expected 1), Zero=%b", Result, Zero);


        A = 32'd30; 
        B = 32'd20; 
        ALU_Ctrl = 4'b0111;
        #10;
        $display("SLT Result = %d (Expected 0), Zero=%b", Result, Zero);

 
        A = 32'd15; 
        B = 32'd15; 
        ALU_Ctrl = 4'b0110; // SUB
        #10;
        $display("Zero Test: Result=%d, Zero=%b (Expected Zero=1)", Result, Zero);


        ALU_Ctrl = 4'b1111;
        #10;
        $display("Default Result = %d (Expected 0)", Result);

        #10;
        $finish;
    end

endmodule
