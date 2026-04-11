
module Instruction_memory_2X32(
    input  [31:0] read_address,
    output [31:0] instruction_out
);

reg [7:0] memory [0:4095];

// ================= INIT =================
integer i;
initial begin
    // ✅ Initialize ALL memory to 0 (NOP safety)
    for (i = 0; i < 4096; i = i + 1)
        memory[i] = 8'b00000000;

    // -------- PROGRAM --------

    // Instruction 0 : lw $t0, 1200($t1)
    memory[0] = 8'b10001101;
    memory[1] = 8'b00101000;
    memory[2] = 8'b00000100;
    memory[3] = 8'b10110000;

    // Instruction 1 : lw $t1, 1200($t1)
    memory[4] = 8'b10001101;
    memory[5] = 8'b00101001;
    memory[6] = 8'b00000100;
    memory[7] = 8'b10110000;

    // Instruction 2 : add $t0, $s1, $s2
    memory[8]  = 8'b00000001;
    memory[9]  = 8'b00001001;
    memory[10] = 8'b01010000;
    memory[11] = 8'b00100000;

    // Instruction 3 : sw $t0, 1200($t1)
    memory[12] = 8'b10101100;
    memory[13] = 8'b00101010;
    memory[14] = 8'b00000100;
    memory[15] = 8'b10110000;

memory[16] = 8'b00000001;
memory[17] = 8'b00101010;
memory[18] = 8'b01000000;
memory[19] = 8'b00100000;

memory[20]   = 8'b10101101;
memory[21] = 8'b00101000;
memory[22] = 8'b00000100;
memory[23] = 8'b10110000;

    // ✅ Optional extra instructions (avoid PC going into garbage)
    // NOP = 32'b0
    memory[24] = 8'b00000000;
    memory[25] = 8'b00000000;
    memory[26] = 8'b00000000;
    memory[27] = 8'b00000000;

end

// ================= READ =================
// Word-aligned access (IMPORTANT FIX)
wire [31:0] addr;
assign addr = read_address;

// Safe read (avoid X)
assign instruction_out = (addr < 4092) ? 
    { memory[addr], memory[addr+1], memory[addr+2], memory[addr+3] } 
    : 32'b0;
endmodule
endmodule
