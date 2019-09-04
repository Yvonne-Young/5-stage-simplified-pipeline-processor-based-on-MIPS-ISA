module Data_mem(clk,rst_n,
                EX_MEM_memory_read,    
                EX_MEM_memory_write,   
                EX_MEM_memory_address, 
                EX_MEM_memory_write_data,   
                 
                DM_MEM_read_data);   
 
input clk,rst_n;
wire  clk,rst_n;

/****************************input signals****************************/
input EX_MEM_memory_read;   //control signal of reading data from memory//
wire  EX_MEM_memory_read;

input EX_MEM_memory_write; //control signal of reading data from memory//
wire  EX_MEM_memory_write;

input EX_MEM_memory_address;//data address in memory from  the EX stage//
wire  [31:0]EX_MEM_memory_address;   

input EX_MEM_memory_write_data;//data from EX to write into memory//
wire  [31:0]EX_MEM_memory_write_data;           

output DM_MEM_read_data;     //data read from memory   
wire  [31:0] DM_MEM_read_data;

reg [31:0] memory[0:127];     //data memory
reg [31:0] DM_MEM_read_data_reg;//read data

//output, read memory
/*
always @(posedge EX_MEM_memory_read)
begin
if(EX_MEM_memory_read&&(!EX_MEM_memory_write))
  DM_MEM_read_data_reg<=memory[EX_MEM_memory_address];
else
  DM_MEM_read_data_reg<=32'b0;
end
*/

//input, write memory
//assign memory[EX_MEM_memory_address]=EX_MEM_memory_write?EX_MEM_memory_write_data:32'b0;
//wire [31:0]EX_MEM_memory_address_final;
//assign EX_MEM_memory_address_final={EX_MEM_memory_address[29:0],2'b0};

