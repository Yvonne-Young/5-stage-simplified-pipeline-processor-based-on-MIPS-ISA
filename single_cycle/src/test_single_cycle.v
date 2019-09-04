//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/2							   *
//				module: Testbench							   *
//**********************************************************************************************************

`timescale 1ns / 1ps

module TestBench;

reg clk;
reg rst_n;
integer k;
top_single top_single(clk,rst_n);

initial begin
	clk = 0; 	
	#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
	#1 clk = 0;		#1 clk = 1;	
end

initial begin
#0	rst_n=0;
#0.5	rst_n=1;
end

initial begin
	k = 0;
end

always @ (clk,k) 
begin
/*	$display($time,,"Clock = ", ~clk);
	$display($time,,"PC = ", single.pc);
	$display($time,,"npc=", single.npc);
   $display($time,,"Instruction = ", single.pc[13:2]);
	$display($time,,"[$t0] = %d", single.regfile.register[8]);
	$display($time,,"[$t1] = %d", single.regfile.register[9]);
	$display($time,,"ALUSrc1 = ", single.Data1);
	$display($time,,"ALUSrc2 = ", single.ALUSrc2);
	$display($time,,"ALU Result = ", single.ALUResult1);
	$display($time,,"Writeback = ", single.WriteBack);
	$display($time,,"Write_reg = ",single.Write_reg);
	$display($time,,"Reg_Out_1 = ", single.Data1);	
	$display($time,,"Reg_Out_2 = ", single.Data2);*/
	$display("Time  =%d, [clk] = %d", k, clk);		
	$display("[$s0] = %d, [$s1] = %d, [$s2] = %d", top_single.registers.regfile[16], 
		top_single.registers.regfile[17], top_single.registers.regfile[18]);	
	$display("[$s3] = %d, [$s4] = %d, [$s5] = %d", top_single.registers.regfile[19], 
		top_single.registers.regfile[20], top_single.registers.regfile[21]);
	$display("[$s6] = %d, [$s7] = %d, [$t0] = %d", top_single.registers.regfile[22], 
		top_single.registers.regfile[23], top_single.registers.regfile[8]);
	$display("[$t1] = %d, [$t2] = %d, [$t3] = %d", top_single.registers.regfile[9], 
		top_single.registers.regfile[10], top_single.registers.regfile[11]);
	$display("[$t4] = %d, [$t5] = %d, [$t6] = %d", top_single.registers.regfile[12], 
		top_single.registers.regfile[13], top_single.registers.regfile[14]);
	$display("[$t7] = %d, [$t8] = %d, [$t9] = %d", top_single.registers.regfile[15], 
		top_single.registers.regfile[24], top_single.registers.regfile[25]);
	$display();
	if(clk == 0) begin
		k = k+1;
	end	
end
endmodule




