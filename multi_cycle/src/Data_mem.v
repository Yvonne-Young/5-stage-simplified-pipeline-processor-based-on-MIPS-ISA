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

reg [7:0] memory[0:127];     //data memory
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
	memory[0]<=8'b0;
	memory[1]<=8'b0;
	memory[2]<=8'b0;
	memory[3]<=8'b0;
	memory[4]<=8'b0;
	memory[5]<=8'b0;
	memory[6]<=8'b0;
	memory[7]<=8'b0;
	memory[8]<=8'b0;
	memory[9]<=8'b0;
	memory[10]<=8'b0;
	memory[11]<=8'b0;
	memory[12]<=8'b0;
	memory[13]<=8'b0;
	memory[14]<=8'b0;
	memory[15]<=8'b0;
	memory[16]<=8'b0;
	memory[17]<=8'b0;
	memory[18]<=8'b0;
	memory[19]<=8'b0;
	memory[20]<=8'b0;
	memory[21]<=8'b0;
	memory[22]<=8'b0;
	memory[23]<=8'b0;
	memory[24]<=8'b0;
	memory[25]<=8'b0;
	memory[26]<=8'b0;
	memory[27]<=8'b0;
	memory[28]<=8'b0;
	memory[29]<=8'b0;
	memory[30]<=8'b0;
	memory[31]<=8'b0;
	memory[32]<=8'b0;
	memory[33]<=8'b0;
	memory[34]<=8'b0;
	memory[35]<=8'b0;
	memory[36]<=8'b0;
	memory[37]<=8'b0;
	memory[38]<=8'b0;
	memory[39]<=8'b0;
	memory[40]<=8'b0;
	memory[41]<=8'b0;
	memory[42]<=8'b0;
	memory[43]<=8'b0;
	memory[44]<=8'b0;
	memory[45]<=8'b0;
	memory[46]<=8'b0;
	memory[47]<=8'b0;
	memory[48]<=8'b0;
	memory[49]<=8'b0;
	memory[50]<=8'b0;
	memory[51]<=8'b0;
	memory[52]<=8'b0;
	memory[53]<=8'b0;
	memory[54]<=8'b0;
	memory[55]<=8'b0;
	memory[56]<=8'b0;
	memory[57]<=8'b0;
	memory[58]<=8'b0;
	memory[59]<=8'b0;
	memory[60]<=8'b0;
	memory[61]<=8'b0;
	memory[62]<=8'b0;
	memory[63]<=8'b0;
	memory[64]<=8'b0;
	memory[65]<=8'b0;
	memory[66]<=8'b0;
	memory[67]<=8'b0;
	memory[68]<=8'b0;
	memory[69]<=8'b0;
	memory[70]<=8'b0;
	memory[71]<=8'b0;
	memory[72]<=8'b0;
	memory[73]<=8'b0;
	memory[74]<=8'b0;
	memory[75]<=8'b0;
	memory[76]<=8'b0;
	memory[77]<=8'b0;
	memory[78]<=8'b0;
	memory[79]<=8'b0;
	memory[80]<=8'b0;
	memory[81]<=8'b0;
	memory[82]<=8'b0;
	memory[83]<=8'b0;
	memory[84]<=8'b0;
	memory[85]<=8'b0;
	memory[86]<=8'b0;
	memory[87]<=8'b0;
	memory[88]<=8'b0;
	memory[89]<=8'b0;
	memory[90]<=8'b0;
	memory[91]<=8'b0;
	memory[92]<=8'b0;
	memory[93]<=8'b0;
	memory[94]<=8'b0;
	memory[95]<=8'b0;
	memory[96]<=8'b0;
	memory[97]<=8'b0;
	memory[98]<=8'b0;
	memory[99]<=8'b0;
	memory[100]<=8'b0;
	memory[101]<=8'b0;
	memory[102]<=8'b0;
	memory[103]<=8'b0;
	memory[104]<=8'b0;
	memory[105]<=8'b0;
	memory[106]<=8'b0;
	memory[107]<=8'b0;
	memory[108]<=8'b0;
	memory[109]<=8'b0;
	memory[110]<=8'b0;
	memory[111]<=8'b0;
	memory[112]<=8'b0;
	memory[113]<=8'b0;
	memory[114]<=8'b0;
	memory[115]<=8'b0;
	memory[116]<=8'b0;
	memory[117]<=8'b0;
	memory[118]<=8'b0;
	memory[119]<=8'b0;
	memory[120]<=8'b0;
	memory[121]<=8'b0;
	memory[122]<=8'b0;
	memory[123]<=8'b0;
	memory[124]<=8'b0;
	memory[125]<=8'b0;
	memory[126]<=8'b0;
	memory[127]<=8'b0;
end
if(EX_MEM_memory_write&&(!EX_MEM_memory_read))begin
    memory[EX_MEM_memory_address]<=EX_MEM_memory_write_data[31:24];
    memory[EX_MEM_memory_address+1]<=EX_MEM_memory_write_data[23:16];
    memory[EX_MEM_memory_address+2]<=EX_MEM_memory_write_data[15:8];
    memory[EX_MEM_memory_address+3]<=EX_MEM_memory_write_data[7:0];
   
    
    
  end
else begin
    memory[EX_MEM_memory_address]<=8'b0;
    memory[EX_MEM_memory_address+1]<=8'b0;
    memory[EX_MEM_memory_address+2]<=8'b0;
    memory[EX_MEM_memory_address+3]<=8'b0;
  end
end

//output
//assign DM_MEM_read_data=DM_MEM_read_data_reg;
//wire [31:0]EX_MEM_memory_address_final;
//assign EX_MEM_memory_address_final={EX_MEM_memory_address[29:0],2'b0};
assign DM_MEM_read_data[31:0]=(EX_MEM_memory_read==1)?{memory[EX_MEM_memory_address],
                                                 memory[EX_MEM_memory_address+1],
                                                 memory[EX_MEM_memory_address+2],
                                                 memory[EX_MEM_memory_address+3]}:32'b0;

endmodule