//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/2							   *
//				module: Testbench							   *
//**********************************************************************************************************

`timescale 1ns / 1ps

module TestBench_multi;

reg clk;
reg rst_n;
integer k;
TOP TOP(clk,rst_n);

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
	$display("[$s0] = %d, [$s1] = %d, [$s2] = %d", TOP.TOP_ID.register_1.registers[16], 
		TOP.TOP_ID.register_1.registers[17], TOP.TOP_ID.register_1.registers[18]);	
	$display("[$s3] = %d, [$s4] = %d, [$s5] = %d", TOP.TOP_ID.register_1.registers[19], 
		TOP.TOP_ID.register_1.registers[20], TOP.TOP_ID.register_1.registers[21]);
	$display("[$s6] = %d, [$s7] = %d, [$t0] = %d", TOP.TOP_ID.register_1.registers[22], 
		TOP.TOP_ID.register_1.registers[23], TOP.TOP_ID.register_1.registers[8]);
	$display("[$t1] = %d, [$t2] = %d, [$t3] = %d", TOP.TOP_ID.register_1.registers[9], 
		TOP.TOP_ID.register_1.registers[10], TOP.TOP_ID.register_1.registers[11]);
	$display("[$t4] = %d, [$t5] = %d, [$t6] = %d", TOP.TOP_ID.register_1.registers[12], 
		TOP.TOP_ID.register_1.registers[13], TOP.TOP_ID.register_1.registers[14]);
	$display("[$t7] = %d, [$t8] = %d, [$t9] = %d", TOP.TOP_ID.register_1.registers[15], 
		TOP.TOP_ID.register_1.registers[24], TOP.TOP_ID.register_1.registers[25]);
	$display();
	if(clk == 0) begin
		k = k+1;
	end	
end
endmodule





