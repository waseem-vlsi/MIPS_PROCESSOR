
`timescale 1ns/1ps

module Reg_file_32_bit_tb();

reg [4:0] rs_1, rs_2, write_address;
reg write_enable, clk, rst;
reg [31:0] write_data;

wire [31:0] rout_1, rout_2;

// Instantiate DUT
Reg_file_32_bit uut (
    .rs_1(rs_1),
    .rs_2(rs_2),
    .write_address(write_address),
    .write_enable(write_enable),
    .clk(clk),
    .rst(rst),
    .write_data(write_data),
    .rout_1(rout_1),
    .rout_2(rout_2)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    // Initialize
    clk = 0;
    write_enable = 0;
    rst = 1;
    write_address = 0;
    write_data = 0;
    rs_1 = 0;
    rs_2 = 0;
    

    // Monitor
    $monitor("Time=%0t | WE=%b WA=%d WD=%d | RS1=%d RS2=%d | R1=%d R2=%d",
              $time, write_enable, write_address, write_data,
              rs_1, rs_2, rout_1, rout_2);

    // ---------------- TEST CASES ---------------- //

    // Write into register 5
    #10;
    rst = 0;
    write_enable = 1;
    write_address = 5;
    write_data = 32'd100;

    // Read from register 5
    #10;
    rst = 0;
    write_enable = 1;
    rs_1 = 5;
    rs_2 = 0;

    // Write into register 10
    #10;
    rst = 0;
    write_enable = 1;
    write_address = 10;
    write_data = 32'd200;

    // Read from register 10 and 5
    #10;
    rst = 0;
    write_enable = 1;
    rs_1 = 10;
    rs_2 = 5;

    // Disable write (should write 0 as per your design)
    #10;
    rst = 0;
    write_enable = 1;
    write_address = 15;

    // Read register 15 (should be 0)
    #10;
    rst = 0;
    rs_1 = 15;
    rs_2 = 10;

    // Multiple writes
    #10;
    rst = 0;
    write_enable = 1;
    write_address = 2;
    write_data = 32'd50;

    #10;
    rst = 0;
    write_address = 3;
    write_data = 32'd75;

    // Read both
    #10;
    rst = 0;
    write_enable = 1;
    rs_1 = 2;
    rs_2 = 3;

    // Finish
    #20;
    $finish;
end

endmodule
