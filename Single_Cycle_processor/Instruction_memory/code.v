module Instruction_memory_2X32(
    input [31:0]read_address,
    output [31:0]instruction_out);
   
    
reg [7:0] memory [511:0];
    
  initial 
  begin

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
    memory[8]  = 8'b00000010;
    memory[9]  = 8'b00110010;
    memory[10] = 8'b01000000;
    memory[11] = 8'b00100000;

    // Instruction 3 : sw $t0, 1200($t1)
    memory[12] = 8'b10101101;
    memory[13] = 8'b00101000;
    memory[14] = 8'b00000100;
    memory[15] = 8'b10110000;
    
   end

   assign instruction_out = { 
       memory[read_address], 
       memory[read_address+1], 
       memory[read_address+2], 
       memory[read_address+3] 
   }; 
    endmodule
    
    
