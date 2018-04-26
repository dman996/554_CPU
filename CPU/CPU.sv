///////////////////////////////////////////////////////////
// CPU.sv                                               //
// Top level module for the CPU, interacts with        // 
// the Timer interrupt (alert) and memory controller. //
///////////////////////////////////////////////////////
module CPU(

    // global clock and reset
    input clk,
    input rst_n,

    // interrupt from timer
    input alert,

    // memory controller signals
    input [31:0] mem_instr_data,
    input [31:0] mem_rd_data,
    input mem_valid,
    output [31:0] mem_wr_data,
    output [31:0] mem_addr,
    output [31:0] mem_instr_addr,
    output mem_wr,
	output mem_rd

);

/////////////////////////////////////////////////////////
//         Instantiate CPU Wires here                  //
/////////////////////////////////////////////////////////

// The naming scheme will be as follows: 
//     "<signal_name>_<pipeline_or_reg_where_it_came_from.
// Example: "alu_out_MEMWB" -> comes from the MEM_WB reg
// Example: "alu_out_EX" -> comes from the EX stage

//IF Wires
wire [31:0] pc_plus_4_IF, pci_next;
wire interrupt_IF, interrupt_mask_IF, alert_flush_IF;

//IF_ID_reg wires
wire interrupt_IFID, interrupt_mask_IFID;
wire [31:0] pc_plus_4_IFID, instr_IFID;

//ID Wires
wire branch_predict_ID, interrupt_ID, cmp_ID, returni_ID, mem_addr_sel_ID, mem_wr_ID, mem_rd_ID, wb_sel_ID, reg_wr_ID, call_ID;
wire [31:0] branch_pc_ID, sign_ext_imm_ID, rd1_out_ID, rd2_out_ID, pc_plus_4_ID, mem_instr_data_stalled;
wire [3:0] reg_dst_ID, ex_rs1_ID, ex_rs2_ID;
wire [4:0] opcode_ID;
wire [1:0] sp_sel_ID;

//ID_EX_reg wires
wire [31:0] pc_plus_4_IDEX, rd1_out_IDEX, rd2_out_IDEX, sign_ext_imm_IDEX;
wire [4:0] opcode_IDEX;
wire [3:0] reg_dst_IDEX, ex_rs1_IDEX, ex_rs2_IDEX;
wire [1:0] sp_sel_IDEX;
wire interrupt_IDEX, cmp_IDEX, returni_IDEX, mem_addr_sel_IDEX, mem_wr_IDEX, wb_sel_IDEX, call_IDEX, reg_wr_IDEX, high_IDEX, low_IDEX;

//EX_wires
wire [31:0] alu_out_EX;
wire [3:0] reg_dst_EX;
wire mem_wr_EX, pc_branch_sel_EX, pcr_take, pcr_take_out;

//EX_MEM_reg wires
wire [31:0] alu_out_EXMEM, mem_out_EXMEM, pc_plus_4_EXMEM;
wire [3:0] reg_dst_EXMEM;
wire reg_wr_EXMEM, wb_sel_EXMEM, call_EXMEM, high_EXMEM, low_EXMEM;

//MEM Wires
wire [31:0] mem_out_MEM, alu_out_MEM, pc_plus_4_MEM;
wire [3:0] reg_dst_MEM;
wire reg_wr_MEM;


//MEM_WB_reg Wires (OUT)
wire [31:0] alu_out_MEMWB, mem_out_MEMWB, pc_plus_4_MEMWB;
wire [3:0] reg_dst_MEMWB;
wire reg_wr_MEMWB, wb_sel_MEMWB, call_MEMWB, high_MEMWB, low_MEMWB;

//WB Wires
wire [3:0] reg_dst_WB;
wire [31:0] reg_wr_data_WB;
wire wb_sel_MEM, reg_wr_WB;

//Hazard Unit Wires
wire load_hazard;
wire flush_IFID, stall_IFID;
wire flush_IDEX, stall_IDEX;
wire flush_EXMEM, stall_EXMEM;
wire flush_MEMWB, stall_MEMWB;
reg  flush_IFID_ff;

//Forwarding Unit Wires
wire [31:0] rs1_forward_FU, rs2_forward_FU;
wire rs1_sel_FF, rs2_sel_FF;
/////////////////////////////////////////////////////////
//         Instantiate CPU Modules here                //
/////////////////////////////////////////////////////////

