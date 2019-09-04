//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/4							   *
//				module: EX_alu_control							   *
//**********************************************************************************************************

`timescale 1ns/1ns

module EX_alu_control(
                       funct                              //instruction[5:0]
                      ,alu_operation                      //The 2-bit numbber from ID stage
                      ,operation                         //It will be sent to alu, to control its operation
                      );
                      
input  funct;
input  alu_operation;
output operation;

wire [5:0]funct;
wire [1:0]alu_operation;
reg  [3:0]operation;

always @(alu_operation or funct)
casex({alu_operation,funct})
8'b00xxxxxx: operation[3:0]=4'b0010;   //lw and sw
8'b01xxxxxx: operation[3:0]=4'b0110;   //beq
8'b10100000: operation[3:0]=4'b0010;   //add
8'b10100010: operation[3:0]=4'b0110;   //sub
8'b10100100: operation[3:0]=4'b0000;   //and
8'b10100101: operation[3:0]=4'b0001;   //or
8'b10101010: operation[3:0]=4'b0111;   //slt
8'b11xxxxxx: operation[3:0]=4'b0010;   //addi
default    : operation[3:0]=4'b0000;   //Other conditions
endcase

endmodule
