//////////////////////////////////////////////////////
// Module Name: ALU                                //
// Author: Dustin R. Wiczek                       //
// Module Decription: general purpose ALU        //
//  Going to let the synthesizer take the wheel //
//  and see where it takes this                //
////////////////////////////////////////////////
module alu(
    input [31:0] a,
    input [31:0] b,
    input [4:0] opcode,
    output reg [31:0] alu_out,
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

//wires
wire [2:0] op;

opcode_to_aluOP decoder(.opcode(opcode), .aluOP(op));
assign flags[1] = (alu_out == 32'd0) ? 1'b1:1'b0;
assign flags[0] = (alu_out < 32'd0) ? 1'b1:1'b0;
always_comb begin
    if(op==ADDA) begin
        alu_out = a + b;
    end
    else if(op==SUBA) begin
        alu_out = a - b;
        //set flags here or in another always block
    end
    else if(op==MULA) begin
        alu_out = a * b;
    end
    else if(op==DIVA) begin
        alu_out = a / b;
    end
    else if(op==ANDA) begin
        alu_out = a & b;
    end
    else if(op==ORA) begin
        alu_out = a | b;
    end
    else if(op==XORA) begin
        alu_out = a ^ b;
    end
    else if(op==NOTA) begin
        alu_out = !a;
    end
	 else
		alu_out = 32'd0;
end

endmodule
// line for revision controll version 1.0
