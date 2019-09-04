//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/4							   *
//				module: MEM								   *
//**********************************************************************************************************

`timescale 1ns/1ns

module MEM(clk,rst_n,
           EX_MEM_register_write,        //input control signal,write ALU result from EX stage to register
           EX_MEM_memory_to_register,    //input control signal, write memory data to register
           EX_MEM_memory_read,           //input control signal, read memory data
           EX_MEM_memory_write,          //input control signal, write data 
           
           EX_MEM_register_write_address,//write data's address from EX stage 
           EX_MEM_alu_result,            //input data from ALU
           EX_MEM_memory_address,        //input address of writing data in memory
           EX_MEM_memory_write_data,     //input data of writing in data memory
           
           EX_MEM_branch_target,         //The branch_target         
           EX_MEM_branch,                //If IE_IF_branch=1, go to the branch target, else, go to pc+4 
           EX_MEM_zero, 
           
           //input of forwarding
           EX_MEM_r,
           
           //output 
           EX_IF_branch,
           EX_IF_branch_target,
           
           MEM_WB_memory_to_register,    //output control signal, write memory data to register
           MEM_WB_register_write,        //output control signal, write ALU result from MEM stage to register
           MEM_WB_register_write_address,//output write address
           MEM_WB_read_data,             //output of data from memory
           MEM_WB_alu_result,
           
           //output of forwarding
           MEM_EX_r,
           MEM_WB_r,
           MEM_EX_alu_result,
           MEM_EX_register_write
           );           //output of alu result 

/*******************input signals of MEM_WB registers***********************************/
input clk,rst_n;
wire  clk,rst_n;

input EX_MEM_register_write;
input EX_MEM_memory_to_register;

wire  EX_MEM_register_write;
wire  EX_MEM_memory_to_register;              

input EX_MEM_alu_result;
wire  [31:0]EX_MEM_alu_result;

input EX_MEM_register_write_address;
wire  [4:0]EX_MEM_register_write_address;

input EX_MEM_branch_target;
wire  [31:0]EX_MEM_branch_target;

input EX_MEM_branch,EX_MEM_zero;
wire  EX_MEM_branch,EX_MEM_zero;

input EX_MEM_r;
wire  [4:0]EX_MEM_r;
/****************************input signals of Data_Memory****************************/
input EX_MEM_memory_read;   //control signal of reading data from memory//
wire  EX_MEM_memory_read;

input EX_MEM_memory_write; //control signal of reading data from memory//
wire  EX_MEM_memory_write;

input EX_MEM_memory_address;//data address in memory from  the EX stage//
wire  [31:0]EX_MEM_memory_address;   

input EX_MEM_memory_write_data;//data from EX to write into memory//
wire  [31:0]EX_MEM_memory_write_data;  


/****************************interval signals****************************/
wire  [31:0]DM_MEM_read_data;

/*******************output signals*******************************/
output MEM_WB_memory_to_register,MEM_WB_register_write;
wire   MEM_WB_memory_to_register,MEM_WB_register_write;

output MEM_WB_register_write_address;
wire  [4:0]MEM_WB_register_write_address;

output MEM_WB_alu_result;
wire  [31:0]MEM_WB_alu_result;

output MEM_WB_read_data;
wire  [31:0]MEM_WB_read_data;

output EX_IF_branch;
wire   EX_IF_branch;

output EX_IF_branch_target;
wire [31:0]EX_IF_branch_target;

output MEM_EX_r;
wire   [4:0]MEM_EX_r;

output MEM_WB_r;
wire  [4:0]MEM_WB_r;

output MEM_EX_alu_result;
wire   [31:0]MEM_EX_alu_result;

output MEM_EX_register_write;
wire   MEM_EX_register_write;

reg [4:0]MEM_WB_r_reg;
reg [4:0]MEM_EX_r_reg;
reg [31:0]MEM_EX_alu_result_reg;
reg MEM_EX_register_write_reg;


//Use module data memory
Data_mem Data_memory(clk,rst_n,
                     EX_MEM_memory_read,    
                     EX_MEM_memory_write,   
                     EX_MEM_memory_address, 
                     EX_MEM_memory_write_data,   
                 
                     DM_MEM_read_data);

//Use module MEM_WB_stage
MEM_WB MEM_WB_stage(clk,rst_n,
                    EX_MEM_register_write,        //input control signal,write ALU result from EX stage to register
                    EX_MEM_memory_to_register,    //input control signal, write memory data to register
                    EX_MEM_register_write_address,//write data's address from EX stage 
                    DM_MEM_read_data,             //input data from memory 
                    EX_MEM_memory_address,        //input address from ALU result
                 
                    MEM_WB_memory_to_register,    //output control signal, write memory data to register
                    MEM_WB_register_write,        //output control signal, write ALU result from MEM stage to register
                    MEM_WB_register_write_address,//output write address
                    MEM_WB_read_data,             //output of data from memory
                    MEM_WB_alu_result             //output of alu result 
                    ); 

always @(posedge clk or negedge rst_n)
if(~rst_n)begin
  MEM_WB_r_reg<=5'b0;
end
else begin
  MEM_WB_r_reg<=EX_MEM_r;
end

/*
always @(posedge clk or negedge rst_n)
if(~rst_n)begin
  MEM_EX_r_reg<=5'b0;
end
else begin
  MEM_EX_r_reg<=EX_MEM_r;
end
*/

/*
always @(posedge clk or negedge rst_n)
if(~rst_n)begin
  MEM_EX_alu_result_reg=32'b0;
end
else begin
  MEM_EX_alu_result_reg=EX_MEM_alu_result;
end 
*/

/*
always @(posedge clk or negedge rst_n)
if(~rst_n)begin
  MEM_EX_register_write_reg<=1'b0;
end
else begin
  MEM_EX_register_write_reg=EX_MEM_register_write;
end
*/

assign EX_IF_branch=(EX_MEM_branch&&EX_MEM_zero)?1'b1:1'b0;
assign EX_IF_branch_target=EX_MEM_branch_target;

//outputs of forwarding signals
assign MEM_EX_r=EX_MEM_r;
assign MEM_WB_r=MEM_WB_r_reg;

assign MEM_EX_alu_result=EX_MEM_alu_result;
assign MEM_EX_register_write=EX_MEM_register_write;

endmodule
