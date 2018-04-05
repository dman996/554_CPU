///////////////////////////////////////////////////////
// Module Name: MEM                                 //
// Author: Dustin R. Wiczek                        //
// Module Summary: This module passes signals     //
//  and serves as a waiting period for mem reads //
//////////////////////////////////////////////////
module MEM(
    input [31:0] mem_out_in,
    input [31:0] rs1_in,
    input [31:0] alu_out_in,
    input [31:0] pc_plus4_in,
    input [3:0] reg_dest_in,
    output [31:0] mem_out_out,
    output [31:0] rs1_out,
    output [31:0] alu_out_out,
    output [31:0] pc_plus4_out,
    output [3:0] reg_dest_out,
);

assign mem_out_out = mem_out_in;
assign rs1_out = rs1_in;
assign alu_out_out = alu_out_in;
assign pc_plus4_out = pc_plus4_in;
assign reg_dest_out = reg_dest_in;

endmodule
//Line for revision controll version 1.0
