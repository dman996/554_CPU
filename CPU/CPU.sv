//////////////////////////////////////////////////////
// Main CPU module                                 //
// This module will instantiate the other modules //
//                                               //
//////////////////////////////////////////////////
module CPU(

    // global clock and reset
    input clk,
    input rst_n,

    // interrupt from timer
    input alert,

    // memory controller signals
    input [31:0] mem_rd_data,
    output [31:0] mem_wr_data,
    output [31:0] mem_addr,
    output mem_wr

);
//We will need to instantiate wires between each pipeline
//stage and register instantiate the wires coming from each 
//stage or register in the specified section below
//the naming scheme will be as follows: "<signal_name>_<pipeline_or_reg_where_i_came_from.
// ex. alu_out_MEMWB alu_out_EX

//IF Wires

//IF_ID_reg wires

//ID Wires

//ID_EX_reg wires
wire [31:0] mem_out_IDEX, pc_plus4_IDEX;
wire reg_wr_MEMWR, wb_sel_IDEX, call_IDEX;
//EX_wires
wire [31:0] alu_out_IDEX;
wire [3:0] reg_dst_EX;
//EX_MEM_reg wires
wire [31:0] alu_out_EXMEM, mem_out_EXMEM, pc_plus4_EXMEM;
wire [3:0] reg_dst_EXMEM;
wire reg_wr_MEMWR, wb_sel_EXMEM, call_EXMEM;
//MEM Wires

//MEM_WB_reg Wires (OUT)
wire [31:0] alu_out_MEMWB, mem_out_MEMWB, pc_plus4_MEMWB;
wire [3:0] reg_dst_MEMWB;
wire reg_wr_MEMWR, wb_sel_MEMWB, call_MEMWB;
//WB Wires

//Hazard Unit Wires
//Forwarding Unit Wires

/////////////////////////////////
//Instantiate CPU Modules here//
///////////////////////////////
//IF Module

//IF_ID_reg Module

//ID Module

//ID_EX_reg Module

//EX Module
    EX ex(
    .clk(clk),
    .rst_n(rst_n),
    .rs1(),
    .rs2(),
    .imm(),
    .rs1_forward(),
    .rs2_forward(),
    .rs1_sel(),
    .rs2_sel(),
    .mem_addr(),
    .mem_data(mem_data_EX),
    .alu_out(alu_out_EX),
    .pc_branch_sel(pc_branch_sel_EX),
    //control signals
    .reg_dest_in(reg_dst_in),
    .reg_dest_out(),
    .opcode(),
    .cmp(),
    .returni(),
    .mem_addr_sel(),
    .sp_sel(),
    .mem_wr_in(),
    .mem_wr_out()
);
//EX_MEM_reg Module
    EX_MEM_reg ex_mem_reg(
        .clk(clk),
        .rst_n(rst_n),
        .stall(),
        .flush(),
        // pipeline reg signals
        .alu_out_in(alu_out_EX),
        .reg_dst_in(reg_dst_IDEX),
        .pc_plus4_in(pc_plus4_IDEX),
        .alu_out_out(alu_out_EXMEM),
        .reg_dst_out(reg_dst_EXMEM),
        .pc_plus4_out(pc_plus4_EXMEM),
        //control signals
        .reg_wr_in(reg_wr_IDEX),
        .wb_sel_in(wb_sel_IDEX),
        //.mem_addr_sel_in(),
        //.mem_wr_in(),
        //.sp_select_in(),
        .reg_wr_out(reg_wr_EXMEM),
        .wb_sel_out(wb_sel_EXMEM)
        //.mem_addr_sel_out(),
        //.mem_wr_out(),
        //.sp_select_out()
    );

//MEM Module
    MEM mem(
        .alu_out(),
        .sp_out(),
        .mem_addr_sel(),
        .mem_addr()
    );
//MEM_WB_reg Module
    MEM_WB_reg mem_wb_reg(
        .clk(clk),
        .rst_n(rst_n),
        .stall(),
        .flush(),
        // pipeline reg signals
        .alu_out_in(alu_out_EXMEM),
        .reg_dst_in(reg_dst_EXMEM),
        .pc_plus4_in(pc_plus4_EXMEM),
        .alu_out_out(alu_out_MEMWB),
        .reg_dst_out(reg_dst_MEMWB),
        .pc_plus4_out(pc_plus4_MEMWB),
        //control signals
        .reg_wr_in(reg_wr_EXMEM),
        .wb_sel_in(wb_sel_EXMEM),
        .reg_wr_out(reg_wr_MEMWB),
        .wb_sel_out(wb_sel_MEMWB)
    );
//WB Module
    WB wb(
        .mem_out(mem_out_MEMWB), 
        .alu_out(alu_out_MEMWB), 
        .pc_plus4(pc_plus4_MEMWB), 
        .reg_dst_in(reg_dst_MEMWB), 
        .wb_sel(wb_sel_MEMWB), 
        .reg_wr_in(reg_wr_MEMWB), 
        .call(call_MEMWB), 
        .reg_wr_data(reg_wr_data_WB), 
        .reg_dest_out(reg_dst_WB),
        .reg_wr_out(reg_wr_WB)
    );
//Hazard Unit 

//Forwarding Unit
    Forwarding_Unit FU(
        .clk(clk),
        .rst_n(rst_n),
        .wb_reg_data(),
        .mem_reg_data(),
        .ex_rs1_forward(),
        .ex_rs2_forward(),
        .wb_reg_dst(),
        .mem_reg_dst(),
        .wb_wr(),
        .mem_wr(),
        .rs1_sel(),
        .rs2_sel(),
        .ex_rs1(),
        .ex_rs2()
    );
//Branch Logic
    Branch_Logic BL(
        .clk(clk),
        .rst_n(rst_n),
        .opcode(),
        .flags(),
        .pc_branch_sel_out()
    );
endmodule
