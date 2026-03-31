
module Data_Memory(
    input [31:0] Address, Write_data,
    input Mem_Write, Mem_Read, clk,
    output reg [31:0] Read_data
);

reg [7:0] Data_Memory [0:127];

// WRITE (sequential)
always @(posedge clk)
begin
    if (Mem_Write)
    begin
        Data_Memory[Address]   <= Write_data[31:24];
        Data_Memory[Address+1] <= Write_data[23:16];
        Data_Memory[Address+2] <= Write_data[15:8];
        Data_Memory[Address+3] <= Write_data[7:0];
    end
end

// READ (combinational)
always @(*)
begin
    if (Mem_Read)
    begin
        Read_data = {
            Data_Memory[Address],
            Data_Memory[Address+1],
            Data_Memory[Address+2],
            Data_Memory[Address+3]
        };
    end
    else
        Read_data = 32'd0;
end

endmodule
