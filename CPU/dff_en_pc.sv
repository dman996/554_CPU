module dff_en_pc(
	input clk,
	input rst_n,
	input en,
	input [31:0] d,
	output reg [31:0] q
);

always @(posedge clk, negedge rst_n) begin
	if (!rst_n)
		q <= 32'd0;
	else if (en)
		q <= d;
	else
		q <= q;
end

endmodule
