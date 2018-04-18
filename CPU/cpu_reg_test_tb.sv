/////////////////////////////////////////////////////////////////////
// Module Name: cp reg test tb                                    //
// Author: Dustin R. Wiczek                                      //
// Module Description: This test bench will test the content of //
//  registers after subsequent movel and moveh instructions    //
////////////////////////////////////////////////////////////////
module cpu_reg_test_tb();
//fileIO vars
reg[31:0] instr_mem [0:3]; //16 instructions for the test bench
integer counter; //instruction counter
//regs and wires for outputs and inputs
reg clk, rst_n;
reg [31:0] if_out; //instruction to force into the cpu for testing purposes
//reg {15:0] reg_data;
wire [31:0] reg_wr_data_WB, alu_out_MEM, alu_out_EX, current_PC;
/*//instantiate cpu
CPU CPU_DUT(

    // global clock and reset
    .clk(clk),
    .rst_n(rst_n),

    // interrupt from timer
    .alert(1'b0),

    // memory controller signals
    .mem_instr_data(),
    .mem_rd_data(),
    .mem_wr_data(),
    .mem_addr(),
    .mem_instr_addr(),
    .mem_wr()
);
*/
initial begin
    $readmemb("./instr.txt", instr_mem);
    $monitor("%d:current instruction is: %b",counter,if_out);
    clk = 0;
    counter = 0;
    repeat (10) @(posedge clk);
    /*$display("contents of instruction memory are:\n");
    $display("%B",instr_mem[0]);
    $display("%B",instr_mem[1]);
    $display("%B",instr_mem[2]);
    $display("%B",instr_mem[3]);

    $finish;*///this was used for testing the contents of the instruction memory
    $finish;

end

always begin
    #1  clk = ~clk;
end
//increment instruction counter
always @(posedge clk) begin
    counter = counter + 1;
end
//fetch instuction
always @(*) begin
    if_out = instr_mem[counter];
end
endmodule
// line for revision control version 1.0

