//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/2							   *
//				module: top_single							   *
//**********************************************************************************************************

`timescale 1ns / 1ns

module top_single(clk,rst_n);

input wire clk,rst_n;

reg [31:0] pc;
wire [31:0] pc_tmp;
assign pc_tmp=pc+4;
reg [31:0] pc_tmp2;			//delay pc for a cycle

wire [31:0] address;
wire [31:0] instruction;

wire [31:0] source1;			//alu operation source1
wire [31:0] source2;			//alu operation source2
wire zero;

wire [31:0] mux1_source2;
reg [31:0] mux2_source1;
wire [31:0] mux2_source2;
wire mux1_control;

//instantiate the IM module
assign address=pc;

IM Instruction_memory(
		.address(address),
		.instruction(instruction)
		);


//instantiate the Ctr module
wire aluSrc;
wire mem2reg;
wire regWrite;
wire memRead;
wire memWrite;
wire branch;
wire [1:0] aluOp;
wire jump;
wire regDst;

Ctr control(
		.opCode(instruction[31:26]),
		.aluSrc(aluSrc),
		.memToReg(mem2reg),
		.regWrite(regWrite),
		.memRead(memRead),
		.memWrite(memWrite),
		.branch(branch),
		.aluOp(aluOp),
		.jump(jump),
		.regDst(regDst)
		);


//instantiate the regfile module
wire [31:0] AluRes;
wire [31:0] memory_data_out;
wire [4:0] WriteReg;			//the address of regfile
wire [31:0] WriteData;
wire [31:0] readData1;
wire [31:0] readData2;
assign WriteReg=regDst?instruction[15:11]:instruction[20:16];
assign WriteData=mem2reg?memory_data_out:AluRes;

regfile registers(
		.clk(clk),
		.rst_n(rst_n),
		.readReg1(instruction[25:21]),
		.readReg2(instruction[20:16]),
		.WriteReg(WriteReg),
		.WriteData(WriteData),
		.regWrite(regWrite),
		.readData1(readData1),
		.readData2(readData2)
		);


//instantiate the AluCtr module
wire [3:0] AluCtrOut;

AluCtr alu_control(
		.aluOp(aluOp),
		.funct(instruction[5:0]),
		.AluCtrOut(AluCtrOut)		
		);

//instantiate the signext module
wire [31:0] immediate_extended;

signext signextend(
		.inst(instruction[15:0]),
		.data(immediate_extended)
		);


//instantiate the ALU module
assign mux1_control=branch && zero;
assign mux1_source2=pc_tmp+(immediate_extended<<2);
assign mux2_source2=mux1_control?mux1_source2:pc_tmp;
assign source1=readData1;
assign source2=aluSrc?immediate_extended:readData2;

ALU alu(
		.in1(source1),
		.in2(source2),
		.AluCtrOut(AluCtrOut),
		.zero(zero),
		.AluRes(AluRes)
		);


//instantiate the Dmemory module
Dmemory data_memory(
		.clk(clk),
		.rst_n(rst_n),
		.address(AluRes),
		.write_data(readData2),
		.mem_write(memWrite),
		.mem_read(memRead),
		.data_out(memory_data_out)
		);

//some other signals
always@(*)
if(!jump)
	pc_tmp2 = mux2_source1;
else
	pc_tmp2 = mux2_source2;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	mux2_source1<=32'b0;
else 
	mux2_source1<={pc_tmp[31:28],(instruction[27:0]<<2)};

always@(posedge clk or negedge rst_n)
if(!rst_n)
	pc<=32'b0;
else
	pc<=pc_tmp2;

endmodule