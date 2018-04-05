module IF (
	// global signals
	input clk,
	input rst_n,
	
	// interrupt
	input alert,
	
	// mem controller interface
	output [31:0] mem_addr,
	input [31:0] mem_out,
	
	// IF/ID buffer interface
	output [31:0] instr,
	output [31:0] pc_plus_4,
	output interrupt
	
);

wire [31:0] pc_out, pc_in; // pc reg input and output
wire [31:0] pci_out; // pci reg output

// Next PC Logic
Next_PC_Logic next_pc_logic(
	.out(pc_in),
	.interrupt(interrupt)
);

// PCI Register
FF_en pci_ff(
	.clk(clk),
	.rst_n(rst_n),
	.en(),
	.in(),
	.out(pci_out)
);

// PC Register
FF_en pc_ff(
	.clk(clk),
	.rst_n(rst_n),
	.en(),
	.in(pc_in),
	.out(pc_out)
);

// PC + 4 Adder
assign pc_plus_4 = pc_out + 3'd4;

// input to instruction memory address
assign mem_addr = pc_in;

endmodule