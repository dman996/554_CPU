module Control_Unit(
	input [4:0] opcode,

	output reg [1:0] imm_sel,
	output reg branch_type,
	output reg branch_sel,
	output reg [1:0] reg_dst_sel,
   	output reg cmp,
    	output reg returni,
    	output reg mem_addr_sel,
    	output reg [1:0] sp_sel,
    	output reg mem_wr,
		output reg mem_rd,
    	output reg wb_sel,
    	output reg reg_wr,
    	output reg call
);

always_comb begin

//default
imm_sel = 2'b00;
branch_type = 1'b0;
branch_sel = 1'b0;
reg_dst_sel = 2'b00;
cmp = 1'b0;
returni = 1'b0;
mem_addr_sel = 1'b0;
sp_sel = 2'b00;
mem_wr = 1'b0;
mem_rd = 1'b0;
wb_sel = 1'b0;
reg_wr = 1'b0;
call = 1'b0;

	case(opcode)
		// nop
		5'b00000: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			mem_rd = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b0;
			call = 1'b0;
		end

		// pop
		5'b00001: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b10;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b1;
			sp_sel = 2'b10;
			mem_wr = 1'b0;
			wb_sel = 1'b1;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b1;
		end

		// add
		5'b00010: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b10;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// addi
		5'b00011: begin
			imm_sel = 2'b01;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b01;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// sub
		5'b00100: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b10;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// subi
		5'b00101: begin
			imm_sel = 2'b01;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b01;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// mul
		5'b00110: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b10;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// moveh
		5'b00111: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// div
		5'b01000: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b10;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// push
		5'b01001: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b1;
			sp_sel = 2'b01;
			mem_wr = 1'b1;
			wb_sel = 1'b0;
			reg_wr = 1'b0;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// and
		5'b01010: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b10;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// andi
		5'b01011: begin
			imm_sel = 2'b01;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b01;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// or
		5'b01100: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b10;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// ori
		5'b01101: begin
			imm_sel = 2'b01;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b01;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// not
		5'b01110: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b01;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// xor
		5'b10000: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b10;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// xori
		5'b10001: begin
			imm_sel = 2'b01;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b01;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// cmp
		5'b10010: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
			cmp = 1'b1;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b0;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// beq
		5'b10011: begin
			imm_sel = 2'b10;
			branch_type = 1'b1;
			branch_sel = 1'b1;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b0;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// blt
		5'b10100: begin
			imm_sel = 2'b10;
			branch_type = 1'b1;
			branch_sel = 1'b1;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b0;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// bgt
		5'b10101: begin
			imm_sel = 2'b10;
			branch_type = 1'b1;
			branch_sel = 1'b1;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b0;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// bne
		5'b10110: begin
			imm_sel = 2'b10;
			branch_type = 1'b1;
			branch_sel = 1'b1;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b0;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// jump
		5'b10111: begin
			imm_sel = 2'b10;
			branch_type = 1'b0;
			branch_sel = 1'b1;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b0;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// jumprel
		5'b11000: begin
			imm_sel = 2'b10;
			branch_type = 1'b1;
			branch_sel = 1'b1;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b0;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// call
		5'b11001: begin
			imm_sel = 2'b00;
			branch_type = 1'b1;
			branch_sel = 1'b1;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b1;
			mem_rd = 1'b0;
		end

		// return
		5'b11010: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b1;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b0;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// returni
		5'b11011: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b1;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b0;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// store
		5'b11100: begin
			imm_sel = 2'b01;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b1;
			wb_sel = 1'b0;
			reg_wr = 1'b0;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// load
		5'b11101: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b01;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b1;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b1;
		end

		// movel
		5'b11110: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b1;
			call = 1'b0;
			mem_rd = 1'b0;
		end

		// halt
		5'b11111: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
			cmp = 1'b0;
			returni = 1'b0;
			mem_addr_sel = 1'b0;
			sp_sel = 2'b00;
			mem_wr = 1'b0;
			wb_sel = 1'b0;
			reg_wr = 1'b0;
			call = 1'b0;
			mem_rd = 1'b0;
		end
	endcase
end

endmodule
