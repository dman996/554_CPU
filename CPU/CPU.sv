//////////////////////////////////////////////////////
// Main CPU module                                 //
// This module will instantiate the other modules //
//                                               //
//////////////////////////////////////////////////
module CPU(
    .clk(clk),
    .rst_n(rst_n)
);
//We will need to instantiate wires between each pipeline
//stage and register instantiate the wires coming from each 
//stage or register in the specified section below

//IF Wires

//IF_ID_reg wires

//ID Wires

//ID_EX_reg wires

//EX_wires

//EX_MEM_reg wires

//MEM Wires

//MEM_WB_reg Wires

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

//EX_MEM_reg Module
    EX_MEM_reg ex_mem_reg(
        .clk(clk),
        .rst_n(rst_n),
        .stall(),
        .flush(),
        // pipeline reg signals
        .alu_out_in(),
        .reg_dst_in(),
        .pc_plus4_in(),
        .alu_out_out(),
        .reg_dst_out(),
        .pc_plus4_out(),
        //control signals
        .reg_wr_in(),
        .wb_sel_in(),
        .mem_addr_sel_in(),
        .mem_wr_in(),
        .sp_select_in(),
        .reg_wr_out(),
        .wb_sel_out(),
        .mem_addr_sel_out(),
        .mem_wr_out(),
        .sp_select_out()
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
        .alu_out_in(),
        .reg_dst_in(),
        .pc_plus4_in(),
        .alu_out_out(),
        .reg_dst_out(),
        .pc_plus4_out(),
        //control signals
        .reg_wr_in(),
        .wb_sel_in(),
        .reg_wr_out(),
        .wb_sel_out()
    );
//WB Module
    WB wb(
        .mem_out(), 
        .alu_out(), 
        .pc_plus4(), 
        .reg_dst_in(), 
        .reg_dest_in(),
        .wb_sel(), 
        .reg_wr_in(), 
        .call(), 
        .reg_wr_data(), 
        .reg_dest_out(),
        .reg_wr_out()
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
