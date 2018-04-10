module Register_File(
	input clk,
	input rst_n,

	input [2:0] rd1,
	input [2:0] rd2,

	input [2:0] wr_dst,
	input wr,
	input [31:0] wr_data,

	output [31:0] rd1_out,
	output [31:0] rd2_out
);

reg [31:0] [0:15] reg_array;

assign rd1_out = reg_array[rd1];
assign rd2_out = reg_array[rd2];

// write on the clock edge
always_ff @(posedge clk, negedge rst_n) begin
	if (!rst_n)
		reg_array = 0;
	else if (wr)
		reg_array[wr_dst] = wr_data;
end
endmodule


		
		
