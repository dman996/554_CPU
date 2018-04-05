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
    output [31:0] alu_out,
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
localparam BEQ  = 5'b00010;
localparam BLT  = 5'b00010;
localparam BGT  = 5'b00010;
localparam BNE  = 5'b00010;














endmodule
// line for revision controll version 1.0
