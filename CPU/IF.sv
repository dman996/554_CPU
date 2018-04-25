module IF (
	// global signals
	input clk,
	input rst_n,

	// from hazard unit
	input stall,
	input flush_in,
	
	// select signals
	input alert,
	input branch_predict,
	input pcr_take,
	input pci_take,
	input branch_undo,

	// pc values
	input [31:0] branch_pc,
	input [31:0] pc_not_taken,
	input [31:0] pcr,
	
	// mem controller interface
	output [31:0] mem_addr,
	
	// IF/ID buffer interface
	output [31:0] pc_plus_4,
	output interrupt,
	output reg interrupt_mask,

	// to hazard unit
	output flush
	
);

wire [31:0] pc_out, pc_in; // pc reg input and output
wire [31:0] pci_out; // pci reg output

// Next PC Logic
Next_PC_Logic next_pc_logic(
	.clk(clk),
	.rst_n(rst_n),
	.interrupt_mask(interrupt_mask),
	.branch_pc(branch_pc),
	.pc_not_taken(pc_not_taken),
	.pci(pci_out),
	.pcr(pcr),
	.pc(pc_out),
	.pc_plus_4(pc_plus_4),
	.stall(stall),
	.branch_predict(branch_predict),
	.pcr_take(pcr_take),
	.pci_take(pci_take),
	.branch_undo(branch_undo),
	.alert(alert),
	.flush(flush),
	.interrupt(interrupt),
	.pc_out(pc_in)
);

// PCI Register
dff_en pci_ff(
	.clk(clk),
	.rst_n(rst_n),
	.en(interrupt),
	.d(pc_plus_4),
	.q(pci_out)
);

// PC Register
dff_en pc_ff(
	.clk(clk),
	.rst_n(rst_n),
	.en(1'b1),
	.d(pc_in),
	.q(pc_out)
);

// Interrupt Mask
always @(posedge clk, negedge rst_n) begin
	if (!rst_n)
		interrupt_mask <= 1'b0;
	else if (pci_take)
		interrupt_mask <= 1'b0;
	else if (alert)
		interrupt_mask <= 1'b1;
end

// PC + 4 Adder
assign pc_plus_4 = pc_out + 3'd4;

// input to instruction memory address
assign mem_addr = pc_in;

endmodule