//IF Module
IF iFetch(
	// global signals
	.clk(clk),
	.rst_n(rst_n),

	// from forwarding unit
	.stall(stall_IFID),
	.flush_in(flush_IFID),

	// from timer (interrupt signal source)
	.alert(alert),
	
	// select signals
	.branch_predict(branch_predict_ID),
	.pcr_take(pcr_take_out),
	.pci_take(returni_ID),
	.branch_undo(pc_branch_sel_EX),

	// pc values
	.branch_pc(branch_pc_ID),
	.pcr(rd1_out_IDEX),
	.pc_not_taken(pc_plus_4_IDEX),
	
	// to memory controller
	.mem_addr(mem_instr_addr),
	
	// to IF_ID reg
	.pc_plus_4(pc_plus_4_IF),
	.interrupt(interrupt_IF),
	.interrupt_mask(interrupt_mask_IF),

	// to forwarding unit
	.flush(alert_flush_IF)
);

always @(posedge clk, negedge rst_n) begin
	if (!rst_n)
		flush_IFID_ff = 1'b0;
	else
		flush_IFID_ff = flush_IFID;
end 
		

//IF_ID_reg Module
IF_ID_reg if_id_reg(
	// global signals
    	.clk(clk),
    	.rst_n(rst_n),

	// from forwarding unit
   	.stall(stall_IFID),
    	.flush(flush_IFID),

    	// pipeline reg signals
    	.interrupt(interrupt_IF),
	.interrupt_mask(interrupt_mask_IF),
    	.pc_plus_4(pc_plus_4_IF),
    	.instr(flush_IFID_ff ? 32'd0 : mem_instr_data),
    	.interrupt_out(interrupt_IFID),
	.interrupt_mask_out(interrupt_mask_IFID),
    	.pc_plus_4_out(pc_plus_4_IFID),
    	.instr_out(instr_IFID)
);

instr_staller instrstall(
	// global clock and reset
	.clk(clk),
	.rst_n(rst_n),
	
	// stall from hazard unit
	.stall(stall_IFID),

	// instruction from mem controller
	.instr_in(mem_instr_data),
	
	// output
	.instr_out(mem_instr_data_stalled)
);
//ID Module
ID id(
	// global signals
	.clk(clk),
	.rst_n(rst_n),

	// from IF_ID Buffer
	.pc_plus_4(pc_plus_4_IFID),
	.interrupt(interrupt_IFID),
	.instr(flush_IFID_ff ? 32'd0 : mem_instr_data_stalled),

	// from WB Stage
	.wr(reg_wr_WB),
	.wr_dst(reg_dst_WB),
	.wr_data(reg_wr_data_WB),
	.high(high_MEMWB),
	.low(low_MEMWB),

	// to IF
	.branch_pc(branch_pc_ID),
	.branch_sel(branch_predict_ID),
	.pcr_take(pcr_take),

	// to ID_EX Reg
	.sign_ext_imm(sign_ext_imm_ID),
	.reg_dst(reg_dst_ID),
	.rd1_bypass_out(rd1_out_ID),
	.rd2_bypass_out(rd2_out_ID), 
	.pc_plus_4_out(pc_plus_4_ID),
	.interrupt_out(interrupt_ID),
   	.cmp_out(cmp_ID),
    	.returni_out(returni_ID),
    	.mem_addr_sel_out(mem_addr_sel_ID),
    	.sp_sel_out(sp_sel_ID),
    	.mem_wr_out(mem_wr_ID),
		.mem_rd_out(mem_rd_ID),
    	.wb_sel_out(wb_sel_ID),
    	.reg_wr_out(reg_wr_ID),
    	.call_out(call_ID),  
	.opcode(opcode_ID),
	.ex_rs1(ex_rs1_ID),
	.ex_rs2(ex_rs2_ID)
);

//ID_EX_reg Module
ID_EX_reg id_ex_reg(
	// global signals
    	.clk(clk),
    	.rst_n(rst_n),

	// from forwarding unit
   	.stall(stall_IDEX),
    	.flush(flush_IDEX),

    	// pipeline reg signals
    	.reg_dst(reg_dst_ID),
    	.rd1_bypass(rd1_out_ID),
    	.rd2_bypass(rd2_out_ID), 
    	.pc_plus_4(pc_plus_4_ID),
    	.interrupt(interrupt_ID),
    	.sign_ext_imm(sign_ext_imm_ID),
	.ex_rs1(ex_rs1_ID),
	.ex_rs2(ex_rs2_ID),
    	.reg_dst_out(reg_dst_IDEX),
    	.rd1_bypass_out(rd1_out_IDEX),
    	.rd2_bypass_out(rd2_out_IDEX), 
    	.pc_plus_4_out(pc_plus_4_IDEX),
    	.interrupt_out(interrupt_IDEX),
    	.sign_ext_imm_out(sign_ext_imm_IDEX),
	.ex_rs1_out(ex_rs1_IDEX),
	.ex_rs2_out(ex_rs2_IDEX),
		
		
    	//control signals
    	.opcode_in(opcode_ID),
    	.cmp_in(cmp_ID),
    	.returni_in(returni_ID),
    	.mem_addr_sel_in(mem_addr_sel_ID),
  	.sp_sel_in(sp_sel_ID),
    	.mem_wr_in(mem_wr_ID),
		.mem_rd_in(mem_rd_ID),
  	.wb_sel_in(wb_sel_ID),
    	.reg_wr_in(reg_wr_ID),
    	.call_in(call_ID),
	.pcr_take_in(pcr_take),
	.high_in(opcode_ID == 5'b00111),
	.low_in(opcode_ID == 5'b11110),
    	.opcode_out(opcode_IDEX),
    	.cmp_out(cmp_IDEX),
    	.returni_out(returni_IDEX),
    	.mem_addr_sel_out(mem_addr_sel_IDEX),
    	.sp_sel_out(sp_sel_IDEX),
    	.mem_wr_out(mem_wr),
		.mem_rd_out(mem_rd),
    	.wb_sel_out(wb_sel_IDEX),
    	.reg_wr_out(reg_wr_IDEX),
    	.call_out(call_IDEX),
	.pcr_take_out(pcr_take_out),
		.high_out(high_IDEX),
		.low_out(low_IDEX)
);

//EX Module
EX ex(
	// global signals
    	.clk(clk),
    	.rst_n(rst_n),

	// from IDEX
    	.rs1(rd1_out_IDEX),
    	.rs2(rd2_out_IDEX),
    	.imm(sign_ext_imm_IDEX),
	.reg_dest_in(reg_dst_IDEX),

	// to memory controller
    	.mem_addr(mem_addr),
    	.mem_data(mem_wr_data),

	// to EX_MEM reg
    	.alu_out(alu_out_EX),
    	.pc_branch_sel(pc_branch_sel_EX),

	// from forwarding unit
    	.rs1_forward(rs1_forward_FU),
    	.rs2_forward(rs2_forward_FU),
    	.rs1_sel(rs1_sel_FF),
    	.rs2_sel(rs2_sel_FF),

    	//control signals from ID_EX reg
    	.opcode(opcode_IDEX),
    	.cmp(cmp_IDEX),
    	.returni(returni_IDEX),
    	.mem_addr_sel(mem_addr_sel_IDEX),
    	.sp_sel(sp_sel_IDEX),

	// to EX_MEM reg
	.reg_dest_out(reg_dst_EX)
);

//EX_MEM_reg Module
EX_MEM_reg ex_mem_reg(
	// global signals
    	.clk(clk),
    	.rst_n(rst_n),

	// from forwarding unit
   	.stall(stall_EXMEM),
    	.flush(flush_EXMEM),

        // pipeline reg signals
        .alu_out_in(alu_out_EX),
        .reg_dst_in(reg_dst_EX),
        .pc_plus4_in(pc_plus_4_IDEX),
        .alu_out_out(alu_out_EXMEM),
        .reg_dst_out(reg_dst_EXMEM),
        .pc_plus4_out(pc_plus_4_EXMEM),

        //control signals
        .reg_wr_in(reg_wr_IDEX),
        .wb_sel_in(wb_sel_IDEX),
	.call(call_IDEX),
	.high_in(high_IDEX),
		.low_in(low_IDEX),
        .reg_wr_out(reg_wr_EXMEM),
        .wb_sel_out(wb_sel_EXMEM),
	.call_out(call_EXMEM),
	.high_out(high_EXMEM),
		.low_out(low_EXMEM)
);

//MEM Module
MEM mem(
	// from EX_MEM reg
    	.mem_out_in(mem_rd_data),
    	.alu_out_in(alu_out_EXMEM),
    	.pc_plus4_in(pc_plus_4_EXMEM),
    	.reg_dest_in(reg_dst_EXMEM),

    	// control signals
   	.reg_wr(reg_wr_EXMEM),
    	.wb_sel(wb_sel_EXMEM),
    	.reg_wr_out(reg_wr_MEM),
    	.wb_sel_out(wb_sel_MEM),

	// to MEM_WB reg
    	.mem_out_out(mem_out_MEM),
    	.alu_out_out(alu_out_MEM),
    	.pc_plus4_out(pc_plus_4_MEM),
    	.reg_dest_out(reg_dst_MEM)
);

//MEM_WB_reg Module
MEM_WB_reg mem_wb_reg(
	// global signals
    	.clk(clk),
    	.rst_n(rst_n),

	// from forwarding unit
   	.stall(stall_MEMWB),
    	.flush(flush_MEMWB),

        // pipeline reg signals
	.mem_out_in(mem_out_MEM),
        .alu_out_in(alu_out_MEM),
        .reg_dst_in(reg_dst_MEM),
        .pc_plus4_in(pc_plus_4_MEM),
	.mem_out_out(mem_out_MEMWB),
        .alu_out_out(alu_out_MEMWB),
        .reg_dst_out(reg_dst_MEMWB),
        .pc_plus4_out(pc_plus_4_MEMWB),

        //control signals
        .reg_wr_in(reg_wr_MEM),
        .wb_sel_in(wb_sel_MEM),
	.call(call_EXMEM),
	.high_in(high_EXMEM),
		.low_in(low_EXMEM),
        .reg_wr_out(reg_wr_MEMWB),
        .wb_sel_out(wb_sel_MEMWB),
	.call_out(call_MEMWB),
	.high_out(high_MEMWB),
		.low_out(low_MEMWB)
);

//WB Module
WB wb(
        .mem_out(mem_out_MEMWB),
        .alu_out(alu_out_MEMWB),
        .pc_plus4(pc_plus_4_MEMWB),
        .reg_dest_in(reg_dst_MEMWB),
        .wb_sel(wb_sel_MEMWB),
        .reg_wr_in(reg_wr_MEMWB),
        .call(call_MEMWB),
        .reg_wr_data(reg_wr_data_WB),
        .reg_dest_out(reg_dst_WB),
        .reg_wr_out(reg_wr_WB)
);


// TODO: figure out this situation
assign load_hazard = 1'b0;

//Hazard Unit
Hazard_unit hazard_unit(

	// hazard condition signals
	.branch_miss(pc_branch_sel_EX || pcr_take_out),
	.mem_stall(~mem_valid & mem_wr),
	.alert(alert_flush_IF),
	.load_hazard(load_hazard),
	.branch_call_jump(branch_predict_ID),

	// outputs to IF_ID Buffer
	.flush_if_id(flush_IFID),
	.stall_if_id(stall_IFID),

	// outputs to ID_EX Buffer
	.flush_id_ex(flush_IDEX),
	.stall_id_ex(stall_IDEX),

	// outputs to EX_MEM Buffer	
	.flush_ex_mem(flush_EXMEM),
	.stall_ex_mem(stall_EXMEM),

	// outputs to MEM_WB Buffer
	.flush_mem_wb(flush_MEMWB),
	.stall_mem_wb(stall_MEMWB)

);

//Forwarding Unit
Forwarding_Unit FU(
        .clk(clk),
        .rst_n(rst_n),
        .wb_reg_data(reg_wr_data_WB),
        .mem_reg_data1(alu_out_EXMEM),
	.mem_reg_data2(mem_out_MEM),
	.wb_sel(wb_sel_MEM),
        .ex_rs1_forward(rs1_forward_FU),
        .ex_rs2_forward(rs2_forward_FU),
        .wb_reg_dst(reg_dst_WB),
        .mem_reg_dst(reg_dst_MEM),
        .wb_wr(reg_wr_WB),
        .mem_wr(reg_wr_MEM),
        .rs1_sel(rs1_sel_FF),
        .rs2_sel(rs2_sel_FF),
        .ex_rs1(ex_rs1_IDEX),
        .ex_rs2(ex_rs2_IDEX)
);


endmodule
