module IF_tb();

reg  clk, rst_n;
reg stall, branch_predict, pcr_take, pci_take, branch_undo, alert;
reg [31:0] branch_pc, pc_not_taken, pcr;

wire interrupt, interrupt_mask;
wire [31:0] mem_addr, pc_plus_4;

IF DUT(
	.clk(clk),
	.rst_n(rst_n),
	.alert(alert),
	.stall(stall),
	.branch_predict(branch_predict),
	.pcr_take(pcr_take),
	.pci_take(pci_take),
	.branch_undo(branch_undo),
	.branch_pc(branch_pc),
	.pc_not_taken(pc_not_taken),
	.pcr(pcr),
	.mem_addr(mem_addr),
	.pc_plus_4(pc_plus_4),
	.interrupt(interrupt),
	.interrupt_mask(interrupt_mask)
);

always #5 clk = !clk;

initial begin
	// global signals
	clk = 1'b0;
	rst_n = 1'b0;
	
	// select signals
	alert = 1'b0;
	stall = 1'b0;
	branch_predict = 1'b0;
	pcr_take = 1'b0;
	pci_take = 1'b0;
	branch_undo = 1'b0;

	// pc values
	branch_pc = 32'd10;
	pc_not_taken = 32'd20;
	pcr = 32'd30;
	
	#10;

	// reset goes low
	rst_n = 1'b1;
	#5;

	// watch for normal behavior
	#20

	// stall
	stall = 1'b1;
	#20;

	// predict a branch
	stall = 1'b0;
	branch_predict = 1'b1;
	#20;

	branch_predict = 1'b0;
	pcr_take = 1'b1;
	#20;

	pcr_take = 1'b0;
	pci_take = 1'b1;
	#20;

	pci_take = 1'b0;
	alert = 1'b1;
	#10;

	alert = 1'b0;

	// wait it out
	#20;
	pci_take = 1'b1;
	#10;
	pci_take = 1'b0;
	#100;
	$finish;
end

endmodule
