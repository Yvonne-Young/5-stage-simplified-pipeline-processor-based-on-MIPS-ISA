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
		Imemory[0] = 32'h20110012; //addi $s1, $zero, 18
		Imemory[4] = 32'h20100008; //addi $s0, $zero, 8
		Imemory[8] = 32'h20080002; //addi $t0, $zero, 2
		Imemory[9] = 32'h02114820; //add $t1, $s0, $s1 
		Imemory[10] = 32'h12290005; //beq $s1, $t1, end # no branch
		Imemory[11] = 32'h20110008; // addi s1 0 8
		Imemory[12] = 32'hAE110000;   // sw s1? 0(s0)
		Imemory[13] = 32'h8e110000; //lw $s1, 0($s0)   #need set the DM[2] with data 8 in the Data Mem 
		Imemory[14] = 32'h12110002; //beq $s0, $s1, end # branch end
		Imemory[15] = 32'h02204825; //or $t1, $s1, $zero #check control hazard for branch. no renew for t1 and t2.
		Imemory[16] = 32'h02515020; //add $t2, $s2, $s1
		Imemory[19] = 32'h200a000a; //addi $t2, $0, 10 ?end?
		//Imemory[13] =   32'b00000010101010111011100000100000; 
		//Imemory[14] =   32'b10101100000101010000000000001000; 
		//Imemory[15] =   32'b00001000000000000000000000000110; 
end

always @ (address) 
	begin
		instruction <= Imemory[address[13:2]];
end


endmodule


