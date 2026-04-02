
// -------------------------------------------2X1 mux

module mux_2X1 #(
    parameter WIDTH = 32
)(
    input  [WIDTH-1:0] A, B,
    input              sel,
    output [WIDTH-1:0] out
);

assign out = sel ? B : A;

endmodule


// --------------------------------------8X1 MUX

module mux_8X1 #(
    parameter WIDTH = 32
)(
    input  [WIDTH-1:0] A, B, C, D, E,
    input  [2:0]       sel,
    output reg [WIDTH-1:0] out
);

always @(*) begin
    case (sel)
        3'b000: out = A;
        3'b001: out = B;
        3'b010: out = C;
        3'b011: out = D;
        3'b100: out = E;
        default: out = {WIDTH{1'b0}};
    endcase
end

endmodule

module mux5bit_2x1 (
    input  [4:0] A, B,
    input        sel,
    output [4:0] out
);

assign out = sel ? B : A;

endmodule


