

module Reg_file_32_bit(
    input [4:0] read_register_1, read_register_2, write_register,
    input write_enable, clk, rst,
    input [31:0] write_data,
    output [31:0] read_data_1, read_data_2
);

reg [31:0] reg_file [31:0];
integer i;

always @(posedge clk) 
begin
    if (rst) 
    begin
        for (i = 0; i < 32; i = i + 1)
            reg_file[i] <= 32'd0;
    end
    
    else if (write_enable) 
    begin
        reg_file[write_register] <= write_data;
    end
end

assign read_data_1 = reg_file[read_register_1];
assign read_data_2 = reg_file[read_register_2];

endmodule
