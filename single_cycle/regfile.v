//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/2							   *
//				module: regfile								   *
//**********************************************************************************************************

`timescale 1ns/1ns

module regfile(clk,rst_n,readReg1,readReg2,WriteReg,WriteData,regWrite,readData1,readData2);

input wire clk,rst_n,regWrite;	//regWrite is the signal to judge wheter to write or not
input wire [25:21] readReg1;	//address of the firsr register to read from
input wire [20:16] readReg2;	//address of the second register to read from
input wire [4:0] WriteReg;	//address of the register to write data
input wire [31:0] WriteData;	//data to write in
output wire [31:0] readData1;	//output data1
output wire [31:0] readData2;	//output data2

reg[31:0]regfile[0:31];	//a memory of 32 registers

assign readData1 = regfile[readReg1];
assign readData2 = regfile[readReg2];

always@(posedge clk or negedge rst_n)
begin
if(!rst_n)	//initialize the register file
begin	
	regfile[0] <= 32'h0;
	regfile[1] <= 32'h0;
	regfile[2] <= 32'h0;
	regfile[3] <= 32'h0;
	regfile[4] <= 32'h0;
	regfile[5] <= 32'h0;	
	regfile[6] <= 32'h0;
	regfile[7] <= 32'h0;
	regfile[8] <= 32'h0;
	regfile[9] <= 32'h0;
	regfile[10] <= 32'h0;
	regfile[11] <= 32'h0;
	regfile[12] <= 32'h0;
	regfile[13] <= 32'h0;
	regfile[14] <= 32'h0;
	regfile[15] <= 32'h0;
	regfile[16] <= 32'h0;
	regfile[17] <= 32'h0;
	regfile[18] <= 32'h0;
	regfile[19] <= 32'h0;
	regfile[20] <= 32'h0;
	regfile[21] <= 32'h0;
	regfile[22] <= 32'h0;
	regfile[23] <= 32'h0;
	regfile[24] <= 32'h0;
	regfile[25] <= 32'h0;
	regfile[26] <= 32'h0;
	regfile[27] <= 32'h0;
	regfile[28] <= 32'h0;
	regfile[29] <= 32'h0;
	regfile[30] <= 32'h0;
	regfile[31] <= 32'h0;
end
else if(regWrite)
	regfile[WriteReg] <= WriteData[31:0];
else
	regfile[WriteReg] <= regfile[WriteReg];
end

endmodule
            
              


