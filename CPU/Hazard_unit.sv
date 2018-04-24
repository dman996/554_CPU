module Hazard_unit(

	// hazard condition signals
	input branch_miss,
	input mem_stall,
	input alert,
	input load_hazard,
	input branch_call_jump,

	// outputs to IF_ID Buffer
	output reg flush_if_id,
	output reg stall_if_id,

	// outputs to ID_EX Buffer
	output reg flush_id_ex,
	output reg stall_id_ex,

	// outputs to EX_MEM Buffer	
	output reg flush_ex_mem,
	output reg stall_ex_mem,

	// outputs to MEM_WB Buffer
	output reg flush_mem_wb,
	output reg stall_mem_wb

);


always_comb begin

	// defaults
	flush_if_id = 1'b0;
	stall_if_id = 1'b0;
	flush_id_ex = 1'b0;
	stall_if_id = 1'b0;
	flush_ex_mem = 1'b0;
	stall_ex_mem = 1'b0;
	flush_mem_wb = 1'b0;
	stall_mem_wb = 1'b0;

	// go case by case
	if (alert) begin
		flush_if_id = 1'b1;
	end else if (~branch_miss) begin
		flush_if_id = 1'b1;
		flush_id_ex = 1'b1;
		flush_ex_mem = 1'b1;
	end else if (mem_stall) begin
		stall_if_id = 1'b1;
		stall_id_ex = 1'b1;
		stall_ex_mem = 1'b1;
		stall_mem_wb = 1'b1;
	end else if (load_hazard) begin
		stall_if_id = 1'b1;
		stall_id_ex = 1'b1;
		stall_ex_mem = 1'b1;
	end else if (branch_call_jump) begin
		flush_if_id = 1'b1;
		flush_id_ex = 1'b1;
	end

end
endmodule
