

module Control_Unit(
    input  [5:0] opcode,

    output reg RegDst,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
);

always @(*) begin
    // Default values
    RegDst   = 0;
    Branch   = 0;
    MemRead  = 0;
    MemtoReg = 0;
    ALUOp    = 2'b00;
    MemWrite = 0;
    ALUSrc   = 0;
    RegWrite = 0;

    case(opcode)

        // R-type (ADD, SUB, AND, OR)
        6'b000000: begin
            RegDst   = 1;
            RegWrite = 1;
            ALUOp    = 2'b10;
        end

        // LW
        6'b100011: begin
            ALUSrc   = 1;
            MemtoReg = 1;
            RegWrite = 1;
            MemRead  = 1;
            ALUOp    = 2'b00;
        end

        // SW
        6'b101011: begin
            ALUSrc   = 1;
            MemWrite = 1;
            ALUOp    = 2'b00;
        end

        // BEQ
        6'b000100: begin
            Branch = 1;
            ALUOp  = 2'b01;
        end


    endcase
end

endmodule

module ALU_Control (
    input  [1:0] ALUOp,        // From main control unit
    input  [5:0] funct,        // Instruction[5:0]
    output reg [3:0] ALU_Ctrl  // To ALU
);

always @(*) begin
    case (ALUOp)

        2'b00: ALU_Ctrl = 4'b0010; // ADD (lw, sw)

        2'b01: ALU_Ctrl = 4'b0110; // SUB (beq)

        2'b10: begin               // R-type
            case (funct)
                6'b100000: ALU_Ctrl = 4'b0010; // ADD
                6'b100010: ALU_Ctrl = 4'b0110; // SUB
                6'b100100: ALU_Ctrl = 4'b0000; // AND
                6'b100101: ALU_Ctrl = 4'b0001; // OR
                6'b101010: ALU_Ctrl = 4'b0111; // SLT
                default:   ALU_Ctrl = 4'b0000; // SAFE DEFAULT
            endcase
        end

        default: ALU_Ctrl = 4'b0000; // SAFE DEFAULT

    endcase
end

endmodule
