///////////////////////////////////////////////////////
// Module Name: EX_MEM_reg                          //
// Author: Dustin R. Wiczek                        //
// Module Description: This module is for the     //
//  pipeline register between EX and MEM stages  //
//  and includes signals to flush and stall the //
//  values that is holds.                      //
////////////////////////////////////////////////
module EX_MEM_reg(
    input clk,
    input rst_n,
    input stall,
    input flush,
    // pipeline reg signals
    input [31:0] alu_out_in,
    input [3:0] reg_dst_in,
    output reg [31:0] alu_out_out,
    output reg [3:0] reg_dst_out,
    //control signals
    input reg_wr_in,
    input wb_sel_in,
    input mem_addr_sel_in,
    input mem_wr_in,
    input [1:0] sp_select_in,
    output reg reg_wr_out,
    output reg wb_sel_out,
    output reg mem_addr_sel_out,
    output reg mem_wr_out,
    output reg [1:0] sp_select_out
);

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        alu_out_out = 0;
        reg_dst_out = 0;
        reg_wr_out = 0;
        wb_sel_out = 0;
        mem_addr_sel_out = 0;
        mem_wr_out = 0;
        sp_select_out = 0;
    end
    else if(flush) begin
        alu_out_out = 0;
        reg_dst_out = 0;
        reg_wr_out = 0;
        wb_sel_out = 0;
        mem_addr_sel_out = 0;
        mem_wr_out = 0;
        sp_select_out = 0;
    end
    else if(stall) begin
        alu_out_out = alu_out_out;
        reg_dst_out = reg_dst_out;
        reg_wr_out = reg_wr_out;
        wb_sel_out = wb_sel_out;
        mem_addr_sel_out = mem_addr_sel_out;
        mem_wr_out = mem_wr_out;
        sp_select_out = sp_select_out;
    end
    else begin
        alu_out_out = alu_out_in;
        reg_dst_out = reg_dst_in;
        reg_wr_out = reg_wr_in;
        wb_sel_out = wb_sel_in;
        mem_addr_sel_out = mem_addr_sel_in;
        mem_wr_out = mem_wr_in;
        sp_select_out = sp_select_in;
    end
end

endmodule
// line for revision control version 1.1
