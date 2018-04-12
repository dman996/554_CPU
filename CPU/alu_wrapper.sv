//////////////////////////////////////////////////////
// Module Name: ALU_wrapper                        //
// Author: Dustin R. Wiczek                       //
// Module Decription: wrapper for the alu to     //
//  allow the inputs to be swapped depending    //
//  on the opcode                              //
////////////////////////////////////////////////
module alu_wrapper(
    input [31:0] a,
    input [31:0] b,
    input [31:0] imm,
    input [4:0] opcode,
    output [31:0] out,
    output [1:0] flags
);
localparam ADD  = 5'b00010;
localparam ADDI = 5'b00011;
localparam SUB  = 5'b00100;
localparam SUBI = 5'b00101;
localparam MUL  = 5'b00110;
localparam DIV  = 5'b01000;
localparam AND  = 5'b01010;
localparam ANDI = 5'b01011;
localparam OR   = 5'b01100;
localparam ORI  = 5'b01101;
localparam NOT  = 5'b01110;
localparam XOR  = 5'b10000;
localparam XORI = 5'b10001;
localparam CMP  = 5'b10010;
localparam BEQ  = 5'b00010;
localparam BLT  = 5'b00010;
localparam BGT  = 5'b00010;
localparam BNE  = 5'b00010;
localparam MOVEH = 	5'b00111;
localparam CALL = 5'b11001;
localparam RET = 5'b11010;
localparam RETI = 5'b11011;
localparam ST = 5'b11100;
localparam LD = 5'b11101;
localparam MOVEL = 5'b11110;


//ALU Opcodes
localparam ADDA  = 3'b000;
localparam SUBA  = 3'b001;
localparam MULA  = 3'b010;
localparam DIVA  = 3'b011;
localparam ANDA  = 3'b100;
localparam ORA   = 3'b101;
localparam XORA  = 3'b110;
localparam NOTA  = 3'b111;


//regs for testing
reg [31:0] a_final, b_final, tmp;
wire [31:0] alu_output;
assign out = alu_output;
alu ALU(
    .a(a_final),
    .b(b_final),
    .opcode(opcode),
    .alu_out(alu_output),
    .flags(flags)
);
always @(*) begin
    if(opcode==ST) begin
        a_final = b;
        b_final = imm;
    end
    else if(opcode==LD|opcode==ADDI|opcode==SUBI|opcode==ANDI|opcode==ORI|
            opcode==XORI) begin
        a_final = a;
        b_final = imm;
    end
    else if(opcode==MOVEL) begin
        a_final = imm;
        b_final = 32'h0000ffff;
    end
    else if(opcode==MOVEH) begin
        a_final = imm;
        b_final = 32'hffff0000;
    end
    else begin
        a_final = a;
        b_final = b;
    end
end
endmodule
//line for revision control version 1.0
