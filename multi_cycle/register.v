//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/4							   *
//				module: register							   *
//**********************************************************************************************************

`timescale 1ns/1ns

module register(
                clk                           //clock signal
               ,rst_n                        //0:reset, 1:reset
               ,read_register_1              //instruction[25:21]
               ,read_register_2              //instruction[20:16]
               ,write_register               //where to write the data
               ,write_data                   //the data to write to the register at the negtive edge of the clock signal
               ,register_write               //wheather to write. 1:write, 0:not write
               ,output_data_1                //the output data of the register
               ,output_data_2                //the output data of the register
               );

input clk;
input rst_n;
input read_register_1;
input read_register_2;
input write_register;
input write_data;
input register_write;

output output_data_1;
output output_data_2;

wire clk;
wire rst_n;
wire [4:0] read_register_1;
wire [4:0] read_register_2;
wire [4:0] write_register;
wire [31:0] write_data;
wire register_write;

wire [31:0] output_data_1;
wire [31:0] output_data_2;

reg[31:0]registers[0:31]; //32 registers of this module

always@(negedge clk or negedge rst_n)//write register at the negtive edge the of clock signal
if(!rst_n) begin                         //reset the data
  registers[0]<=32'b0;
  registers[1]<=32'b0;
  registers[2]<=32'b0;
  registers[3]<=32'b0;
  registers[4]<=32'b0;
  registers[5]<=32'b0;
  registers[6]<=32'b0;
  registers[7]<=32'b0;
  registers[8]<=32'd0;
  registers[9]<=32'd0;
  registers[10]<=32'b0;
  registers[11]<=32'b0;
  registers[12]<=32'b0;
  registers[13]<=32'b0;
  registers[14]<=32'b0;
  registers[15]<=32'b0;
  registers[16]<=32'b0;
  registers[17]<=32'b0;
  registers[18]<=32'b0;
  registers[19]<=32'b0;
  registers[20]<=32'b0;
  registers[21]<=32'b0;
  registers[22]<=32'b0;
  registers[23]<=32'b0;
  registers[24]<=32'b0;
  registers[25]<=32'b0;
  registers[26]<=32'b0;
  registers[27]<=32'b0;
  registers[28]<=32'b0; 
  registers[29]<=32'b0;
  registers[30]<=32'b0;
  registers[31]<=32'b0;
end                         
else if(register_write)              //if register_write=1, write; else not write
  registers[write_register]<=write_data[31:0];
else begin
  registers[0]<=registers[0];
  registers[1]<=registers[1];
  registers[2]<=registers[2];
  registers[3]<=registers[3];
  registers[4]<=registers[4];
  registers[5]<=registers[5];
  registers[6]<=registers[6];
  registers[7]<=registers[7];
  registers[8]<=registers[8];
  registers[9]<=registers[9];
  registers[10]<=registers[10];
  registers[11]<=registers[11];
  registers[12]<=registers[12];
  registers[13]<=registers[13];
  registers[14]<=registers[14];
  registers[15]<=registers[15];
  registers[16]<=registers[16];
  registers[17]<=registers[17];
  registers[18]<=registers[18];
  registers[19]<=registers[19];
  registers[20]<=registers[20];
  registers[21]<=registers[21];
  registers[22]<=registers[22];
  registers[23]<=registers[23];
  registers[24]<=registers[24];
  registers[25]<=registers[25];
  registers[26]<=registers[26];
  registers[27]<=registers[27];
  registers[28]<=registers[28];
  registers[29]<=registers[29];
  registers[30]<=registers[30];
  registers[31]<=registers[31];
end

//outputs
assign output_data_1=registers[read_register_1];
assign output_data_2=registers[read_register_2];

endmodule


              
              
