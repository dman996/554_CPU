module Next_PC_Logic(
	// global signals
	input clk,
	input rst_n,
	
	// interrupt mask
	input interrupt_mask,
	
	// possible next pc values
	input [31:0] branch_pc,
	input [31:0] pc_not_taken,
	input [31:0] pci,
	input [31:0] pcr,
	input [31:0] pc,
	input [31:0] pc_plus_4,
	
	// select signals
	input stall,
	input branch_predict,
	input pcr_take,
	input pci_take,
	input branch_undo,
	input alert,
	
	// interrupt output
	output interrupt,
	
	// flush the output
	
	// next pc value
	output [31:0] pc_out, // TODO GO RIGHT TO ID STAGE
	
);

// counter
reg [2:0] counter;

// states
localparam S0=1'b0, S1=1'b1;
reg state, next_state;

assign flush

// state ff
always_ff @(posedge clk, negedge rst_n) begin
	if(!rst_n)
		state <= S0;
	else
		state <= next_state;
end


// count 3 cycles for an interrupt state
always_ff @(posedge clk, negedge rst_n) begin
	if(!rst_n)
		counter <= 3'b000;
	else if (state == S1) begin
		counter <= counter + 3'b001;
		if (counter == 3'b011)
			counter <= 3'b000;
	end
end
	

// next state logic
always_comb begin

// default
next_state = S0;

	case(state)

		S0: begin
			if (alert && !interrupt_mask)
				next_state = S1;
			else
				next_state = S0;
		end
		
		S1: begin
			if ()
		end
	endcase
end
if (alert && ~interrupt_mask) begin
	next_state = S1;
end


// output logic
always_comb begin

// defaults
pc_out = pc;

	case(state)
	
		// normal state
		S0: begin

			// priority is important here
			if (stall)
				pc_out = pc;
			else if (branch_undo)
				pc_out = pc_not_taken;
			else if (pcr_take)
				pc_out = pcr;
			else if (branch_predict)
				pc_out = branch_pc;
			else if (pci_take)
				pc_out = pci;
			else
				pc_out = pc_plus_4;
		end
		
		// interrupt state
		S1: begin
		end
	endcase
end
endmodule






