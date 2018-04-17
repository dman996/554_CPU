///////////////////////////////////////////////////////
// Module Name: ID_EX_eg                            //
// Author: Doug Dresser                            //
// Module Description: Pipeline reg between       //
// the ID and EX stages                         //
////////////////////////////////////////////////
module MEM_WB_reg(
    input clk,
    input rst_n,
    input stall,
    input flush,

    // pipeline reg signals,
    input [3:0] reg_dst,
    input [31:0] rd1_bypass_out,
    input [31:0] rd2_bypass_out, 
    input [31:0] pc_plus_4_out,
    input interrupt_out,
    input [31:0] sign_ext_imm_out,
    output reg [3:0] reg_dst_out,
    output reg [31:0] rd1_bypass_out_out,
    output reg [31:0] rd2_bypass_out_out, 
    output reg [31:0] pc_plus_4_out_out,
    output reg interrupt_out_out,
    output reg [31:0] sign_ext_imm_out_out;

    //control signals
    input [4:0] opcode_in,
    input cmp_in,
    input returni_in,
    input mem_addr_sel_in,
    input [1:0] sp_sel_in,
    input mem_wr_in,
    input wb_sel_in,
    input reg_wr_in,
    input call_in,
    output [4:0] opcode_out,
    output cmp_out,
    output returni_out,
    output mem_addr_sel_out,
    output [1:0] sp_sel_out,
    output mem_wr_out,
    output wb_sel_out,
    output reg_wr_out,
    output call_out   
    
);

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        reg_dst_out = 4'd0;
	rd1_bypass_out_out = 32'd0;
	rd2_bypass_out_out = 32'd0;
	pc_plus_4_out_out = 32'd0;
	interrupt_out_out = 1'd0;
	sign_ext_imm_out_out = 32'd0;
	opcode_out = 5'd0;
	cmp_out = 1'd0;
	returni_out = 1'd0;
	mem_addr_sel_out = 1'd0;
	sp_sel_out = 2'd0;
	mem_wr_out = 1'd0;
	wb_sel_out = 1'd0;
	reg_wr_out = 1'd0;
	call_out = 1'd0;
	
    end
    else if(flush) begin
        reg_dst_out = 4'd0;
	rd1_bypass_out_out = 32'd0;
	rd2_bypass_out_out = 32'd0;
	pc_plus_4_out_out = 32'd0;
	interrupt_out_out = 1'd0;
	sign_ext_imm_out_out = 32'd0;
	opcode_out = 5'd0;
	cmp_out = 1'd0;
	returni_out = 1'd0;
	mem_addr_sel_out = 1'd0;
	sp_sel_out = 2'd0;
	mem_wr_out = 1'd0;
	wb_sel_out = 1'd0;
	reg_wr_out = 1'd0;
	call_out = 1'd0;
    end
    else if(stall) begin
        reg_dst_out = reg_dst_out;
	rd1_bypass_out_out = rd1_bypass_out_out;
	rd2_bypass_out_out = rd2_bypass_out_out;
	pc_plus_4_out_out = pc_plus_4_out_out;
	interrupt_out_out = interrupt_out_out;
	opcode_out = opcode_out;
	cmp_out = cmp_out;
	returni_out = returni_out;
	mem_addr_sel_out = mem_addr_sel_out;
	sp_sel_out = sp_sel_out;
	mem_wr_out = mem_wr_out;
	wb_sel_out = wb_sel_out;
	reg_wr_out = reg_wr_out;
	call_out = call_out;
    end
    else begin
        reg_dst_out = reg_dst;
	rd1_bypass_out_out = rd1_bypass_out;
	rd2_bypass_out_out = rd2_bypass_out;
	pc_plus_4_out_out = pc_plus_4_out;
	interrupt_out_out = interrupt_out;
	sign_ext_imm_out_out = sign_ext_imm_out;
	opcode_out = opcode_in;
	cmp_out = cmp_in;
	returni_out = returni_in;
	mem_addr_sel_out = mem_addr_sel_in;
	sp_sel_out = sp_sel_in;
	mem_wr_out = mem_wr_in;
	wb_sel_out = wb_sel_in;
	reg_wr_out = reg_wr_in;
	call_out = call_in;
    end
end

endmodule
