//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/4							   *
//				module: ID								   *
//**********************************************************************************************************

`timescale 1ns/1ns 
module ID(
          clk                        //clk signal
         ,ID_rst_n                   //reset. When ID_rest_n=0, ID_EX register is set 0
         ,ID_flush                   //if flush=1, the ID_EX_register is set 0
         ,ID_enable                  //enable. When ID_enable=1, ID_EX register can be written
         ,register_rst_n             //The reset signal of the register in this stage
         ,IF_ID_instruction          //The instruction from IF stage
         ,IF_ID_pc                   //The value of pc+4 which is pass form IF stage
         ,IF_ID_predictor
         ,IF_ID_branch_target_predict
         ,WB_ID_register_write       //From WB stage. When WB_ID_register_write=1, the registers can be written 
         ,WB_ID_write_register       //From the WB stage.It shows which register to write
         ,WB_ID_write_data           //From the WB stage.It is the data to write to the register
         
         ,EX_ID_rt
         ,EX_ID_memory_read
         
         //outputs
         ,IF_enable                  //To IF stage.Determines whetehr the IF_ID register can be written
         ,pc_enable                  //To IF stage.Determines whether the pc can be changed
         ,ID_IF_jump_target          //To IF stage.It is the target address of jump instructions
         ,ID_IF_jump                 //To IF stage.Determines wheher to jump. 1: jump, 0: noy jump
         ,ID_IF_branch               //To IF stage.If it is a branch instruction, return 1
         ,ID_EX_output_data_1        //The output data from the register
         ,ID_EX_output_data_2        //The output sata from the register
         ,ID_EX_rt                   //instruction[20:16]. It is the address of memory in a load instruction, or the address of register in a save instruction
         ,ID_EX_rd                   //instruction[15:11]. It is the address of register to save the result in a R-type instruction
         ,ID_EX_rs                   //instruction[21:25]. It is teh first operand of the R-type instruction
         ,ID_EX_immediate_extended   //Extened instruction[15:0]. It is a immediate, or an offset
         ,ID_EX_pc                   //The value of pc+4
         ,ID_EX_alusrc               //To control the ALU
         ,ID_EX_alu_operation        //To conrol the ALU
         ,ID_EX_memory_read          //Whether to read the memory. 1: read, 0: not read
         ,ID_EX_memory_write         //Whether to write the memory. 1: write, 0: not write
         ,ID_EX_branch               //Whether to execute the branch. 1: execute the branch, 0:not execute
         ,ID_EX_memory_to_register   //Choose the data to write to the register in WB stage. 1: from memory, 0: from alu 
         ,ID_EX_register_write       //Determines whether the registers can be written in WB stage. 1: can be written, 0: can not be written 
	 ,alu_operation
         
         ,ID_EX_predictor
         ,ID_EX_branch_target_predict
         );
         
         
input clk;
input ID_rst_n;
input ID_flush;
input ID_enable;
input register_rst_n;
input IF_ID_instruction;
input IF_ID_pc;
input IF_ID_predictor;
input IF_ID_branch_target_predict;
input WB_ID_register_write;
input WB_ID_write_register;
input WB_ID_write_data;

//input for hazard detection
input EX_ID_rt;
input EX_ID_memory_read;

//outputs 
output IF_enable;   
output pc_enable;
output ID_IF_jump_target;
output ID_IF_jump;
output ID_EX_output_data_1;
output ID_EX_output_data_2;
output ID_EX_rt;
output ID_EX_rd;
output ID_EX_rs;
output ID_EX_immediate_extended;
output ID_EX_pc;
output ID_EX_alusrc;
output ID_EX_alu_operation;
output ID_EX_memory_read;
output ID_EX_memory_write;
output ID_EX_branch;
output ID_EX_memory_to_register;
output ID_EX_register_write;
output ID_IF_branch;
output alu_operation;


output ID_EX_predictor;
output ID_EX_branch_target_predict;

wire clk;
wire ID_rst_n;
wire ID_flush;
wire ID_enable;
wire register_rst_n;
wire [31:0]IF_ID_instruction;
wire [31:0]IF_ID_pc;
wire [1:0]IF_ID_predictor;
wire [31:0]IF_ID_branch_target_predict;
wire WB_ID_register_write;
wire [4:0]WB_ID_write_register;//address of writing register
wire [31:0]WB_ID_write_data;    //data of writing register

wire [4:0]EX_ID_rt;
wire EX_ID_memory_read;

wire IF_enable;
reg [31:0]ID_IF_jump_target;
reg ID_IF_jump;

reg [31:0]ID_EX_output_data_1;
reg [31:0]ID_EX_output_data_2;
reg [4:0]ID_EX_rt;
reg [4:0]ID_EX_rd;
reg [4:0]ID_EX_rs;
reg [31:0]ID_EX_immediate_extended;
reg [31:0]ID_EX_pc;
reg ID_EX_alusrc;
reg [1:0]ID_EX_alu_operation;
reg ID_EX_memory_read;
reg ID_EX_memory_write;
reg ID_EX_branch;
reg ID_EX_memory_to_register;
reg ID_EX_register_write;
wire [1:0]alu_operation;


reg [1:0]ID_EX_predictor;
reg [31:0]ID_EX_branch_target_predict;

//**************************The modules and their interfaces***********************************
//The interface of control module
wire [5:0]instruction_31_26;
wire alusrc;
//wire [1:0]alu_operation;
wire memory_read;
wire memory_write;
wire branch;
wire memory_to_register;
wire register_write;

//The interface of register module
//clk, rst_n, register_write, write_data and write_register have already been defined
wire [4:0]read_register_1;          //rs
wire [4:0]read_register_2;          //rd
wire [31:0]output_data_1;             
wire [31:0]output_data_2;

//control module
assign instruction_31_26[5:0]=IF_ID_instruction[31:26];
control control_1(
                  .instruction_31_26(instruction_31_26)
                 ,.alusrc(alusrc)
                 ,.alu_operation(alu_operation)
                 ,.memory_read(memory_read)
                 ,.memory_write(memory_write)
                 ,.branch(branch)
                 ,.memory_to_register(memory_to_register)
                 ,.register_write(register_write)
                 );
                 
//register module
assign read_register_1[4:0]=IF_ID_instruction[25:21];
assign read_register_2[4:0]=IF_ID_instruction[20:16];
register register_1( 
                     .clk(clk)
                    ,.rst_n(register_rst_n)
                    ,.read_register_1(read_register_1)
                    ,.read_register_2(read_register_2)
                    ,.write_register(WB_ID_write_register)
                    ,.write_data(WB_ID_write_data)
                    ,.register_write(WB_ID_register_write)
                    ,.output_data_1(output_data_1)
                    ,.output_data_2(output_data_2)
                    );

//hazard detection module
Hazard_detection Hazard_detection_1(
                                    .IF_ID_instruction(IF_ID_instruction),
                                    .EX_ID_rt(EX_ID_rt),
                                    .EX_ID_memory_read(EX_ID_memory_read),
                                    
                                    .pc_enable(pc_enable),
                                    .IF_enable(IF_enable),
                                    .ID_enable(ID_enable)
                                    );
                                    
                                    
//**************************************************************************************************                    
                    
//************************************The outputs***************************************************
//ID_EX_predictor and ID_EX_branch_target_predict
always@(posedge clk or negedge ID_rst_n)
if(!ID_rst_n) begin
  ID_EX_predictor<=2'b00;
  ID_EX_branch_target_predict<=31'b0;
end
else begin
  ID_EX_predictor<=IF_ID_predictor;
  ID_EX_branch_target_predict<=IF_ID_branch_target_predict;
end
  
//ID_IF_branch
assign ID_IF_branch=(IF_ID_instruction[31:26]==6'b000100 || IF_ID_instruction[31:26]==6'b000101);  //beq or bne



//jump
always @(IF_ID_instruction[31:26])
if(IF_ID_instruction[31:26]==6'b000010)  //It is a jump instruction
  ID_IF_jump<=1;
else
  ID_IF_jump<=0;

//jump_target
always@(IF_ID_instruction[25:0])
  ID_IF_jump_target[31:0]<={IF_ID_pc[31:28],(IF_ID_instruction[27:0]<<2)}; //Extend the jump target address to a 32-bit binary number
                                                                           //Attention: it is 27:0, not 25:0

//The outputs from control module
always@(posedge clk or negedge ID_rst_n)
if(!ID_rst_n || ID_flush)   
  begin
    ID_EX_alusrc<=1'b0;
    ID_EX_alu_operation[1:0]<=2'b0;
    ID_EX_memory_read<=1'b0;
    ID_EX_memory_write<=1'b0;
    ID_EX_branch<=1'b0;
    ID_EX_memory_to_register<=1'b0;
    ID_EX_register_write<=1'b0;
  end
else if(!ID_enable)                                //ID_EX register can't be written
  begin
    ID_EX_alusrc<=1'b0;
    ID_EX_alu_operation[1:0]<=2'b0;
    ID_EX_memory_read<=1'b0;
    ID_EX_memory_write<=1'b0;
    ID_EX_branch<=1'b0;
    ID_EX_memory_to_register<=1'b0;
    ID_EX_register_write<=1'b0;
  end
else                                              //ID_EX_register can be written
  begin
    ID_EX_alusrc<=alusrc;
    ID_EX_alu_operation<=alu_operation;
    ID_EX_memory_read<=memory_read;
    ID_EX_memory_write<=memory_write;
    ID_EX_branch<=branch;
    ID_EX_memory_to_register<=memory_to_register;
    ID_EX_register_write<=register_write;
  end
  
//The outputs from register module
always@(posedge clk or negedge ID_rst_n)
if((!ID_rst_n) || ID_flush)                                        
  begin 
    ID_EX_output_data_1<=32'b0;
    ID_EX_output_data_2<=32'b0;
  end
else 
  begin
    ID_EX_output_data_1<=output_data_1;
    ID_EX_output_data_2<=output_data_2;
  end

//Other outputs
//ID_EX_rt
always@(posedge clk or negedge ID_rst_n)
if((!ID_rst_n) || ID_flush)                          //Reset the ID_EX register or flush
  ID_EX_rt<=5'b0;
else
  ID_EX_rt<=IF_ID_instruction[20:16];

//ID_EX_rd
always@(posedge clk or negedge ID_rst_n)
if((!ID_rst_n) || ID_flush)                                              //Reset the ID_EX register 
  ID_EX_rd<=5'b0;
else
  ID_EX_rd<=IF_ID_instruction[15:11];  

wire [31:0] immediate_extended;
signext ID_signext(
		.inst(IF_ID_instruction[15:0]),
		.data(immediate_extended)
		);
always@(posedge clk or negedge ID_rst_n)
if(!ID_rst_n || ID_flush)
  ID_EX_immediate_extended<=32'b0;
else
  ID_EX_immediate_extended<=immediate_extended;



//ID_EX_pc; 
always@(posedge clk or negedge ID_rst_n)
if((!ID_rst_n) || ID_flush)                            //Reset the ID_EX register`
  ID_EX_pc<=32'b0;                  
else
  ID_EX_pc<=IF_ID_pc;


//reg [4:0]ID_EX_rs_reg;
always @(posedge clk or negedge ID_rst_n)
if((!ID_rst_n) || ID_flush)begin
  ID_EX_rs<=5'b0;
end
else begin
  ID_EX_rs<=IF_ID_instruction[25:21];
end



//************************************************************************************************
    
  
endmodule