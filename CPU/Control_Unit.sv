module Control_Unit(
	input [4:0] opcode,

	output reg [1:0] imm_sel,
	output reg branch_type,
	output reg branch_sel,
	output reg [1:0] reg_dst_sel
);

always_comb begin

//default
imm_sel = 2'b00;
branch_type = 1'b0;
branch_sel = 1'b0;
reg_dst_sel = 2'b00;

	case(opcode)
		// nop
		5'b00000: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// pop
		5'b00001: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// add
		5'b00010: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// addi
		5'b00011: begin
			imm_sel = 2'b01;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// sub
		5'b00100: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// subi
		5'b00101: begin
			imm_sel = 2'b01;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// mul
		5'b00110: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// moveh
		5'b00111: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// div
		5'b01000: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// push
		5'b01001: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// and
		5'b01010: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// andi
		5'b01011: begin
			imm_sel = 2'b01;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// or
		5'b01100: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// ori
		5'b01101: begin
			imm_sel = 2'b01;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// not
		5'b01110: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// xor
		5'b10000: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// xori
		5'b10001: begin
			imm_sel = 2'b01;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// cmp
		5'b10010: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// beq
		5'b10011: begin
			imm_sel = 2'b10;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// blt
		5'b10100: begin
			imm_sel = 2'b10;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// bgt
		5'b10101: begin
			imm_sel = 2'b10;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// bne
		5'b10110: begin
			imm_sel = 2'b10;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// jump
		5'b10111: begin
			imm_sel = 2'b10;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// jumpreg
		5'b11000: begin
			imm_sel = 2'b10;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// call
		5'b11001: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// return
		5'b11010: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// returni
		5'b11011: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// store
		5'b11100: begin
			imm_sel = 2'b01;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// load
		5'b11101: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// movel
		5'b11110: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end

		// halt
		5'b11111: begin
			imm_sel = 2'b00;
			branch_type = 1'b0;
			branch_sel = 1'b0;
			reg_dst_sel = 2'b00;
		end
	endcase
end

endmodule
