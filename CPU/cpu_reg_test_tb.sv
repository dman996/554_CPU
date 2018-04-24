/////////////////////////////////////////////////////////////////////
// Module Name: cp reg test tb                                    //
// Author: Dustin R. Wiczek                                      //
// Module Description: This test bench will test the content of //
//  registers after subsequent movel and moveh instructions    //
////////////////////////////////////////////////////////////////
module cpu_reg_test_tb();

// global clock and reset
reg clk, rst_n;

// interrup from timer
reg alert;

// to memory controller
reg [31:0] mem_wr_data, mem_addr, mem_instr_addr;
reg mem_wr;

// from memory controller
wire [31:0] mem_instr_data, cpu_rw_data;
wire cpu_valid;


assign cpu_rw_data = mem_wr ? mem_wr_data : 32'hzzzzzzzz;


CPU DUTcpu(

    // global clock and reset
    .clk(clk),
    .rst_n(rst_n),

    // interrupt from timer
    .alert(alert),

    // memory controller signals
    .mem_instr_data(mem_instr_data),
    .mem_rd_data(cpu_rw_data),
    .mem_valid(cpu_valid),
    .mem_wr_data(mem_wr_data),
    .mem_addr(mem_addr),
    .mem_instr_addr(mem_instr_addr),
    .mem_wr(mem_wr)

);

memory_controller DUTmem(
  // Global signals
  .clk(clk),
  .rst_n(rst_n),
  
  // Instruction ROM
  .instr_read_addr(mem_instr_addr),
  .instr_read_data(mem_instr_data),
  
  // Image Processor Results
  .img_proc_addr(),
  .img_proc_data(),
  .img_proc_rw(),
  .img_proc_vld(),
  
  // Main SPART Stuff
  .spart_read_addr(),
  .spart_read_req(),
  .spart_read_data(),
  .spart_read_vld(),
  // Spart CS Stuff
  .spart_cs_clr(),
  .spart_cs(),
  
  // CPU Mem stage stuff
  .cpu_rw_addr(mem_addr),
  .cpu_rw({mem_wr,~mem_wr}), // 1 -> request valid, 0 -> high read, low write
  .cpu_rw_data(cpu_rw_data),
  .cpu_rw_vld(cpu_valid),
  
  // PWM and Timer module accesses
  .pwm_data(),
  .timer_data(),
  .timer_clr()
  
  

);
initial begin
    //$readmemb("./instr.txt", instr_mem);
    //$monitor("%d:current instruction is: %b",counter,if_out);
    clk = 0;
    rst_n = 1;
    repeat (5) @(posedge clk)
    rst_n = 0;

    $finish;


    /*$display("contents of instruction memory are:\n");
    $display("%B",instr_mem[0]);
    $display("%B",instr_mem[1]);
    $display("%B",instr_mem[2]);
    $display("%B",instr_mem[3]);
    $finish;*///this was used for testing the contents of the instruction memory
end

always begin
    #5  clk = ~clk;
end

endmodule
// line for revision control version 1.0

