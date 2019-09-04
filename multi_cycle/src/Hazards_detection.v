//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/4							   *
//				module: Hazard_detection						   *
//**********************************************************************************************************

`timescale 1ns/1ns

module Hazard_detection(
                        IF_ID_instruction,      //instruction needed for hazard detection
                        EX_ID_rt,         //From the previous instrcution, which is the destination of lw
                        EX_ID_memory_read,//Together with Rt to judge the hazard
                        
                        //outputs
                        pc_enable,      //when 1, pc can change; when 0, pc can't be changed
                        IF_enable,      //when 1, IF registers can be changed
                        ID_enable       //when 1, ID registers can be changed
                        );
                      
input IF_ID_instruction;
wire [31:0]IF_ID_instruction;

input EX_ID_rt;
wire [4:0]EX_ID_rt;

input EX_ID_memory_read;
wire  EX_ID_memory_read;

output pc_enable;
wire   pc_enable;

output IF_enable;
wire   IF_enable;

output ID_enable;
wire   ID_enable;

//only lw and R-type needs stall
wire [4:0]IF_ID_rt;
wire [4:0]IF_ID_rs;

assign IF_ID_rt=IF_ID_instruction[20:16];
assign IF_ID_rs=IF_ID_instruction[25:21];

assign pc_enable=(((EX_ID_rt==IF_ID_rt)||(EX_ID_rt==IF_ID_rs))&&EX_ID_memory_read)?0:1;
assign IF_enable=(((EX_ID_rt==IF_ID_rt)||(EX_ID_rt==IF_ID_rs))&&EX_ID_memory_read)?0:1;
assign ID_enable=(((EX_ID_rt==IF_ID_rt)||(EX_ID_rt==IF_ID_rs))&&EX_ID_memory_read)?0:1;

endmodule
    