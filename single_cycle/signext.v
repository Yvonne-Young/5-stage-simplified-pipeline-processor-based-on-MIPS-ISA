//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/2							   *
//				module: signext								   *
//**********************************************************************************************************

`timescale 1ns/1ns

module signext(inst,data);

input wire [15:0] inst;
output wire [31:0] data;

reg [16:0] tmp;		//fill the high bits with 0 or 1
reg [14:0] com;		//complement

always@(*)
begin
if(!inst[15])		//the instant is larger than zero, fill the high bits with 0
	tmp = 17'b0;
else			//the instant is smaller than zero, fill the high bits with 1
	tmp = 17'b1111_1111_1111_1111_1;
end

always@(*)
begin
if(!inst[15])
	com = inst[14:0];
else
	com = (~(inst[14:0])) + 1;
end

assign data = {tmp, com};

endmodule

	
