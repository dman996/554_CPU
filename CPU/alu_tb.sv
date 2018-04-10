/////////////////////////////////////////////////////////////
// Module Name: alu testbench                             //
// Author: Dustin R. Wiczek                              //
// Module Summary: testbench for alu logic              //
/////////////////////////////////////////////////////////
module alu_tb(); 

localparam ADD  = 5'b00010;
localparam ADDI = 5'b00011;
localparam SUB  = 5'b00100;
localparam SUBI = 5'b00101;
localparam MUL  = 5'b00110;
localparam DIV  = 5'b01000;
localparam AND  = 5'b01010;
localparam ANDI = 5'b01011;
localparam OR   = 5'b01100;
localparam ORI  = 5'b01101;
localparam NOT  = 5'b01110;
localparam XOR  = 5'b10000;
localparam XORI = 5'b10001;
localparam CMP  = 5'b10010;
localparam BEQ  = 5'b00010;
localparam BLT  = 5'b00010;
localparam BGT  = 5'b00010;
localparam BNE  = 5'b00010;
localparam MOVEH = 	5'b00111;
localparam CALL = 5'b11001;
localparam RET = 5'b11010;
localparam RETI = 5'b11011;
localparam ST = 5'b11100;
localparam LD = 5'b11101;
localparam MOVEL = 5'b11110;

//ALU Opcodes
localparam ADDA  = 3'b000;
localparam SUBA  = 3'b001;
localparam MULA  = 3'b010;
localparam DIVA  = 3'b011;
localparam ANDA  = 3'b100;
localparam ORA   = 3'b101;
localparam XORA  = 3'b110;
localparam NOTA  = 3'b111;

//regs for testing
reg [31:0] a, b;
reg [4:0] opcode;
wire [31:0] alu_out;
wire [1:0] flags;
wire [2:0] aluOp;
reg err, clk;
alu DUT(
    .a(a),
    .b(b),
    .opcode(opcode),
    .alu_out(alu_out),
    .flags(flags)
);

assign aluOp = DUT.ALU.op;
always @* begin
	if(err) begin
		$display("Error when processing opcode: %B ", opcode);
		@(posedge clk);
        //$display(" and opcode: %B", opcode);
        $stop;
	end
end

always begin
    #1 clk = ~clk;
end

initial begin
    err = 0;
    clk = 1; 
    //test to see if opcodes are correct
	$display("TESTING to see if opcode to aluOp is correct");
    opcode =   ADD;   //= 5'b00010;
    repeat (2) @(posedge clk);
    //rst_n = 1;
    if(aluOp != ADDA)
        err = 1;
    opcode =   ADDI;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != ADDA)
		err = 1;
    opcode =   SUB;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != SUBA)
		err = 1;
    opcode =   SUBI;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != SUBA)
		err = 1;
    opcode =   XOR;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != XORA)
		err = 1;
    opcode =   XORI;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != XORA)
		err = 1;
    opcode =   OR;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != ORA)
		err = 1;
    opcode =   ORI;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != ORA)
		err = 1;
    opcode =   AND;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != ANDA)
		err = 1;
    opcode =   ANDI;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != ANDA)
		err = 1;
    opcode =   NOT;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != NOTA)
		err = 1;
    opcode =   MUL;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != MULA)
		err = 1;
    opcode =   DIV;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != DIVA)
		err = 1;
    opcode =   CMP;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != SUBA)
		err = 1;
    opcode =   LD;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != ADDA)
		err = 1;
    opcode =   ST;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != ADDA)
		err = 1;
    opcode =   MOVEH;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != ANDA)
		err = 1;
    opcode =   MOVEL;  //= 5'b00011;
	repeat (2) @(posedge clk);
	if(aluOp != ANDA)
		err = 1;
    $display("opcode to aluOp completed without errors");
    $stop;


end
endmodule
// line for revision control version 1.0
