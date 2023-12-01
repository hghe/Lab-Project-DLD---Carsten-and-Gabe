/*
 
 Conway's Game of Life modeled in SVerilog
 
 */

module datapath ( grid, grid_evolve );

   output logic [63:0] 	grid_evolve;
   input logic [63:0] 	grid;



    evolve3 e0_0 (grid_evolve[0],  grid[1], grid[17], grid [18], grid[0]);
    evolve5 e0_1 (grid_evolve[1], grid[0], grid[2], grid[16], grid[17], grid[18], grid[1]);
    evolve5 e0_2 (grid_evolve[2], grid[1], grid[3], grid[17], grid[18], grid[19], grid[2]);
    evolve5 e0_3 (grid_evolve[3], grid[2], grid[4], grid[18], grid[19], grid[20], grid[3]);
    evolve5 e0_4 (grid_evolve[4], grid[3], grid[5], grid[19], grid[20], grid[21], grid[4]);
    evolve5 e0_5 (grid_evolve[5], grid[4], grid[6], grid[20], grid[21], grid[22], grid[5]);
    evolve5 e0_6 (grid_evolve[6], grid[5], grid[7], grid[21], grid[22], grid[23], grid[6]);
    evolve5 e0_7 (grid_evolve[7], grid[6], grid[8], grid[22], grid[23], grid[24], grid[7]);
    evolve5 e0_8 (grid_evolve[8], grid[7], grid[9], grid[23], grid[24], grid[25], grid[8]);
    evolve5 e0_9 (grid_evolve[9], grid[8], grid[10], grid[24], grid[25], grid[26], grid[9]);
    evolve5 e0_10 (grid_evolve[10], grid[9], grid[11], grid[25], grid[26], grid[27], grid[10]);
    evolve5 e0_11 (grid_evolve[11], grid[10], grid[12], grid[26], grid[27], grid[28], grid[11]);
    evolve5 e0_12 (grid_evolve[12], grid[11], grid[13], grid[27], grid[28], grid[29], grid[12]);
    evolve5 e0_13 (grid_evolve[13], grid[12], grid[14], grid[28], grid[29], grid[30], grid[13]);
    evolve5 e0_14 (grid_evolve[14], grid[13], grid[15], grid[29], grid[30], grid[31], grid[14]);
    evolve3 e0_15 (grid_evolve[15], grid[14], grid[30], grid[31], grid[15]);


    evolve3 e15_0 (grid_evolve[240],  grid[224], grid[225], grid [241], grid[240]);
    evolve5 e15_1 (grid_evolve[241], grid[224], grid[225], grid[226], grid[240], grid[242], grid[241]);
    evolve5 e15_2 (grid_evolve[242], grid[225], grid[226], grid[227], grid[241], grid[243], grid[242]);
    evolve5 e15_3 (grid_evolve[243], grid[226], grid[227], grid[228], grid[242], grid[244], grid[243]);
    evolve5 e15_4 (grid_evolve[244], grid[227], grid[228], grid[229], grid[243], grid[245], grid[244]);
    evolve5 e15_5 (grid_evolve[245], grid[228], grid[229], grid[230], grid[244], grid[246], grid[245]);
    evolve5 e15_6 (grid_evolve[246], grid[229], grid[230], grid[231], grid[245], grid[247], grid[246]);
    evolve5 e15_7 (grid_evolve[247], grid[230], grid[231], grid[232], grid[246], grid[248], grid[247]);
    evolve5 e15_8 (grid_evolve[248], grid[231], grid[232], grid[233], grid[247], grid[249], grid[248]);
    evolve5 e15_9 (grid_evolve[249], grid[232], grid[233], grid[234], grid[248], grid[250], grid[249]);
    evolve5 e15_10 (grid_evolve[250], grid[233], grid[234], grid[235], grid[249], grid[251], grid[250]);
    evolve5 e15_11 (grid_evolve[251], grid[234], grid[235], grid[236], grid[250], grid[252], grid[251]);
    evolve5 e15_12 (grid_evolve[252], grid[235], grid[236], grid[237], grid[251], grid[253], grid[252]);
    evolve5 e15_13 (grid_evolve[253], grid[236], grid[237], grid[238], grid[252], grid[254], grid[253]);
    evolve5 e15_14 (grid_evolve[254], grid[237], grid[238], grid[239], grid[253], grid[255], grid[254]);
    evolve3 e15_15 (grid_evolve[255], grid[238], grid[239], grid[254], grid[255]);

    



    

 
endmodule // top


module evolve3 (next_state, vector1, vector2, vector3, current_state);
	
   input logic  vector1;
   input logic  vector2;
   input logic  vector3;
   input logic  current_state;
   output logic next_state;
   
   logic [3:0] 	sum;
   
   assign sum = vector1 + vector2 + vector3;
   rules r1 (sum, current_state, next_state);
   
endmodule // evolve3

module evolve5 (next_state, vector1, vector2, vector3, 
		vector4, vector5, current_state);
   
   input logic   vector1;
   input logic 	 vector2;
   input logic 	 vector3;
   input logic 	 vector4;
   input logic 	 vector5;
   input logic 	 current_state;
   output logic  next_state;
   
   logic [3:0] 	 sum;
   
   assign sum = vector1 + vector2 + vector3 + vector4 + vector5;
   rules r1 (sum, current_state, next_state);
   
endmodule // evolve5


module evolve8 (next_state, vector1, vector2, vector3, 
		vector4, vector5, vector6, 
		vector7, vector8, current_state);
   
   input logic 	vector1;
   input logic 	vector2;
   input logic 	vector3;
   input logic 	vector4;
   input logic 	vector5;
	
   input logic 	vector6;
   input logic 	vector7;
   input logic 	vector8;
   input logic 	current_state;
   output logic next_state;
   
   logic [3:0] 	sum;
   
   assign sum = vector1 + vector2 + vector3 + vector4 + 
		vector5 + vector6 + vector7 + vector8;
   rules r1 (sum, current_state, next_state);
   
endmodule // evolve8


module rules (pop_count, current_state, next_state);
   
   input logic [3:0] pop_count;
   input logic 	     current_state;
   output logic      next_state;
   
   assign next_state = (pop_count == 2 & current_state) | pop_count == 3;
   
endmodule // rules