always @(posedge EX_MEM_memory_write or negedge rst_n)
//always@(posedge clk or negedge rst_n)
begin
if(!rst_n)	begin
	memory[0]<=32'b0;
	memory[1]<=32'b0;
	memory[2]<=32'b0;
	memory[3]<=32'b0;
	memory[4]<=32'b01100;
	memory[5]<=32'b0;
	memory[6]<=32'b0;
	memory[7]<=32'b0;
	memory[8]<=32'b0;
	memory[9]<=32'b0;
	memory[10]<=32'b0;
	memory[11]<=32'b0;
	memory[12]<=32'b0;
	memory[13]<=32'b0;
	memory[14]<=32'b0;
	memory[15]<=32'b0;
	memory[16]<=32'b0;
	memory[17]<=32'b0;
	memory[18]<=32'b0;
	memory[19]<=32'b0;
	memory[20]<=32'b0;
	memory[21]<=32'b0;
	memory[22]<=32'b0;
	memory[23]<=32'b0;
	memory[24]<=32'b0;
	memory[25]<=32'b0;
	memory[26]<=32'b0;
	memory[27]<=32'b0;
	memory[28]<=32'b0;
	memory[29]<=32'b0;
	memory[30]<=32'b0;
	memory[31]<=32'b0;
	memory[32]<=32'b0;
	memory[33]<=32'b0;
	memory[34]<=32'b0;
	memory[35]<=32'b0;
	memory[36]<=32'b0;
	memory[37]<=32'b0;
	memory[38]<=32'b0;
	memory[39]<=32'b0;
	memory[40]<=32'b0;
	memory[41]<=32'b0;
	memory[42]<=32'b0;
	memory[43]<=32'b0;
	memory[44]<=32'b0;
	memory[45]<=32'b0;
	memory[46]<=32'b0;
	memory[47]<=32'b0;
	memory[48]<=32'b0;
	memory[49]<=32'b0;
	memory[50]<=32'b0;
	memory[51]<=32'b0;
	memory[52]<=32'b0;
	memory[53]<=32'b0;
	memory[54]<=32'b0;
	memory[55]<=32'b0;
	memory[56]<=32'b0;
	memory[57]<=32'b0;
	memory[58]<=32'b0;
	memory[59]<=32'b0;
	memory[60]<=32'b0;
	memory[61]<=32'b0;
	memory[62]<=32'b0;
	memory[63]<=32'b0;
	memory[64]<=32'b0;
	memory[65]<=32'b0;
	memory[66]<=32'b0;
	memory[67]<=32'b0;
	memory[68]<=32'b0;
	memory[69]<=32'b0;
	memory[70]<=32'b0;
	memory[71]<=32'b0;
	memory[72]<=32'b0;
	memory[73]<=32'b0;
	memory[74]<=32'b0;
	memory[75]<=32'b0;
	memory[76]<=32'b0;
	memory[77]<=32'b0;
	memory[78]<=32'b0;
	memory[79]<=32'b0;
	memory[80]<=32'b0;
	memory[81]<=32'b0;
	memory[82]<=32'b0;
	memory[83]<=32'b0;
	memory[84]<=32'b0;
	memory[85]<=32'b0;
	memory[86]<=32'b0;
	memory[87]<=32'b0;
	memory[88]<=32'b0;
	memory[89]<=32'b0;
	memory[90]<=32'b0;
	memory[91]<=32'b0;
	memory[92]<=32'b0;
	memory[93]<=32'b0;
	memory[94]<=32'b0;
	memory[95]<=32'b0;
	memory[96]<=32'b0;
	memory[97]<=32'b0;
	memory[98]<=32'b0;
	memory[99]<=32'b0;
	memory[100]<=32'b0;
	memory[101]<=32'b0;
	memory[102]<=32'b0;
	memory[103]<=32'b0;
	memory[104]<=32'b0;
	memory[105]<=32'b0;
	memory[106]<=32'b0;
	memory[107]<=32'b0;
	memory[108]<=32'b0;
	memory[109]<=32'b0;
	memory[110]<=32'b0;
	memory[111]<=32'b0;
	memory[112]<=32'b0;
	memory[113]<=32'b0;
	memory[114]<=32'b0;
	memory[115]<=32'b0;
	memory[116]<=32'b0;
	memory[117]<=32'b0;
	memory[118]<=32'b0;
	memory[119]<=32'b0;
	memory[120]<=32'b0;
	memory[121]<=32'b0;
	memory[122]<=32'b0;
	memory[123]<=32'b0;
	memory[124]<=32'b0;
	memory[125]<=32'b0;
	memory[126]<=32'b0;
	memory[127]<=32'b0;
end

if(EX_MEM_memory_write&&(!EX_MEM_memory_read))begin
    //memory[EX_MEM_memory_address]<=EX_MEM_memory_write_data[31:24];
    //memory[EX_MEM_memory_address+1]<=EX_MEM_memory_write_data[23:16];
    //memory[EX_MEM_memory_address+2]<=EX_MEM_memory_write_data[15:8];
    //memory[EX_MEM_memory_address+3]<=EX_MEM_memory_write_data[7:0];
   memory[EX_MEM_memory_address]<=EX_MEM_memory_write_data;
    
    
  end
else begin
    //memory[EX_MEM_memory_address]<=8'b0;
    //memory[EX_MEM_memory_address+1]<=8'b0;
    //memory[EX_MEM_memory_address+2]<=8'b0;
    //memory[EX_MEM_memory_address+3]<=8'b0;
  memory[EX_MEM_memory_address]<=32'b0;
  end
end



//output
//assign DM_MEM_read_data=DM_MEM_read_data_reg;
//wire [31:0]EX_MEM_memory_address_final;
//assign EX_MEM_memory_address_final={EX_MEM_memory_address[29:0],2'b0};
//assign DM_MEM_read_data[31:0]=(EX_MEM_memory_read==1)?{memory[EX_MEM_memory_address],
                                                 //memory[EX_MEM_memory_address+1],
                                                 //memory[EX_MEM_memory_address+2],
                                                // memory[EX_MEM_memory_address+3]}:32'b0;
assign DM_MEM_read_data[31:0]=(EX_MEM_memory_read==1)?memory[EX_MEM_memory_address]:32'b0;

endmodule