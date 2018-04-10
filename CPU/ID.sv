module ID(

	// global signals
	input clk,
	input rst_n,

	// from IF_ID Buffer
	input [31:0] pc_plus_4,
	input interrupt,
	input [31:0] instr,

	// from WB Stage
	input wr,
	input [3:0] wr_dst,
	input [31:0] wr_data

	// to ID_EX Reg
	output [31:0] sign_ext_imm,
	output [3:0] reg_dst_sel,
	output [31:0] rd1_bypass_out,
	output [31:0] rd2_bypass_out, 
	output [31:0] pc_plus_4_out,
	output interrupt_out
);

wire [31:0] rd1_out, rd2_out;

// Register File
Register_File rf(
	.clk(clk),
	.rst_n(rst_n),
	.rd1(instr[27:24]),
	.rd2(instr[23:20]),
	.wr(wr),
	.wr_dst(wr_dst),
	.wr_data(wr_data),
	.rd1_out(rd1_out),
	.rd2_out(rd2_out)
);

// Bypass Logic
assign rd1_bypass_sel = (instr[27:24] == wr_dst) && wr;
assign rd2_bypass_sel = (instr[23:20] == wr_dst) && wr;
assign rd1_bypass_out = rd1_bypass_sel ? wr_data : rd1_out;
assign rd2_bypass_out = rd2_bypass_sel ? wr_data : rd2_out;

// Sign Extend Immediate
always_comb begin
	if(imm_sel == 2'b00)
		sign_ext_imm = {15{instr[15]},instr[15:0]};
	else if (imm_sel == 2'b01)
		sign_ext_imm = {12{instr[18]},instr[18:0]};
	else
		sign_ext_imm = {5{instr[26]},instr{26:0]};
end

// Reg Write Destination Mux
always_comb begin
	if(reg_dst_sel == 2'b00) 
		reg_dst = 

endmodule
