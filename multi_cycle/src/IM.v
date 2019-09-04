//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/4							   *
//				module: IM								   *
//**********************************************************************************************************

`timescale 1ns / 1ns

module IM(instruction,address);
input[31:0] address;
output reg [31:0] instruction;
reg[31:0] Imemory[63:0];

integer k;

initial begin
	for(k=0;k<64;k=k+1)begin
		Imemory[k] = 32'b0;
	end

	//You can give your own code block here.
		Imemory[0] = 32'b00100000000010000000000000100000; //addi $t0, $zero, 32
		Imemory[1] = 32'b00100000000010010000000000110111; //addi $t1, $zero, 55
		Imemory[2] = 32'b00000001000010011000000000100000; //add $s0, $t0, $t1
		Imemory[3] = 32'b00000001000010011000100000100010; //sub $s1, $t0, $t1
		Imemory[4] = 32'b00000001000010011001000000100100; //and $s2, $t0, $t1
		Imemory[5] = 32'b00000001000010011001100000100101; //or $s3, $t0, $t1
		Imemory[6] = 32'b00000001000010011010000000101010; //slt $s4, $t0, $t1 (LOOP) 
		Imemory[7] = 32'b00010010100000000000000000000110; //beq $s4, $zero, EXIT
		Imemory[8] = 32'b00000001000010010101000000100000; //add $t2, $t0, $t1
		Imemory[9] = 32'b00000001010010010101000000100000; //add $t2, $t2, $t1
		Imemory[10] = 32'b00000001010010000101100000100000; //add $t3, $t2, $t0
		Imemory[11] = 32'b10001100000101010000000000000100; //lw $s5, 4($zero)
		Imemory[12] = 32'b00000001010101011011000000100000; //add $s6, $t2, $s5
		Imemory[13] = 32'b00000010101010111011100000100000; //add $s7, $s5, $t3
		Imemory[14] = 32'b10101100000101010000000000001000; //sw $s5, 8($zero) (EXIT)
		Imemory[15] = 32'b00001000000000000000000000000110; //j LOOP
end

always @ (address) 
	begin
		instruction <= Imemory[address[13:2]];
end


endmodule


