//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/4							   *
//				module: TOP								   *
//**********************************************************************************************************

`timescale 1ns/1ns

module TOP(clk,rst_n);

input clk,rst_n;
wire  clk,rst_n;

//signals of IF stage
wire  IF_enable;
wire  pc_enable;
wire  [31:0]ID_IF_jump_target;
wire  ID_IF_jump;
wire ID_IF_branch;

wire [31:0]IF_ID_instruction;
wire [31:0]IF_ID_pc;
wire [1:0]IF_ID_predictor;
wire [31:0]IF_ID_branch_target_predict;

//signals of ID stage
wire  [4:0]MEM_WB_register_write_address;
wire  [31:0]MEM_WB_register_write_data;
wire  MEM_WB_register_write;

wire [31:0]ID_EX_output_data_1;
wire [31:0]ID_EX_output_data_2;
wire [4:0]ID_EX_rt;
wire [4:0]ID_EX_rd;
wire [31:0]ID_EX_immediate_extended;
wire [31:0]ID_EX_pc;
wire ID_EX_alusrc;
wire [1:0]ID_EX_alu_operation;
wire ID_EX_memory_read;
wire ID_EX_memory_write;
wire ID_EX_branch;
wire ID_EX_memory_to_register;
wire ID_EX_register_write;


wire [4:0]ID_EX_rs;

wire [1:0]ID_EX_predictor;
wire [31:0]ID_EX_branch_target_predict;

//signals of EX stage
wire flush;

wire [31:0]EX_IF_branch_target;    
wire EX_IF_branch; 
wire EX_IF_zero;
wire [31:0]EX_IF_pc;
wire [1:0]EX_IF_predicotr;
wire [31:0]EX_IF_branch_target_predict;
wire [31:0]EX_MEM_alu_result;
wire [31:0]EX_MEM_memory_write_data;
wire [4:0]EX_MEM_register_write_address;
wire EX_MEM_memory_read;
wire EX_MEM_memory_write;
wire EX_MEM_memory_to_register;    
wire EX_MEM_register_write;

wire EX_ID_memory_read;
wire [4:0]EX_ID_rt;
wire [4:0]EX_MEM_r;

//signals of MEM stage
wire  [31:0]MEM_WB_alu_result;
wire  [31:0]MEM_WB_read_data;

wire  [4:0]MEM_EX_r;
wire  [4:0]MEM_WB_r;
wire  [31:0]MEM_EX_alu_result;      
wire  MEM_EX_register_write;

//**********************IF stage******************************************
IF TOP_IF(.clk(clk),                                //clock signal
          .IF_rst_n(rst_n),                         //reset
          .IF_flush(flush),                     
          .pc_enable(pc_enable),                              //if pc_enable=1, pc can change
          .IF_enable(IF_enable),                    //if IF_enable=1, the value of the IF_ID stage and the value of pc can change
          .EX_IF_branch(EX_IF_branch),              //branch signal
          .EX_IF_branch_target(EX_IF_branch_target),//the branch target
	  .EX_IF_branch_target_predict(EX_IF_branch_target_predict),
          .EX_IF_zero(EX_IF_zero),                  //zero
          .EX_IF_pc(EX_IF_pc),               
          .ID_IF_jump_target(ID_IF_jump_target),    //jump target
          .ID_IF_jump(ID_IF_jump),                  //jump signal
          .ID_IF_branch(ID_IF_branch),
          
          .IF_ID_instruction(IF_ID_instruction),    //The output instruction
          .IF_ID_pc(IF_ID_pc),                       //The value of pc+4   
          .IF_ID_predictor(IF_ID_predictor),
          .IF_ID_branch_target_predict(IF_ID_branch_target_predict)
          );

 

//***********************ID stage*******************************************
ID TOP_ID(
          .clk(clk)
         ,.ID_rst_n(rst_n)
         ,.ID_flush(flush)
         ,.ID_enable(ID_enable)
         ,.register_rst_n(rst_n)
         ,.IF_ID_instruction(IF_ID_instruction)
         ,.IF_ID_pc(IF_ID_pc)
         ,.IF_ID_predictor(IF_ID_predictor)
         ,.IF_ID_branch_target_predict(IF_ID_branch_target_predict)
         ,.WB_ID_register_write(MEM_WB_register_write)           
         ,.WB_ID_write_register(MEM_WB_register_write_address)
         ,.WB_ID_write_data(MEM_WB_register_write_data)
         
         ,.EX_ID_rt(EX_ID_rt)
         ,.EX_ID_memory_read(EX_ID_memory_read)
         
         ,.IF_enable(IF_enable)
         ,.pc_enable(pc_enable)
         ,.ID_IF_jump_target(ID_IF_jump_target)
         ,.ID_IF_jump(ID_IF_jump)
         ,.ID_IF_branch(ID_IF_branch)
         ,.ID_EX_output_data_1(ID_EX_output_data_1)
         ,.ID_EX_output_data_2(ID_EX_output_data_2)
         ,.ID_EX_rt(ID_EX_rt)
         ,.ID_EX_rd(ID_EX_rd)
         ,.ID_EX_rs(ID_EX_rs)
         ,.ID_EX_immediate_extended(ID_EX_immediate_extended)
         ,.ID_EX_pc(ID_EX_pc)
         ,.ID_EX_alusrc(ID_EX_alusrc)
         ,.ID_EX_alu_operation(ID_EX_alu_operation)
         ,.ID_EX_memory_read(ID_EX_memory_read)
         ,.ID_EX_memory_write(ID_EX_memory_write)
         ,.ID_EX_branch(ID_EX_branch)
         ,.ID_EX_memory_to_register(ID_EX_memory_to_register)
         ,.ID_EX_register_write(ID_EX_register_write)

         
         ,.ID_EX_predictor(ID_EX_predictor)
         ,.ID_EX_branch_target_predict(ID_EX_branch_target_predict)
         );
         

//****************EX stage******************************************************
EX TOP_EX(
           .clk(clk)
          ,.EX_rst_n(rst_n)
          ,.ID_EX_branch(ID_EX_branch)
          ,.ID_EX_read_data_1(ID_EX_output_data_1)
          ,.ID_EX_read_data_2(ID_EX_output_data_2)
          ,.ID_EX_rt(ID_EX_rt)
          ,.ID_EX_rd(ID_EX_rd)
          ,.ID_EX_immediate_extended(ID_EX_immediate_extended)
          ,.ID_EX_pc(ID_EX_pc)
          ,.ID_EX_alusrc(ID_EX_alusrc)
          ,.ID_EX_alu_operation(ID_EX_alu_operation)
          ,.ID_EX_memory_read(ID_EX_memory_read)
          ,.ID_EX_memory_write(ID_EX_memory_write)
          ,.ID_EX_memory_to_register(ID_EX_memory_to_register)
          ,.ID_EX_register_write(ID_EX_register_write)
	
          
          ,.ID_EX_predictor(ID_EX_predictor)
          ,.ID_EX_branch_target_predict(IF_ID_branch_target_predict)
          
          //forwrading input
          ,.ID_EX_rs(ID_EX_rs)
          ,.MEM_EX_r(MEM_EX_r)
          ,.MEM_EX_register_write(MEM_EX_register_write)
          ,.MEM_EX_alu_result(MEM_EX_alu_result)
          ,.MEM_WB_r(MEM_WB_r)
          ,.MEM_WB_register_write(MEM_WB_register_write)
          ,.MEM_WB_register_write_data(MEM_WB_register_write_data)
          
          
          ,.EX_MEM_alu_result(EX_MEM_alu_result)
          ,.EX_MEM_memory_write_data(EX_MEM_memory_write_data)
          ,.EX_MEM_register_write_address(EX_MEM_register_write_address)
          ,.EX_MEM_memory_read(EX_MEM_memory_read)
          ,.EX_MEM_memory_write(EX_MEM_memory_write)
          ,.EX_MEM_memory_to_register(EX_MEM_memory_to_register)
          ,.EX_MEM_register_write(EX_MEM_register_write)
          
          //Hazard output 
          ,.EX_ID_rt(EX_ID_rt)
          ,.EX_ID_memory_read(EX_ID_memory_read)
          
          //forwarding output
          ,.EX_MEM_r(EX_MEM_r)
          
          ,.EX_IF_branch_target(EX_IF_branch_target)
          ,.EX_IF_branch(EX_IF_branch)
          ,.EX_IF_zero(EX_IF_zero)
          ,.EX_IF_pc(EX_IF_pc)
          ,.EX_IF_predictor(EX_IF_predictor)
          ,.EX_IF_branch_target_predict(EX_IF_branch_target_predict)
          
          //flush
          ,.flush(flush)
          );

//****************************MEM stage*****************************************
MEM TOP_MEM(.clk(clk),
            .rst_n(rst_n),
            .EX_MEM_memory_read(EX_MEM_memory_read),
            .EX_MEM_memory_write(EX_MEM_memory_write),
            .EX_MEM_memory_address(EX_MEM_alu_result),
            .EX_MEM_memory_write_data(EX_MEM_memory_write_data),
            .EX_MEM_register_write(EX_MEM_register_write),         
            .EX_MEM_memory_to_register(EX_MEM_memory_to_register),     
            .EX_MEM_register_write_address(EX_MEM_register_write_address),             
            .EX_MEM_alu_result(EX_MEM_alu_result),
            .EX_MEM_branch_target(EX_MEM_branch_target),            
            .EX_MEM_branch(EX_MEM_branch),                 
            .EX_MEM_zero(EX_MEM_zero), 
            //forwarding input 
            .EX_MEM_r(EX_MEM_r),
            
            .EX_IF_branch(EX_IF_branch),
            .EX_IF_branch_target(EX_IF_branch_target),
            .MEM_WB_memory_to_register(MEM_WB_memory_to_register),    
            .MEM_WB_register_write(MEM_WB_register_write),         
            .MEM_WB_register_write_address(MEM_WB_register_write_address), 
            .MEM_WB_read_data(MEM_WB_read_data),              
            .MEM_WB_alu_result(MEM_WB_alu_result),
            
            //forwarding outputs
            .MEM_EX_r(MEM_EX_r),
            .MEM_WB_r(MEM_WB_r),
            .MEM_EX_alu_result(MEM_EX_alu_result),
            .MEM_EX_register_write(MEM_EX_register_write)
            );
            
//************************WB stage************************************************
MEM_WB_MUX TOP_WB(
                   .MEM_WB_memory_to_register(MEM_WB_memory_to_register),
                   .MEM_WB_read_data(MEM_WB_read_data),
                   .MEM_WB_alu_result(MEM_WB_alu_result),
                   
                   .MEM_WB_register_write_data(MEM_WB_register_write_data)
                   );

endmodule