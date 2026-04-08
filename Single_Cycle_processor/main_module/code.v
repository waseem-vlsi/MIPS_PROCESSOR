
module main_module(
input clock,reset,enable
    );
    
    
    
    wire [31:0]sum_out, sum_in,w1,instr_out,w3,w4,w5,w8,w10,w11,branch_target,w12,w13,w14,w18,w19,w20,w22;
    wire [15:0]w2;
    wire w9,ALUsrc,w15,w16,w17,w21,w23,w25,w26,w28;
    wire [1:0]w7,w27;
    wire [4:0]w24;
    wire [3:0]w6;
    
    assign w11 = w1 + 32'd4;
     Program_counter pc(.pc_next(w22), .pc(w1), .clk(clock), .rst(reset));
     assign sum_in = w1;
     Instruction_memory_2X32 instr_mem(.read_address(w1), .instruction_out( instr_out));
     mux5bit_2x1 MUX(.A(instr_out[20:16]), .B(instr_out[15:11]), .sel(w23), .out(w24));
     Reg_file_32_bit reg_file(.read_register_1(instr_out[25:21]), .read_register_2(instr_out[20:16]),
                               .write_register(w24), .read_data_1(w3), .read_data_2(w4), .write_data(w18), .clk(clock), .rst(reset),
                                  .write_enable(w28)); 
     zero_extend sget (.in(instr_out[15:0]), .out(w10));                            
     mux_2X1 MUX_0(.A(w4),.B(w10), .sel(ALUsrc), .out(w12)); 
     ALU alu(.A(w3), .B(w12),  .ALU_Ctrl(w6), .Zero(w25), .Result(w13)); 
    
    // assign branch_target = w11 + sum_out + 32'd4;
     shift sl(.in(w10), .out(w19));
     Data_Memory data_mem(.Address(w13), .Write_data(w4), .Read_data(w14),
                            .Mem_Write(w15), .Mem_Read(w16), .clk(clock));
     mux_2X1 MUX_1(.A(w14), .B(w13), .sel(w17), .out(w18));
  
     assign w20 = w11 + w19 ;
     mux_2X1 MUX_2(.A(w11), .B(w20), .sel(w21), .out(w22));
    
     Control_Unit cu(.opcode(instr_out[31:26]), .RegDst(w23), .Branch(w26), .MemRead(w16), .MemtoReg(w17),
                           .ALUOp(w27), .MemWrite(w15), .ALUSrc(ALUsrc), .RegWrite(w28) ); 
      ALU_Control control_alu(.ALUOp(w27), .funct(instr_out[5:0]), .ALU_Ctrl(w6));                      
    assign w21 = w26 & w25;
    
    
endmodule
