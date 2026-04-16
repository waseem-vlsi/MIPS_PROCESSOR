
module mux_2X1 #(
    parameter WIDTH = 32
)(
    input  [WIDTH-1:0] A, B,
    input              sel,
    output [WIDTH-1:0] out
);

assign out = sel ? B : A;

endmodule

