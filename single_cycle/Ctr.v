//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/2							   *
//				module: Ctr								   *
//**********************************************************************************************************

`timescale 1ns/1ns

module Ctr(opCode,aluSrc,memToReg,regWrite,memRead,memWrite,branch,aluOp,jump,regDst);

input wire [5:0] opCode;//operation code, instruction[31:26]
output reg regDst;	
output reg aluSrc;	
output reg memToReg;	
output reg regWrite;	
output reg memRead;	
output reg memWrite;	
output reg branch;	
output reg [1:0] aluOp;	
output reg jump;

always@(opCode)
begin
	case(opCode)	
		6'b100011:	//lw
		begin
		regDst = 0;
		aluSrc = 1;
		memToReg = 1;
		regWrite = 1;
		memRead = 1;
		memWrite = 0;
		branch = 0;
		aluOp = 2'b00;
		jump = 1;
		end 
		
		6'b101011:	//sw
		begin
		regDst = 1;
		aluSrc = 1;
		memToReg = 1;
		regWrite = 0;
		memRead = 0;
		memWrite = 1;
		branch = 0;
		aluOp = 2'b00;
		jump = 1;
		end
		
		6'b000100:	//beq
		begin
		regDst = 1;
		aluSrc = 0;
		memToReg = 1;
		regWrite = 0;
		memRead = 0;
		memWrite = 0;
		branch = 1;
		aluOp = 2'b01;
		jump = 1;
		end
		
		6'b000000:	//R-type
		begin
		regDst = 1;
		aluSrc = 0;
		memToReg = 0;
		regWrite = 1;
		memWrite = 0;
		memRead = 0;
		branch = 0;
		aluOp = 2'b10;
		jump = 1;
		end

		6'b000010:	//jump
		begin
		regDst = 0;
		aluSrc = 0;
		memToReg = 0;
		regWrite = 0;
		memWrite = 0;
		memRead = 0;
		branch = 0;
		aluOp = 2'b00;
		jump = 0;
		end	
		
		6'b001000:	//addi
		begin
		regDst = 0;
		aluSrc = 1;
		memToReg = 0;
		regWrite = 1;
		memWrite = 0;
		memRead = 0;
		branch = 0;
		aluOp = 2'b11;
		jump = 1;
		end
		
		default:
		begin
		regDst = 0;
		aluSrc = 0;
		memToReg = 0;
		regWrite = 0;
		memRead = 0;
		memWrite = 0;
		branch = 0;
		aluOp = 2'b00;
		jump = 1;
		end
	endcase
end

endmodule
