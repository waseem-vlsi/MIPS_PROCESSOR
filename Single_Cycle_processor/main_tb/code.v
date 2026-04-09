
module tb_main_module();

reg clock;
reg reset;
reg enable;

// Instantiate DUT
main_module uut (
    .clock(clock),
    .reset(reset),
    .enable(enable)
);

// ================= CLOCK =================
always #5 clock = ~clock;   // 10ns clock period

// ================= INITIAL =================
initial begin
    // Initialize
    clock = 0;
    reset = 1;
    enable = 0;

    // Apply reset
    #10;
    reset = 0;
    enable = 1;

    // Run simulation
    #200;

    $finish;
end

// ================= MONITOR =================
initial begin
    $monitor("Time=%0t | PC=%h | Instr=%h | ALU=%h | MemData=%h | WriteData=%h",
              $time,
              uut.w1,          // PC
              uut.instr_out,   // Instruction
              uut.w13,         // ALU result
              uut.w14,         // Memory read
              uut.w18          // Write back
    );
end

endmodule
