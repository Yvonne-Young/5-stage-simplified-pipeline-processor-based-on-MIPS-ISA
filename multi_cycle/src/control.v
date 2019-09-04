//**********************************************************************************************************
//				author: Yifan Young							   *
//				date:   2017/1/4							   *
//				module: control								   *
//**********************************************************************************************************

`timescale 1ns/1ns
module control(
              instruction_31_26         //instruction[31:26], the only input of this module.
             ,alusrc                    //When this signal=0, alu will choose the data from the register as its 2nd source
                                        //when this signal=1, alu will choose the immediate as its 2nd source                           
             ,alu_operation             //Determines the behavior of alu
             ,memory_read               //When memory_read=1, memory can be read
             ,memory_write              //When memory_write=1, memory can be written
             ,branch                    //When branch=1, execute the branch
             ,memory_to_register        //When memroy_to_register=1, the data written to the register is from memory
             ,register_write            //When register_write=1, register can be write in WB stage
             );
             
input instruction_31_26;

output alusrc;
output alu_operation;
output memory_read;
output memory_write;
output branch;
output memory_to_register;
output register_write;

wire [5:0]instruction_31_26;

reg alusrc;
reg [1:0]alu_operation;
reg memory_read;
reg memory_write;
reg branch;
reg memory_to_register;
reg register_write;

always @(instruction_31_26[5:0])
if(instruction_31_26[5:0]==6'b000000)  //R-type instructions
begin
  alusrc=0;
  alu_operation[1:0]=2'b10;
  memory_read=0;
  memory_write=0;
  branch=0;
  memory_to_register=0;
  register_write=1;
end
else if(instruction_31_26[5:0]==6'b100011)//lw instruction
  begin
    alusrc=1;
    alu_operation[1:0]=2'b00;
    memory_read=1;
    memory_write=0;
    branch=0;
    memory_to_register=1;
    register_write=1;
  end
else if(instruction_31_26[5:0]==6'b101011)//sw instruction
  begin
    alusrc=1;
    alu_operation[1:0]=2'b00;
    memory_read=0;
    memory_write=1;
    branch=0;
    memory_to_register=0;
    register_write=0;
  end
else if(instruction_31_26[5:0]==6'b000100)//beq istruction
  begin
    alusrc=0;
    alu_operation[1:0]=2'b01;
    memory_read=0;
    memory_write=0;
    branch=1;
    memory_to_register=0;
    register_write=0;
  end
else if(instruction_31_26[5:0]==6'b000010)//jump instruction
  begin
    alusrc=0;
    alu_operation=2'b00;     //It maks no diffrence, because jump instruction can't write memory or register
    memory_read=0;
    memory_write=0;
    branch=0;
    memory_to_register=0;
    register_write=0;
end

else if(instruction_31_26[5:0]==6'b001000)//addi instruction
  begin
    alusrc=1;
    alu_operation=2'b11;
    memory_read=0;
    memory_write=0;
    branch=0;
    memory_to_register=0;
    register_write=1;
  end

else                                    //other instructions
  begin
    alusrc=0;
    alu_operation=2'b00;
    memory_read=0;
    memory_write=0;
    branch=0;
    memory_to_register=0;
    register_write=0;
  end
  
endmodule