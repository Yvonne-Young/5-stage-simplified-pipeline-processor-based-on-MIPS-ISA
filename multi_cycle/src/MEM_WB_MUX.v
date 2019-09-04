//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/4							   *
//				module: MEM_WB_MUX							   *
//**********************************************************************************************************

`timescale 1ns/1ns

module MEM_WB_MUX(MEM_WB_memory_to_register,    //control signal,select the data from memory
                  MEM_WB_read_data,             //output of data from memory
                  MEM_WB_alu_result,            //output of alu result 
           
                  MEM_WB_register_write_data    //output select by this mux
                  );  

//input         
input MEM_WB_memory_to_register;
wire  MEM_WB_memory_to_register;

input MEM_WB_read_data;
wire  [31:0]MEM_WB_read_data;

input MEM_WB_alu_result;
wire  [31:0]MEM_WB_alu_result;

//output
output MEM_WB_register_write_data;
wire  [31:0]MEM_WB_register_write_data;

assign MEM_WB_register_write_data=(MEM_WB_memory_to_register==1)?MEM_WB_read_data:MEM_WB_alu_result;

endmodule