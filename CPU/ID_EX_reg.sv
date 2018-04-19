///////////////////////////////////////////////////////
// Module Name: ID_EX_eg                            //
// Author: Doug Dresser                            //
// Module Description: Pipeline reg between       //
// the ID and EX stages                         //
////////////////////////////////////////////////
module ID_EX_reg(
    input clk,
    input rst_n,
    input stall,
    input flush,

    // pipeline reg signals,
    input [3:0] reg_dst,
    input [31:0] rd1_bypass,
    input [31:0] rd2_bypass, 
    input [31:0] pc_plus_4,
    input interrupt,
    input [31:0] sign_ext_imm,
    input [3:0] ex_rs1,
    input [3:0] ex_rs2,
    output reg [3:0] reg_dst_out,
    output reg [31:0] rd1_bypass_out,
    output reg [31:0] rd2_bypass_out, 
    output reg [31:0] pc_plus_4_out,
    output reg interrupt_out,
    output reg [31:0] sign_ext_imm_out,
    output reg[3:0] ex_rs1_out,
    output reg [3:0] ex_rs2_out,

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
    output reg [4:0] opcode_out,
    output reg cmp_out,
    output reg returni_out,
    output reg mem_addr_sel_out,
    output reg [1:0] sp_sel_out,
    output reg mem_wr_out,
    output reg wb_sel_out,
    output reg reg_wr_out,
    output reg call_out   
    
);

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        reg_dst_out = 4'd0;
        ex_rs1_out = 4'b0;
        ex_rs2_out = 4'b0;
	rd1_bypass_out = 32'd0;
	rd2_bypass_out = 32'd0;
	pc_plus_4_out = 32'd0;
	interrupt_out = 1'd0;
	sign_ext_imm_out = 32'd0;
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
        ex_rs1_out = 4'b0;
        ex_rs2_out = 4'b0;
        rd1_bypass_out = 32'd0;
	    rd2_bypass_out = 32'd0;
	pc_plus_4_out = 32'd0;
	interrupt_out = 1'd0;
	sign_ext_imm_out = 32'd0;
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
        ex_rs1_out = ex_rs1_out;
        ex_rs2_out = ex_rs2_out;
	rd1_bypass_out = rd1_bypass_out;
	rd2_bypass_out = rd2_bypass_out;
	pc_plus_4_out = pc_plus_4_out;
	interrupt_out = interrupt_out;
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
        ex_rs1_out = ex_rs1;
        ex_rs2_out = ex_rs2;
        rd1_bypass_out = rd1_bypass;
	rd2_bypass_out = rd2_bypass;
	pc_plus_4_out = pc_plus_4;
	interrupt_out = interrupt;
	sign_ext_imm_out = sign_ext_imm;
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
