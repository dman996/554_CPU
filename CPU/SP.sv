////////////////////////////////////////////////////////////
// Module Name: SP                                       //
// Author: Dustin R. Wiczek                             //
// Module Description: simple stack pointer module for //
//  use in this processor                             //
//  The sp_select signal is as follows:              //
//  00 = do nothing                                 //
//  01 = increment (push)                          //
//  10 = decrement (pop)                          //
//  11 = error unused value                      //
//////////////////////////////////////////////////
module SP(
    input clk,
    input rst_n,
    
    input [1:0] sp_select,
    output reg [31:0] sp_addr,
    output reg err
);

always @ (posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        sp_addr = 32'h2000;
        err = 0;
    end
    else if (sp_select == 2'b00) begin
        sp_addr = sp_addr;
        err = 0;
    end
    else if (sp_select == 2'b01) begin
        sp_addr = sp_addr + 32'h1;
        err = 0;
    end
    else if (sp_select == 2'b10) begin
        sp_addr = sp_addr - 32'h1;
        err = 0;
    end
    else if (sp_select == 2'b11) begin
        sp_addr = sp_addr;
        err = 1;
    end
end

endmodule
// line for revision control version 1.0

