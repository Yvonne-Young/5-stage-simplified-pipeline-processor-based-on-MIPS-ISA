//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/4							   *
//				module: EX_alu								   *
//**********************************************************************************************************

`timescale 1ns/1ns 

module EX_alu(
               source_1                         //The source operand
              ,source_2                         //The other source operand
              ,operation                    //The signal which determines what the alu should do 
              ,zero                             //If source_1=source_2, zero=1, else zero=0
              ,alu_result                       //The result of alu
              );
             
input  source_1;
input  source_2;
input  operation;
output zero;
output alu_result;

wire [31:0]source_1;
wire [31:0]source_2;
wire [3:0]operation;
reg  zero;
reg  [31:0]alu_result;

always @(source_1 or source_2 or operation)
case(operation)
  4'b0000: begin alu_result=source_1 & source_2;  zero=0; end                      //and 
  4'b0001: begin alu_result=source_1 | source_2;  zero=0; end                      //or
  4'b0010: begin alu_result=source_1 + source_2;  zero=0; end                      //add lw sw  
  4'b0110: begin alu_result=source_1 - source_2;  zero=(alu_result==32'b0); end    //sub beq
  4'b0111: begin 								   //slt. If(source_1<source_2) alu_result=1, else alu_result=1
	if(source_1<source_2)	alu_result = 1;
	else	alu_result = 0;
	end                      
  default: begin alu_result=source_1 + source_2;  zero=0; end                      //Other condition                   
endcase

endmodule