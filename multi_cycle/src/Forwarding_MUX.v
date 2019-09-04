//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/4							   *
//				module: Forwarding_MUX							   *
//**********************************************************************************************************

`timescale 1ns/1ns

module Forwarding_MUX(//inputs
                      Select,
                      ALU_result,
                      WB_result,
                      read_data,
                      
                      //output
                      selected
                      );

input Select;
wire  [1:0]Select;

input ALU_result;
wire  [31:0]ALU_result;

input WB_result;
wire  [31:0]WB_result;

input read_data;
wire  [31:0]read_data;

output selected;
wire  [31:0]selected;

assign selected=(Select==2'b01)?ALU_result:(Select==2'b10)?WB_result:read_data;

endmodule
