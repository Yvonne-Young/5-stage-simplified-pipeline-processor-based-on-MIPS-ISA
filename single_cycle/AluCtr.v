//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/2							   *
//				module: AluCtr								   *
//**********************************************************************************************************

`timescale 1ns/1ns

module AluCtr(aluOp,funct,AluCtrOut);

input wire [1:0] aluOp;		
input wire [5:0] funct;
output reg [3:0] AluCtrOut;

always@(*)
if(aluOp == 2'b00)	AluCtrOut = 4'b0010;	//lw/sw
else if(aluOp == 2'b01)	AluCtrOut = 4'b0110;	//beq
else if(aluOp == 2'b11) AluCtrOut = 4'b0010;	//addi
else if(aluOp == 2'b10)	
begin
	case(funct)	
	6'b100000:	AluCtrOut = 4'b0010;
	6'b100010:	AluCtrOut = 4'b0110;
	6'b100100:	AluCtrOut = 4'b0000;
	6'b100101:	AluCtrOut = 4'b0001;
	6'b101010:	AluCtrOut = 4'b0111;
	default:	AluCtrOut = 4'b1111;		
	endcase
end
else	AluCtrOut = 4'b1111;	

endmodule
