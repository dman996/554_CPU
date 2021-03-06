module Next_PC_Logic_tb();

reg  clk, rst_n;
reg interrupt_mask, stall, branch_predict, pcr_take, pci_take, branch_undo, alert;
reg [31:0] branch_pc, pc_not_taken, pci, pcr, pc, pc_plus_4;

wire interrupt;
wire [31:0] pc_out;

// Next PC Logic DUT
Next_PC_Logic DUT(
	.clk(clk),
	.rst_n(rst_n),
	.interrupt_mask(interrupt_mask),
	.branch_pc(branch_pc),
	.pc_not_taken(pc_not_taken),
	.pci(pci),
	.pcr(pcr),
	.pc(pc),
	.pc_plus_4(pc_plus_4),
	.stall(stall),
	.branch_predict(branch_predict),
	.pcr_take(pcr_take),
	.pci_take(pci_take),
	.branch_undo(branch_undo),
	.alert(alert),
	.interrupt(interrupt),
	.pc_out(pc_out)
);

// clock generator
always #5 clk = !clk;

// always move pc
always @(posedge clk) begin
	pc = pc_plus_4;
end

assign pc_plus_4 = pc + 4;

// begin test bench here
initial begin
	// globals
	clk = 1'b0;
	rst_n = 1'b0;

	// select signals
	interrupt_mask = 1'b0;
	stall = 1'b0;
	branch_predict= 1'b0;
	pcr_take = 1'b0;
	pci_take = 1'b0;
	branch_undo = 1'b0;
	alert = 1'b0;

	// next pc values
	branch_pc = 32'd10;
	pc_not_taken = 32'd20;
	pci = 32'd30;
	pcr = 32'd40;
	pc = 32'd0;

	#10;

	// stop reseting 
	rst_n = 1;
	#5;

	// try stall
	stall = 1'b1;
	#20;

	// try branch predict
	stall = 1'b0;
	branch_predict = 1'b1;
	#20;

	// try pcr take
	branch_predict = 1'b0;
	pcr_take = 1'b1;
	#20;

	// try pci take
	pcr_take = 1'b0;
	pci_take = 1'b1;
	#20;

	// try branch undo
	pci_take = 1'b0;
	branch_undo = 1'b1;
	#20;

	// put interrupt stuff here
	branch_undo = 1'b0;
	alert = 1'b1;
	#10;
	alert = 1'b0;
	#100;

	$finish;

end

endmodule
