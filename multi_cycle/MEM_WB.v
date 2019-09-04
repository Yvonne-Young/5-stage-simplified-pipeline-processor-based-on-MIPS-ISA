//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/4							   *
//				module: MEM_WB								   *
//**********************************************************************************************************

`timescale 1ns/1ns

module MEM_WB(clk,rst_n,
              EX_MEM_register_write,        //input control signal,write ALU result from EX stage to register
              EX_MEM_memory_to_register,    //input control signal, write memory data to register
              EX_MEM_register_write_address,//write data's address from EX stage 
              DM_MEM_read_data,             //input data from memory 
              EX_MEM_memory_address,        //input data from ALU,which is ALU result
                 
              MEM_WB_memory_to_register,    //output control signal, write memory data to register
              MEM_WB_register_write,        //output control signal, write ALU result from MEM stage to register
              MEM_WB_register_write_address,//output write address
              MEM_WB_read_data,             //output of data from memory
              MEM_WB_alu_result             //output of alu result 
              ); 

//*******************input signals***********************************
input clk,rst_n;
wire  clk,rst_n;

input EX_MEM_register_write;
input EX_MEM_memory_to_register;

wire  EX_MEM_register_write;
wire  EX_MEM_memory_to_register;              

input DM_MEM_read_data;
wire  [31:0]DM_MEM_read_data;

input EX_MEM_memory_address;
wire  [31:0]EX_MEM_memory_address;

input EX_MEM_register_write_address;
wire  [4:0]EX_MEM_register_write_address;

//*******************output signals***********************************
output MEM_WB_memory_to_register,MEM_WB_register_write;
wire   MEM_WB_memory_to_register,MEM_WB_register_write;

output MEM_WB_register_write_address;
wire  [4:0]MEM_WB_register_write_address;

output MEM_WB_alu_result;
wire  [31:0]MEM_WB_alu_result;

output MEM_WB_read_data;  //result of data memory
wire  [31:0]MEM_WB_read_data;

//registers
reg [31:0]MEM_WB_read_data_reg;
reg [31:0]MEM_WB_alu_result_reg;
reg [4:0]MEM_WB_register_write_address_reg;
reg MEM_WB_memory_to_register_reg;
reg MEM_WB_register_write_reg;

//*********************************************************************
//memory_to register signal
always @(posedge clk or negedge rst_n)begin
if(~rst_n)
  MEM_WB_memory_to_register_reg<=1'b0;
else
  MEM_WB_memory_to_register_reg<=EX_MEM_memory_to_register;
end

//alu write control signal
always @(posedge clk or negedge rst_n)begin
if(~rst_n)
  MEM_WB_register_write_reg<=1'b0;
else
  MEM_WB_register_write_reg<=EX_MEM_register_write;
end

//data read from memory
always @(posedge clk or negedge rst_n)begin
if(~rst_n)
  MEM_WB_read_data_reg<=32'b0;
else
  MEM_WB_read_data_reg<=DM_MEM_read_data;
end

// data get from ALU
always @(posedge clk or negedge rst_n)begin
if(~rst_n)
  MEM_WB_alu_result_reg<=32'b0;
else
  MEM_WB_alu_result_reg<=EX_MEM_memory_address;
end

//register write address
always @(posedge clk or negedge rst_n)begin
if(~rst_n)
  MEM_WB_register_write_address_reg<=32'b0;
else
  MEM_WB_register_write_address_reg<=EX_MEM_register_write_address;
end

//********************************************************************
//the control signal
assign MEM_WB_memory_to_register=MEM_WB_memory_to_register_reg;
assign MEM_WB_register_write=MEM_WB_register_write_reg;

//the data 
assign MEM_WB_read_data=MEM_WB_read_data_reg;
assign MEM_WB_alu_result=MEM_WB_alu_result_reg;

//register address to write data
assign MEM_WB_register_write_address=MEM_WB_register_write_address_reg;

endmodule
