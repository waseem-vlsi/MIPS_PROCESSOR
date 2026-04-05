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



module ALU_tb;

parameter WIDTH = 8;

reg  [WIDTH-1:0] A, B;
reg  Alu_control;
reg  [1:0] alu_control;
wire [WIDTH-1:0] result;
wire Cout;

ALU #(WIDTH) uut (
    .A(A),
    .B(B),
    .Alu_control(Alu_control),
    .alu_control(alu_control),
    .result(result),
    .Cout(Cout)
);

initial begin

    $monitor("Time=%0t | A=%d B=%d | Alu_ctrl=%b alu_ctrl=%b | Result=%d Cout=%b",
              $time, A, B, Alu_control, alu_control, result, Cout);


    // ADD
    A = 8'd10; B = 8'd5;
    Alu_control = 0; alu_control = 2'b00;
    #10;

    // SUB (using ~A + B logic)
    A = 8'd10; B = 8'd5;
    Alu_control = 1; alu_control = 2'b00;
    #10;

    // AND
    A = 8'd12; B = 8'd10;
    Alu_control = 0; alu_control = 2'b01;
    #10;

    // OR
    A = 8'd12; B = 8'd10;
    Alu_control = 0; alu_control = 2'b10;
    #10;
    A = 8'd0; B = 8'b10110011;
    Alu_control = 0; alu_control = 2'b11;
    #10;

    A = 8'd25; B = 8'd17;
    Alu_control = 0; alu_control = 2'b00; // ADD
    #10;

    A = 8'd25; B = 8'd17;
    Alu_control = 0; alu_control = 2'b01; // AND
    #10;

    A = 8'd25; B = 8'd17;
    Alu_control = 0; alu_control = 2'b10; // OR
    #10;

    #10;
    $finish;

end

endmodule
