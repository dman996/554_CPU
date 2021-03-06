module ID_tb();

reg clk, rst_n;
reg interrupt;
reg [31:0] pc_plus_4;
reg [31:0] instr;
reg wr;
reg [3:0] wr_dst;
reg [31:0] wr_data;

wire [31:0] sign_ext_imm;
wire [3:0] reg_dst;
wire [31:0] rd1_bypass_out;
wire [31:0] rd2_bypass_out;
wire [31:0] pc_plus_4_out;
wire interrupt_out;
wire [31:0] branch_pc;

ID DUT(

	// global signals
	.clk(clk),
	.rst_n(rst_n),

	// from IF_ID Buffer
	.pc_plus_4(pc_plus_4),
	.interrupt(interrupt),
	.instr(instr),

	// from WB Stage
	.wr(wr),
	.wr_dst(wr_dst),
	.wr_data(wr_data),

	// to ID_EX Reg
	.sign_ext_imm(sign_ext_imm),
	.reg_dst(reg_dst),
	.rd1_bypass_out(rd1_bypass_out),
	.rd2_bypass_out(rd2_bypass_out), 
	.pc_plus_4_out(pc_plus_4_out),
	.interrupt_out(interrupt_out),
	
	// to IF
	.branch_pc(branch_pc),
	.branch_sel(branch_sel)
);

always #5 clk = !clk;

initial begin
	
	clk = 1'b0;
	rst_n = 1'b0;

	pc_plus_4 = 32'd20;
	interrupt = 1'b0;
	instr = 32'd0;
	wr = 1'b0;
	wr_dst = 4'b0000;
	wr_data = 32'd0;

	#10;
	
	rst_n = 1'b1;
	#5;

	// read instr
	instr = 32'b0010000100100000000000000000;

	#100;
	$finish;
end
endmodule
