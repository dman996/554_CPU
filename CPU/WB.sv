///////////////////////////
// Module Name: WB
// Author: Dustin R. Wiczek
// Module Summary:
//
//////////////////////////
module WB(
    input [31:0] mem_out,
    input [31:0] alu_out,
    input [31:0] pc_plus4,
    input [3:0] reg_dest_in,
    input wb_sel,
    input reg_wr_in,
    input call,
    output [31:0] reg_wr_data,
    output [3:0] reg_dest_out,
    output reg_wr_out
);

//instantiate intermediate wires for inbetween muxes
wire [31:0] mem_or_alu;

//assign passthrough outputs
assign reg_dest_out = reg_dest_in;
assign reg_wr_out = reg_wr_in;

//mux logic
assign mem_or_alu = (wb_sel) ? mem_out : alu_out;
assign reg_wr_data = (call) ? pc_plus4 : mem_or_alu;



endmodule
//Line for revision controll version 1.0
