///////
// Module Name Opcode to aluOP
// Author: Dustin
// Module Description: This module takes the from the
//  decode stage and generates the aluopcode needed
////////
module opcode_to_aluOP(
    input [4:0] opcode,
    output reg [2:0] aluOP
);
//CPU opcodes
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

always @(*)begin
    if(opcode==ADD | opcode==ADDI | opcode==LD | opcode==ST)
        aluOP = ADDA;
    else if(opcode==SUB | opcode==SUBI | opcode==CMP)
        aluOP = SUBA;
    else if(opcode==MUL)
        aluOP = MULA;
    else if(opcode==DIV)
        aluOP = DIVA;
    else if(opcode==AND | opcode==ANDI | opcode==MOVEH | opcode==MOVEL)
        aluOP = ANDA;
    else if(opcode==OR | opcode==ORI)
        aluOP = ORA;
    else if(opcode==XOR | opcode==XORI)
        aluOP = XORA;
    else if(opcode==NOT)
        aluOP = NOTA;
	else
		aluOP = ADDA;




end
endmodule
// line for revision controll version 1.0
