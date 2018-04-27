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
	output reg interrupt,
	
	// flush the output
	output reg flush,
	
	// next pc value
	output reg [31:0] pc_out,
	output reg [31:0] pci_out,
	output pci_save
	
);

// counter
reg [2:0] counter;

// states
localparam S0=2'b00, S1=2'b01, SR=2'b10;
reg [1:0] state, next_state;

assign flush = (state == S1);

// state ff
always_ff @(posedge clk, negedge rst_n) begin
	if(!rst_n)
		state <= SR;
	else
		state <= next_state;
end


// count 3 cycles for an interrupt state
always_ff @(posedge clk, negedge rst_n) begin
	if(!rst_n)
		counter <= 3'b000;
	else if (state == S0) 
		counter <= 3'b000;
	else if (state == S1) begin
		counter <= counter + 3'b001;
	end
end
	

// next state logic
always_comb begin

// default
next_state = S0;

	case(state)
	
		SR: begin
			next_state = S0;
		end

		S0: begin
			if (alert && !interrupt_mask)
				next_state = S1;
		end
		
		S1: begin
			if (counter != 3'b011)
				next_state = S1;
		end
	endcase
end

assign pci_save = alert || branch_undo || pcr_take || branch_predict;
		
always_comb begin

	pci_out = pc_plus_4;
	
	case(state)
	
		SR: begin
			pci_out = pc_plus_4;
		end
		S0: begin
			pci_out = pc_plus_4;
		end
		S1: begin
			if (branch_undo)
				pci_out = pc_not_taken;
			else if (pcr_take)
				pci_out = pcr;
			else if (branch_predict)
				pci_out = branch_pc;
		end
	endcase
end
			


// output logic
always_comb begin

// defaults
pc_out = pc;
interrupt = 1'b0;

	case(state)
	
		// reset state
		SR: begin
			pc_out = pc;
		end
	
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
			if (counter == 3'b011) begin
				interrupt = 1'b1;
				pc_out = 32'd4096;
			end
		end
	endcase
end
endmodule






