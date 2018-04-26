///////////////////////////////////////////////////////
// Module Name: MEM_WB_reg                          //
// Author: Dustin R. Wiczek                        //
// Module Description: This module is for the     //
//  pipeline register between MEM and WB stages  //
//  and includes signals to flush and stall the //
//  values that is holds.                      //
////////////////////////////////////////////////
module MEM_WB_reg(
    input clk,
    input rst_n,
    input stall,
    input flush,
    // pipeline reg signals
    input [31:0] mem_out_in,
    input [31:0] alu_out_in,
    input [3:0] reg_dst_in,
    input [31:0] pc_plus4_in,
    output reg [31:0] mem_out_out,
    output reg [31:0] alu_out_out,
    output reg [3:0] reg_dst_out,
    output reg [31:0] pc_plus4_out,
    //control signals
    input reg_wr_in,
    input wb_sel_in,
    input call,
	input high_in,
	input low_in,
    output reg reg_wr_out,
    output reg wb_sel_out,
    output reg call_out,
	output reg high_out,
	output reg low_out
);

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        alu_out_out = 0;
        reg_dst_out = 0;
        reg_wr_out = 0;
        wb_sel_out = 0;
        pc_plus4_out = 0;
	call_out = 0;
	mem_out_out = 0;
	high_out = 1'b0;
	low_out = 1'b0;
    end
    else if(flush) begin
        alu_out_out = 0;
        reg_dst_out = 0;
        reg_wr_out = 0;
        wb_sel_out = 0;
        pc_plus4_out = 0;
	call_out = 0;
	mem_out_out = 0;
	high_out = 1'b0;
	low_out = 1'b0;
    end
    else if(stall) begin
        alu_out_out = alu_out_out;
        reg_dst_out = reg_dst_out;
        reg_wr_out = reg_wr_out;
        wb_sel_out = wb_sel_out;
        pc_plus4_out = pc_plus4_out;
	call_out = call_out;
	mem_out_out = mem_out_out;
	high_out = high_out;
	low_out = low_out;
    end
    else begin
        alu_out_out = alu_out_in;
        reg_dst_out = reg_dst_in;
        reg_wr_out = reg_wr_in;
        wb_sel_out = wb_sel_in;
        pc_plus4_out = pc_plus4_in;
 	call_out = call;
	mem_out_out = mem_out_in;
	high_out = high_in;
	low_out = low_in;
    end
end

endmodule
// line for revision control version 1.0
