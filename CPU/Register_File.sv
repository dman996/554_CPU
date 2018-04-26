module Register_File(
	input clk,
	input rst_n,

	input [3:0] rd1,
	input [3:0] rd2,

	input [3:0] wr_dst,
	input wr,
	input [31:0] wr_data,
	
	input high,
	input low,

	output [31:0] rd1_out,
	output [31:0] rd2_out
);

reg [31:0] reg_array [0:15];

assign rd1_out = reg_array[rd1];
assign rd2_out = reg_array[rd2];

// write on the clock edge
always_ff @(posedge clk, negedge rst_n) begin
	if (!rst_n) begin
		reg_array[0] = 32'd0;
		reg_array[1] = 32'd0;
		reg_array[2] = 32'd0;
		reg_array[3] = 32'd0;
		reg_array[4] = 32'd0;
		reg_array[5] = 32'd0;
		reg_array[6] = 32'd0;
		reg_array[7] = 32'd0;
		reg_array[8] = 32'd0;
		reg_array[9] = 32'd0;
		reg_array[10] = 32'd0;
		reg_array[11] = 32'd0;
		reg_array[12] = 32'd0;
		reg_array[13] = 32'd0;
		reg_array[14] = 32'd0;
		reg_array[15] = 32'd0;
	end	
	else if (wr)
		if (high)
			reg_array[wr_dst] = (wr_data << 32'd16) | reg_array[wr_dst];
		else if (low)
			reg_array[wr_dst] = (reg_array[wr_dst] << 32'd16) | wr_data;
		else
			reg_array[wr_dst] = wr_data;
end
endmodule


		
		
