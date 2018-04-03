//////////////////////////////////
// Module Name: MEM
// Author: Dustin R. Wiczek
// Module Summary: This module sets up the address
//  value needed by the mempry controller so 
//  that it meets the timing required by the block
//  rams
//////////////////////////////////
module MEM(
    input [31:0] alu_out,
    input [31:0] sp_out,
    input mem_addr_sel
    output [31:0] mem_addr
);

assign mem_addr = (mem_addr_sel) ? sp_out : alu_out;

endmodule
//Line for revision controll version 1.0
