module instr_staller(
	// global clock and reset
	input clk,
	input rst_n,
	
	// stall from hazard unit
	input stall,

	// instruction from mem controller
	input [31:0] instr_in,
	
	// output
	output [31:0] instr_out
);

reg stall_out;
reg [31:0] instr_stalled;

dff_en inst_ff(
	.clk(clk),
	.rst_n(rst_n),
	.en(stall),
	.d(instr_in),
	.q(instr_stalled)
);

always @(posedge clk, negedge rst_n) begin
	if (!rst_n)
		stall_out = 1'b0;
	else
		stall_out = stall;
end

assign instr_out = stall_out ? instr_stalled : instr_in;

endmodule
