///////////////////////////////////////////////////////////////
// Module Name: Forwarding Unit                             //
// Author: Dustin R. Wiczek                                //
// Module Summary: This module takes inputs from further  //
//      pipeline stages and forwards the data to earlier //
//      stages to prevent data hazards                  //  
/////////////////////////////////////////////////////////
module Forwarding_Unit(
    input clk,
    input rst_n,
    input [31:0] wb_reg_data,
    input [31:0] mem_reg_data1, //alu_out
    input [31:0] mem_reg_data2, //mem_out
    input wb_sel,
    output reg [31:0] ex_rs1_forward,
    output reg [31:0] ex_rs2_forward,
    input [3:0] wb_reg_dst,
    input [3:0] mem_reg_dst,
    input wb_wr,
    input mem_wr,
    output reg rs1_sel,
    output reg rs2_sel,
    input [3:0] ex_rs1,
    input [3:0] ex_rs2
);
wire [31:0] mem_reg_data;
assign mem_reg_data = (wb_sel) ? mem_reg_data2 : mem_reg_data1;

always_comb begin
    if(!rst_n) begin
        rs1_sel = 0;
        rs2_sel = 0;
        ex_rs1_forward = 0;
        ex_rs2_forward = 0;
    end
    else begin
        // Check to see if data can be forwarded to rs1 in the ex stage
        if((mem_reg_dst == ex_rs1) && mem_wr) begin
            ex_rs1_forward = mem_reg_data;
            rs1_sel = 1;
        end
        else if((wb_reg_dst == ex_rs1) && wb_wr) begin
            ex_rs1_forward = wb_reg_data;
            rs1_sel = 1;
        end
        else begin
			ex_rs1_forward = 32'd0;
            rs1_sel = 0;
        end
        // Check to see if data can be forwarded to rs2 in the ex stage
        if((mem_reg_dst == ex_rs2) && mem_wr) begin
            ex_rs2_forward = mem_reg_data;
            rs2_sel = 1;
        end
        else if((wb_reg_dst == ex_rs2) && wb_wr) begin
            ex_rs2_forward = wb_reg_data;
            rs2_sel = 1;
        end
        else begin
				ex_rs2_forward = 32'd0;
            rs2_sel = 0;
				
        end
    end
end



/*
always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        rs1_sel = 0;
        rs2_sel = 0;
        ex_rs1_forward = 0;
        ex_rs2_forward = 0;
    end
    else begin
        // Check to see if data can be forwarded to rs1 in the ex stage
        if((mem_reg_dst == ex_rs1) && mem_wr) begin
            ex_rs1_forward = mem_reg_data;
            rs1_sel = 1;
        end
        else if((wb_reg_dst == ex_rs1) && wb_wr) begin
            ex_rs1_forward = wb_reg_data;
            rs1_sel = 1;
        end
        else begin
            rs1_sel = 0;
        end
        // Check to see if data can be forwarded to rs2 in the ex stage
        if((mem_reg_dst == ex_rs2) && mem_wr) begin
            ex_rs2_forward = mem_reg_data;
            rs2_sel = 1;
        end
        else if((wb_reg_dst == ex_rs2) && wb_wr) begin
            ex_rs2_forward = wb_reg_data;
            rs2_sel = 1;
        end
        else begin
            rs2_sel = 0;
        end
    end
end
*/

endmodule
// line for revision control version 1.0
