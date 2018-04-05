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

always @* begin
	if(err) begin
		$write("Error when processing flags: %B ", flags);
		$display(" and opcode: %B", opcode);
        $stop;
	end
end

always begin
    #1 clk = ~clk;
end
initial begin
    err = 0;
    clk = 1; 
    rst_n = 0;
    //first testing BEQ
	$display("TESTING OPCODE BEQ");
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
	$display("TESTING OPCODE BNE");
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
	$display("TESTING OPCODE BLT");
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
    $display("TESTING OPCODE BGT");
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
