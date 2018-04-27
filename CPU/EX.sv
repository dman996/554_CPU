//////////////////////////////////////////////////
// Module Name: EX                             //
// Author: Dustin R. Wiczek                   //
// Module Description: This is the Execute   //
//  stage of our projects 5 stage pipeline. //
//  Not sure where to instantiate mem block yet
/////////////////////////////////////////////
module EX(
    input clk,
    input rst_n,
    input [31:0] rs1,
    input [31:0] rs2,
    input [31:0] imm,
    input [3:0] reg_dest_in,
    output [3:0] reg_dest_out,
    output [31:0] mem_addr,
    output [31:0] mem_data,
    output [31:0] alu_out,
    // from forwarding unit
    input [31:0] rs1_forward,
    input [31:0] rs2_forward,
    input rs1_sel,
    input rs2_sel,
    output pc_branch_sel,
    //control signals
    input [4:0] opcode,
    input cmp,
    input returni,
    input mem_addr_sel,
    input [1:0] sp_sel
);
//wires
wire [31:0] sp_addr, fwd_mux_1, fwd_mux_2;
wire [1:0] flags;
reg [1:0] flags_ff, flags_bak;

alu_wrapper ALU(
    .a(fwd_mux_1),
    .b(fwd_mux_2),
    .imm(imm),
    .opcode(opcode),
    .out(alu_out),
    .flags(flags)
);
Branch_logic BL(
    .clk(clk),
    .rst_n(rst_n),
    .opcode(opcode),
    .flags(flags_ff),
    .pc_branch_sel_out(pc_branch_sel)
);  
SP sp(
    .clk(clk),
    .rst_n(rst_n),
    .sp_select(sp_sel),
    .sp_addr(sp_addr),
    .err()
);

assign reg_dest_out = reg_dest_in;

assign mem_addr = (mem_addr_sel) ? sp_addr:alu_out;
assign mem_data = fwd_mux_1;
assign fwd_mux_1 = (0) ? rs1_forward:rs1;
assign fwd_mux_2 = (rs2_sel) ? rs2_forward:rs2;

always @(posedge clk, negedge rst_n) begin
    if(!rst_n)begin
        flags_ff <= 0;
        flags_bak <=0;
    end
    else if(returni & cmp) begin
        flags_ff <= flags_bak;
        flags_bak <= flags_ff;
    end
    else if(!returni & cmp) begin
        flags_ff <= flags;
        flags_bak <= flags_ff;
    end
    else begin
        flags_ff <= flags_ff;
        flags_bak <= flags_bak;
    end
end

endmodule
//line for revision controll version 1.0
