//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/2							   *
//				module: Dmemory								   *
//**********************************************************************************************************

`timescale 1ns/1ns

module Dmemory(
		clk,
		rst_n,
		address,
		write_data,
		mem_write,
		mem_read,
		data_out
		);

input wire clk;
input wire rst_n;
input wire [31:0] address;
input wire [31:0] write_data;
input wire mem_write;
input wire mem_read;
output wire [31:0] data_out;

reg [31:0] Data_memory[0:31];

assign data_out = mem_read?Data_memory[address]:32'b0;

always@(posedge clk or negedge rst_n)
begin
if(!rst_n)	begin			//initialize the data memory
	Data_memory[0]<=32'b0;
	Data_memory[1]<=32'b0;
	Data_memory[2]<=32'b0;
	Data_memory[3]<=32'b0;
	Data_memory[4]<=32'b0;
	Data_memory[5]<=32'b0;
	Data_memory[6]<=32'b0;
	Data_memory[7]<=32'b0;
	Data_memory[8]<=32'b0;
	Data_memory[9]<=32'b0;
	Data_memory[10]<=32'b0;
	Data_memory[11]<=32'b0;
	Data_memory[12]<=32'b0;
	Data_memory[13]<=32'b0;
	Data_memory[14]<=32'b0;
	Data_memory[15]<=32'b0;
	Data_memory[16]<=32'b0;
	Data_memory[17]<=32'b0;
	Data_memory[18]<=32'b0;
	Data_memory[19]<=32'b0;
	Data_memory[20]<=32'b0;
	Data_memory[21]<=32'b0;
	Data_memory[22]<=32'b0;
	Data_memory[23]<=32'b0;
	Data_memory[24]<=32'b0;
	Data_memory[25]<=32'b0;
	Data_memory[26]<=32'b0;
	Data_memory[27]<=32'b0;
	Data_memory[28]<=32'b0;
	Data_memory[29]<=32'b0;
	Data_memory[30]<=32'b0;
	Data_memory[31]<=32'b0;
end
else if(mem_write && !mem_read)
	Data_memory[address[4:0]]<=write_data;
else 
	Data_memory[address[4:0]]<=Data_memory[address[4:0]];
end

endmodule
