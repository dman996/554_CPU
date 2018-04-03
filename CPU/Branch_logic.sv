///////////////////////////////////////////////////////////////
// Module Name: Branch Logic                                //
// Author: Dustin R. Wiczek                                //
// Module Summary: This module examines the opcode and    //
//  flags from the alu and determies if a branch should  //
//  have been taken                                     //
/////////////////////////////////////////////////////////
module Branch_Logic(
    input clk,
    input rst_n,
    input [4:0] opcode,
    input [1:0] flags,
    output reg pc_branch_sel_out
);   
//local params
localparam BEQ = 5'b10011;
localparam BLT = 5'b10100;
localparam BGT = 5'b10101;
localparam BNE = 5'b10110;

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        pc_branch_sel_out = 0;
    end
    else if((opcode == BEQ) && (flags == 2'b1x)) begin
        pc_branch_sel_out = 1;
    end
    else if((opcode == BNE) && (flags == 2'b0x)) begin
        pc_branch_sel_out = 1;
    end
    else if((opcode == BLT) && (flags == 2'bx1)) begin
        pc_branch_sel_out = 1;
    end
    else if((opcode == BGT) && (flags == 2'bx0)) begin
        pc_branch_sel_out = 1;
    end
    else begin
        pc_branch_sel_out = 0;
    end
end

endmodule
// line for revision control version 1.0
