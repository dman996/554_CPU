///////////////////////////////////////////////////////
// Module Name: IF_ID_eg                            //
// Author: Doug Dresser                            //
// Module Description: Pipeline reg between       //
// the IF and ID stages                         //
////////////////////////////////////////////////
module IF_ID_reg(
    input clk,
    input rst_n,
    input stall,
    input flush,

    // pipeline reg signals
    input interrupt,
    input [31:0] pc_plus_4,
    input [31:0] instr,
    output reg interrupt_out,
    output reg [31:0] pc_plus_4_out,
    output reg [31:0] instr_out
);

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        interrupt_out = 1'd0;
	pc_plus_4_out = 32'd0;
	instr_out = 32'd0;
    end
    else if(flush) begin
        interrupt_out = 1'd0;
	pc_plus_4_out = 32'd0;
	instr_out = 32'd0;
    end
    else if(stall) begin
        interrupt_out = interrupt_out;
	pc_plus_4_out = pc_plus_4_out;
	instr_out = instr_out;
    end
    else begin
        interrupt_out = interrupt;
	pc_plus_4_out = pc_plus_4;
	instr_out = instr;
    end
end

endmodule

	