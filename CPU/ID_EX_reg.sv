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
    
);

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        reg_dst_out = 4'd0;
	rd1_bypass_out_out = 32'd0;
	rd2_bypass_out_out = 32'd0;
	pc_plus_4_out_out = 32'd0;
	interrupt_out_out = 1'd0;
	sign_ext_imm_out_out = 32'd0;
    end
    else if(flush) begin
        reg_dst_out = 4'd0;
	rd1_bypass_out_out = 32'd0;
	rd2_bypass_out_out = 32'd0;
	pc_plus_4_out_out = 32'd0;
	interrupt_out_out = 1'd0;
	sign_ext_imm_out_out = 32'd0;
    end
    else if(stall) begin
        reg_dst_out = reg_dst_out;
	rd1_bypass_out_out = rd1_bypass_out_out;
	rd2_bypass_out_out = rd2_bypass_out_out;
	pc_plus_4_out_out = pc_plus_4_out_out;
	interrupt_out_out = interrupt_out_out;
    end
    else begin
        reg_dst_out = reg_dst;
	rd1_bypass_out_out = rd1_bypass_out;
	rd2_bypass_out_out = rd2_bypass_out;
	pc_plus_4_out_out = pc_plus_4_out;
	interrupt_out_out = interrupt_out;
	sign_ext_imm_out_out = sign_ext_imm_out;
    end
end

endmodule
