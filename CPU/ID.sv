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
	input [31:0] wr_data,

	// to ID_EX Reg
	output reg [31:0] sign_ext_imm,
	output reg [3:0] reg_dst,
	output reg [3:0] ex_rs1,
    output reg [3:0] ex_rs2,
    output [31:0] rd1_bypass_out,
	output [31:0] rd2_bypass_out, 
	output [31:0] pc_plus_4_out,
	output interrupt_out,
   	output cmp_out,
    	output returni_out,
    	output mem_addr_sel_out,
    	output [1:0] sp_sel_out,
    	output mem_wr_out,
    	output wb_sel_out,
    	output reg_wr_out,
    	output call_out,  
	output [4:0] opcode,
 
	// to IF
	output [31:0] branch_pc,
	output branch_sel
);

wire [31:0] rd1_out, rd2_out;

// control wires
wire [1:0] imm_sel;
wire branch_type;
wire [1:0] reg_dst_sel;

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

//Assign values from reg sel for forward unit in ex stage
assign ex_rs1 = instr[27:24];
assign ex_rs2 = instr[23:20];

// Bypass Logic
assign rd1_bypass_sel = (instr[27:24] == wr_dst) && wr;
assign rd2_bypass_sel = (instr[23:20] == wr_dst) && wr;
assign rd1_bypass_out = rd1_bypass_sel ? wr_data : rd1_out;
assign rd2_bypass_out = rd2_bypass_sel ? wr_data : rd2_out;

// Sign Extend Immediate
always_comb begin
	if(imm_sel == 2'b00)
		sign_ext_imm = {{15{instr[15]}},instr[15:0]};
	else if (imm_sel == 2'b01)
		sign_ext_imm = {{12{instr[18]}},instr[18:0]};
	else
		sign_ext_imm = {{5{instr[26]}},instr[26:0]};
end

// Reg Write Destination Mux
always_comb begin
	if(reg_dst_sel == 2'b00) 
		reg_dst = instr[27:24];
	else if (reg_dst_sel == 2'b01)
		reg_dst = instr[23:20];
	else
		reg_dst = instr[19:16];
end

// Branch Logic
assign branch_pc = sign_ext_imm + (branch_type ? pc_plus_4 : 32'd0);

// Pass opcode through for the alu
assign opcode = instr[31:27];

// Control block
Control_Unit cntrl(
	.opcode(instr[31:27]),
	.imm_sel(imm_sel),
	.branch_type(branch_type),
	.branch_sel(branch_sel),
	.reg_dst_sel(reg_dst_sel)
);

endmodule
