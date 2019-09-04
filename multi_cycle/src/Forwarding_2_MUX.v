//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/4							   *
//				module: Forwarding_2_MUX						   *
//**********************************************************************************************************

`timescale 1ns/1ns

module Forwarding_2_MUX(
                        control,
                        Rt,
                        Rd,
                        
                        Output);

input control;
wire  control;

input Rt;
wire  [4:0]Rt;

input Rd;
wire  [4:0]Rd;

output Output;
wire   [4:0]Output;

assign Output=(control==1)?Rt:Rd;

endmodule
                        
                        
