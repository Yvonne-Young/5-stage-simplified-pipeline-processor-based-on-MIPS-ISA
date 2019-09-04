//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/4							   *
//				module: IF								   *
//**********************************************************************************************************

`timescale 1ns/1ns

module IF( clk                       //clock signal
          ,IF_rst_n                  //reset
          ,IF_flush                  //if pc_flush=1,the set the IF_ID_register 0
          ,pc_enable                 //if pc_enable=1, pc can change
          ,IF_enable                 //if IF_enable=1, the value of the IF_ID stage and the value of pc can change
          ,EX_IF_branch              //branch signal
          ,EX_IF_branch_target       //the branch target
          ,EX_IF_zero
          ,EX_IF_branch_target_predict //The predict target, to check whether the prediction is right
          ,EX_IF_pc
          ,ID_IF_jump_target         //jump target
          ,ID_IF_jump                //jump signal
          
          ,IF_ID_instruction         //The output instruction
          ,IF_ID_pc                  //The value of pc+4   
          ,IF_ID_branch_target_predict //The predict target
          ,IF_ID_predictor           //The predictor
          
          ,ID_IF_branch
          );
input clk;
input IF_rst_n;
input IF_flush;

input pc_enable;
input IF_enable;
input EX_IF_branch;
input EX_IF_branch_target;
input EX_IF_zero;
input EX_IF_branch_target_predict;
input EX_IF_pc;
input ID_IF_jump_target;
input ID_IF_jump;
input ID_IF_branch;

output IF_ID_instruction;
output IF_ID_pc;
output IF_ID_branch_target_predict;
output IF_ID_predictor;

wire clk;
wire IF_rst_n;
wire IF_flush;
wire pc_enable;
wire IF_enable;
wire EX_IF_branch;
wire [31:0]EX_IF_branch_target;
wire EX_IF_zero;
wire [31:0]EX_IF_branch_target_predict;
wire [31:0]EX_IF_pc;
wire [31:0]ID_IF_jump_target;
wire ID_IF_jump;
wire ID_IF_branch;

reg [31:0]IF_ID_instruction;
reg [31:0]IF_ID_pc;
reg [31:0]IF_ID_branch_target_predict;
reg [1:0]IF_ID_predictor;

reg [31:0]pc;

//predictor and branch_target_predict
reg [1:0]predictor;
reg [58:0]branch_target_predict[0:15];  //index[3:0]. valid + tag[57:32]+branch_target[31:0];
wire [25:0]tag;                    //tag of branch
wire [3:0]index;                    //index of branch
wire [31:0]formal_pc;

wire [25:0]tag_now;                 //The tag and index now
reg [3:0]index_now;

//index and tag
assign formal_pc=EX_IF_pc[31:0]-4;
assign tag=formal_pc[31:6];
assign index=formal_pc[5:2];
assign tag_now=pc[31:6];

//index_now 
always@(posedge clk or negedge IF_rst_n)
if(!IF_rst_n)
  index_now<=4'b0;
else
  index_now<=pc[5:2];

//test tag
reg [25:0]tag_test;
always@(tag)
tag_test=tag;
//test EX_IF_pc
reg [31:0]EX_IF_pc_test;
always@(EX_IF_pc)
EX_IF_pc_test=EX_IF_pc;

reg [31:0] address;
wire [31:0] instruction;
IM instruction_memory(
		.address(address),
		.instruction(instruction)
		);



//---------------------------predictor and branch_target_predict--------------------------------------
//predictor
always@(posedge clk or negedge IF_rst_n)
if(!IF_rst_n)
  predictor[1:0]<=2'b01;             
else begin
  if(EX_IF_branch==1 && EX_IF_zero==1)   //branch
    if(predictor[1:0]==2'b11)
      predictor[1:0]<=predictor[1:0];
    else
      predictor[1:0]<=predictor[1:0]+1;
  else if(EX_IF_branch==1 && EX_IF_zero==0)   //not branch
    if(predictor[1:0]==2'b00)
      predictor[1:0]<=predictor[1:0];
    else
      predictor[1:0]<=predictor[1:0]-1;
  else
    predictor[1:0]<=predictor[1:0];           //It is not a branch instruction. so predictor not change
end  
//branch_target_predict
always@(posedge clk or negedge IF_rst_n)
if(!IF_rst_n) begin                            
  branch_target_predict[0]<=59'b0;
  branch_target_predict[1]<=59'b0;
  branch_target_predict[2]<=59'b0;
  branch_target_predict[3]<=59'b0;
  branch_target_predict[4]<=59'b0;
  branch_target_predict[5]<=59'b0;
  branch_target_predict[6]<=59'b0;
  branch_target_predict[7]<=59'b0;
  branch_target_predict[8]<=59'b0;
  branch_target_predict[9]<=59'b0;
  branch_target_predict[10]<=59'b0;
  branch_target_predict[11]<=59'b0;
  branch_target_predict[12]<=59'b0;
  branch_target_predict[13]<=59'b0;
  branch_target_predict[14]<=59'b0;
  branch_target_predict[15]<=59'b0;
end
else if(EX_IF_branch && EX_IF_zero)                       //store the branch target
  branch_target_predict[index]<={1'b1,tag[25:0],EX_IF_branch_target[31:0]};    //set valid,tag and branch target
else begin
  branch_target_predict[0]<=branch_target_predict[0];
  branch_target_predict[1]<=branch_target_predict[1];
  branch_target_predict[2]<=branch_target_predict[2];
  branch_target_predict[3]<=branch_target_predict[3];
  branch_target_predict[4]<=branch_target_predict[4];
  branch_target_predict[5]<=branch_target_predict[5];
  branch_target_predict[6]<=branch_target_predict[6];
  branch_target_predict[7]<=branch_target_predict[7];
  branch_target_predict[8]<=branch_target_predict[8];
  branch_target_predict[9]<=branch_target_predict[9];
  branch_target_predict[10]<=branch_target_predict[10];
  branch_target_predict[11]<=branch_target_predict[11];
  branch_target_predict[12]<=branch_target_predict[12];
  branch_target_predict[13]<=branch_target_predict[13];
  branch_target_predict[14]<=branch_target_predict[14];
  branch_target_predict[15]<=branch_target_predict[15];
end

//IF_ID_predictor
always@(posedge clk or negedge IF_rst_n)
if(!IF_rst_n)
  IF_ID_predictor[1:0]<=2'b01;
else
  IF_ID_predictor[1:0]<=predictor[1:0];


//IF_ID_instruction and IF_ID_pc and  pc and IF_ID_branch_target_predict
wire [58:0]branch_target_predict_get;

assign branch_target_predict_get=branch_target_predict[index_now];

//IF_ID_branch_target_predict  
always@(posedge clk or negedge IF_rst_n)
if(!IF_rst_n)                          
  IF_ID_branch_target_predict[31:0]<={31'b0,1'b1};
else if(ID_IF_branch)
  IF_ID_branch_target_predict[31:0]<=branch_target_predict_get[31:0];
else
  IF_ID_branch_target_predict[31:0]<={31'b0,1'b1};

//The IF_ID_instruction and IF_ID_pc
always@(posedge clk or negedge IF_rst_n)
if(!IF_rst_n) begin   
  pc<=32'b0;
  IF_ID_instruction[31:0]<=32'b0;
  IF_ID_pc[31:0]<=32'b0;
end

else if(IF_flush) begin //flush
  pc[31:0]<=pc[31:0]+4;
  IF_ID_instruction[31:0]<=32'b0;
  IF_ID_pc<=32'b0;
end

else if(!IF_enable) begin  //not enable
  pc[31:0]<=pc[31:0];
  IF_ID_instruction[31:0]<=IF_ID_instruction[31:0];
  IF_ID_pc[31:0]<=IF_ID_pc[31:0];
end

else if(EX_IF_branch && EX_IF_zero) begin //branch
  if(EX_IF_branch_target_predict!=EX_IF_branch_target) begin    //The prediction is wrong
    pc<=EX_IF_branch_target+4;
    IF_ID_instruction<=instruction;
    IF_ID_pc[31:0]<=EX_IF_branch_target+4;
  end
  else begin                                                   //The prediction is right
  pc<=pc+4;
  IF_ID_instruction<=instruction;
  IF_ID_pc<=pc+4;
  end
end

else if(ID_IF_jump) begin //jump
  pc<=ID_IF_jump_target+4;
  IF_ID_instruction<=instruction;
  IF_ID_pc[31:0]<=ID_IF_jump_target[31:0]+4;
end

else if(ID_IF_branch==1 
      &&predictor[1]==1  
      &&branch_target_predict_get[58]==1          //valid
      &&branch_target_predict_get[57:32]==tag_now //tag equals
      ) 
  begin
  IF_ID_instruction<=instruction;
  pc<=instruction_memory.Imemory[branch_target_predict_get[31:0]]+4;
  IF_ID_pc<=instruction_memory.Imemory[branch_target_predict_get[31:0]]+4;
end
                           
  

else begin  //normal
  pc<=pc+4;
  IF_ID_instruction<=instruction;
  IF_ID_pc<=pc+4;
end

always@(*) begin
if(EX_IF_branch && EX_IF_zero)	begin
	if(EX_IF_branch_target_predict!=EX_IF_branch_target)
		address=EX_IF_branch_target;
	else
		address=pc;
end
else if(ID_IF_jump)
	address=ID_IF_jump_target[4:0];
else if(ID_IF_branch==1 
      &&predictor[1]==1  
      &&branch_target_predict_get[58]==1          //valid
      &&branch_target_predict_get[57:32]==tag_now //tag equals
	)
	address=branch_target_predict_get;
else
	address=pc;
end

////////////////////////////////////////////////////////////////////////
reg [25:0]b;
reg [25:0]t;
reg [3:0]ind;
always @(branch_target_predict_get or tag_now or index_now)
begin
  b=branch_target_predict_get[57:32];
  t=tag_now;
  ind=index_now;
end

reg a,b1,c,d;
always @(ID_IF_branch==1 or predictor[1]==1 or branch_target_predict_get[58]==1 or branch_target_predict_get[57:32]==tag_now)
begin
a=(ID_IF_branch==1 );
b1=(predictor[1]==1)  ;
c=(branch_target_predict_get[58]==1);          //valid
d=(branch_target_predict_get[57:32]==tag_now); //tag equals
end
////////////////////////////////////////////////////////////////////////
endmodule

