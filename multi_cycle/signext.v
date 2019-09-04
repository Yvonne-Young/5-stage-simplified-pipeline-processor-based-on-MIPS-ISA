//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/2							   *
//				module: signext								   *
//**********************************************************************************************************

`timescale 1ns/1ns

module signext(inst,data);

input wire [15:0] inst;
output reg [31:0] data;

always@(*)	begin
if(inst[15] == 1)	data = {16'b1111_1111_1111_1111,inst};
else			data = {16'b0,inst};
end

endmodule

	
