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
reg [31:0] a, b, imm, correct;
reg [12:0] cnt; 
reg [4:0] opcode;
wire [31:0] alu_out;
wire [1:0] flags;
wire [2:0] aluOp;
reg err, clk;
alu_wrapper DUT(
    .a(a),
    .b(b),
    .imm(imm),
    .opcode(opcode),
    .out(alu_out),
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
    correct = 0;
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
    $display("Now testing the add instruction");
    opcode = ADD; 
    //big ass loop for no reason
    /*for(a=0; a<32'hffffffff; a = a+1) begin
        for(b=0; b<32'hffffffff; b = b+1) begin
            @(posedge clk);
            if(alu_out != (a+b)) begin
                correct = a + b;
                $display("error when adding %H and %H got %H instead of %H",a,b,alu_out,correct);
                $stop;
            end
        end
    end*/
    for(cnt=0; cnt<32'hfff; cnt = cnt+1) begin
            a = $random;
            b = $random;
            @(posedge clk);
            if(alu_out != (a+b)) begin
                correct = a + b;
                $display("error when adding %H and %H got %H instead of %H",a,b,alu_out,correct);
                $stop;
            end
        end
    $display("Success!");
    $display("Now testing ADDI instruction");
    opcode = ADDI;
    for(cnt=0; cnt<32'hfff; cnt = cnt+1) begin
            a = $random;
            imm = $random;
            @(posedge clk);
            if(alu_out != (a+imm)) begin
                correct = a + imm;
                $display("error when adding %H and %H got %H instead of %H",a,imm,alu_out,correct);
                $stop;
            end
        end
    $display("Success!");
    $display("Now testing SUB instruction");
    opcode = SUB;
    for(cnt=0; cnt<32'hfff; cnt = cnt+1) begin
            a = $random;
            b = $random;
            @(posedge clk);
            if(alu_out != (a-b)) begin
                correct = a - b;
                $display("error when subbing %H and %H got %H instead of %H",a,b,alu_out,correct);
                $stop;
            end
        end
    $display("Success!");
    $display("Now testing SUBI instruction");
    opcode = SUBI;
    for(cnt=0; cnt<32'hfff; cnt = cnt+1) begin
            a = $random;
            imm = $random;
            @(posedge clk);
            if(alu_out != (a-imm)) begin
                correct = a - imm;
                $display("error when subbing %H and %H got %H instead of %H",a,imm,alu_out,correct);
                $stop;
            end
        end
    $display("Success!");
    $display("Now testing AND instruction");
    opcode = AND;
    for(cnt=0; cnt<32'hfff; cnt = cnt+1) begin
            a = $random;
            b = $random;
            @(posedge clk);
            if(alu_out != (a&b)) begin
                correct = a & b;
                $display("error when anding %H and %H got %H instead of %H",a,b,alu_out,correct);
                $stop;
            end
        end
    $display("Success!");
    $display("Now testing ANDI instruction");
    opcode = ANDI;
    for(cnt=0; cnt<32'hfff; cnt = cnt+1) begin
            a = $random;
            imm = $random;
            @(posedge clk);
            if(alu_out != (a&imm)) begin
                correct = a & imm;
                $display("error when anding %H and %H got %H instead of %H",a,imm,alu_out,correct);
                $stop;
            end
        end
    $display("Success!");
    $display("Now testing OR instruction");
    opcode = OR;
    for(cnt=0; cnt<32'hfff; cnt = cnt+1) begin
            a = $random;
            b = $random;
            @(posedge clk);
            if(alu_out != (a|b)) begin
                correct = a | b;
                $display("error when orring %H and %H got %H instead of %H",a,b,alu_out,correct);
                $stop;
            end
        end
    $display("Success!");
    $display("Now testing ORI instruction");
    opcode = ORI;
    for(cnt=0; cnt<32'hfff; cnt = cnt+1) begin
            a = $random;
            imm = $random;
            @(posedge clk);
            if(alu_out != (a|imm)) begin
                correct = a | imm;
                $display("error when orring %H and %H got %H instead of %H",a,imm,alu_out,correct);
                $stop;
            end
        end
    $display("Success!");
    $display("Now testing XOR instruction");
    opcode = XOR;
    for(cnt=0; cnt<32'hfff; cnt = cnt+1) begin
            a = $random;
            b = $random;
            @(posedge clk);
            if(alu_out != (a^b)) begin
                correct = a ^ b;
                $display("error when xoring %H and %H got %H instead of %H",a,b,alu_out,correct);
                $stop;
            end
        end
    $display("Success!");
    $display("Now testing XORI instruction");
    opcode = XORI;
    for(cnt=0; cnt<32'hfff; cnt = cnt+1) begin
            a = $random;
            imm = $random;
            @(posedge clk);
            if(alu_out != (a^imm)) begin
                correct = a ^ imm;
                $display("error when xoring %H and %H got %H instead of %H",a,imm,alu_out,correct);
                $stop;
            end
        end
    $display("Success!");
    $display("Now testing NOT instruction");
    opcode = NOT;
    for(cnt=0; cnt<32'hfff; cnt = cnt+1) begin
            a = $random;
            imm = $random;
            @(posedge clk);
            if(alu_out != (!a)) begin
                correct = !a;
                $display("error when 'not'ing %H and %H got %H instead of %H",a,imm,alu_out,correct);
                $stop;
            end
        end
    $display("Success!");
    $display("Now testing MUL instruction");
    opcode = MUL;
    for(cnt=0; cnt<32'hfff; cnt = cnt+1) begin
            a = $random;
            b = $random;
            @(posedge clk);
            if(alu_out != (a*b)) begin
                correct = a * b;
                $display("error when multiplying %H and %H got %H instead of %H",a,b,alu_out,correct);
                $stop;
            end
        end
    $display("Success!");
    $display("Now testing DIV instruction");
    opcode = DIV;
    for(cnt=0; cnt<32'hfff; cnt = cnt+1) begin
            a = $random;
            b = $random;
            @(posedge clk);
            if(alu_out != (a/b)) begin
                correct = a / b;
                $display("error when dividing %H and %H got %H instead of %H",a,imm,alu_out,correct);
                $stop;
            end
        end
    $display("Success!");
    
    
    
    
    $stop;
    
    


end
endmodule
// line for revision control version 1.4
