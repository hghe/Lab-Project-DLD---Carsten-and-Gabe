`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  [63:0]gin;
   logic reset;
   logic  [63:0]gout;
   logic clear;
   logic start;
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   dpgen dut (gin, reset, clear, clk, start, gout);   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("dpgen.out");
	// Tells when to finish simulation
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#5 $fdisplay(desc3, "%h", 
		      gout);
     end    
   
   initial 
     begin      
     #0   reset = 1'b1;
     #6  reset = 1'b0;
     #0    start = 1'b1;
    
     end

endmodule // FSM_tb

