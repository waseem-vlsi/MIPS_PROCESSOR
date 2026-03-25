module Program_counter(
    input [31:0]pc_next,
    input clk,rst,
    output reg [31:0]pc
    );
    
    always@(posedge clk)
    begin
    if(rst)
    pc <= 32'd0;
    else
    pc <= pc_next;
    end
endmodule
