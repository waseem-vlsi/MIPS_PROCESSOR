`timescale 1ns / 1ps


module ALU (
    input [31:0] A, B,
    input [3:0] ALU_Ctrl,
    output reg [31:0] Result,
    output Zero
);

always @(*) begin
    case (ALU_Ctrl)

        4'b0000: Result = A & B;              // AND
        4'b0001: Result = A | B;              // OR
        4'b0010: Result = A + B;              // ADD
        4'b0110: Result = A - B;              // SUB
        4'b0111: Result = (A < B) ? 32'd1 : 32'd0; // SLT

        default: Result = 32'd0;

    endcase
end

assign Zero = (Result == 32'd0);

endmodule


// -----------------------------ZERO EXTEND --------------------------------//
module zero_extend #(
    parameter N = 16,
    parameter WIDTH = 32
)(
    input [N-1:0] in,
    output [WIDTH-1:0] out
);

assign out = { {(WIDTH-N){1'b0}}, in };

endmodule
