/////////////////////////////////////////////////////////////
// Module Name: Branch Logic testbench                    //
// Author: Dustin R. Wiczek                              //
// Module Summary: testbench for branch logic           //
/////////////////////////////////////////////////////////
module Branch_logic_t();   
//local params
localparam BEQ = 5'b10011;
localparam BLT = 5'b10100;
localparam BGT = 5'b10101;
localparam BNE = 5'b10110;
//regs and wires for testing
reg clk, rst_n;
reg [1:0] flags;
reg [4:0] opcode;
reg out;
reg err;
Branch_logic DUT(
    .clk(clk),
    .rst_n(rst_n),
    .opcode(opcode),
    .flags(flags),
    .pc_branch_sel_out(out)
);   

always @(posedge err)begin
	if(err) begin
		$display("Error when processing flags = %B ", flags);
		$write(" and opcode %B", opcode);
        $stop;
	end
end

always begin
    #1 clk = ~clk;
end
initial begin
    clk = 1; 
    rst_n = 0;
    //first testing BEQ
	opcode = BEQ;
    flags = 2'b10;
    repeat (5) @(posedge clk);
    rst_n = 1;
	repeat (2) @(posedge clk);
	if(out != 1)begin
		err = 1;
		//$stop;
	end
	flags = 2'b11;
	repeat (2) @(posedge clk);
	if(out != 1)begin
		err = 1;
		//$stop;
	end
	flags = 2'b01;
	repeat (2) @(posedge clk);
	if(out != 0)begin
		err = 1;
		//$stop;
	end
	flags = 2'b00;
	repeat (2) @(posedge clk);
	if(out != 0)begin
		err = 1;
		//$stop;
	end
	//next testing BNE
	opcode = BNE;
	flags = 2'b01;
	repeat (2) @(posedge clk);
	if(out != 1)begin
		err = 1;
		//$stop;
	end
	flags = 2'b00;
	repeat (2) @(posedge clk);
	if(out != 1)begin
		err = 1;
		//$stop;
	end
	flags = 2'b11;
	repeat (2) @(posedge clk);
	if(out != 0)begin
		err = 1;
		//$stop;
	end
	flags = 2'b10;
	repeat (2) @(posedge clk);
	if(out != 0)begin
		err = 1;
		//$stop;
	end
	//next testing BLT
	opcode = BLT;
	flags = 2'b01;
	repeat (2) @(posedge clk);
	if(out != 1)begin
		err = 1;
		//$stop;
	end
	flags = 2'b11;
	repeat (2) @(posedge clk);
	if(out != 1)begin
		err = 1;
		//$stop;
	end
	flags = 2'b10;
	repeat (2) @(posedge clk);
	if(out != 0)begin
		err = 1;
		//$stop;
	end
	flags = 2'b00;
	repeat (2) @(posedge clk);
	if(out != 0)begin
		err = 1;
		//$stop;
	end
	//next testing BGT
	opcode = BGT;
	flags = 2'b00;
	repeat (2) @(posedge clk);
	if(out != 1)begin
		err = 1;
		//$stop;
	end
	flags = 2'b10;
	repeat (2) @(posedge clk);
	if(out != 1)begin
		err = 1;
		//$stop;
	end
	flags = 2'b01;
	repeat (2) @(posedge clk);
	if(out != 0)begin
		err = 1;
		//$stop;
	end
	flags = 2'b11;
	repeat (2) @(posedge clk);
	if(out != 0)begin
		err = 1;
		//$stop;
	end
	$stop;
end
endmodule
// line for revision control version 1.0
