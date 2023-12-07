`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  [255:0]gin;
   logic reset;
   logic  [255:0]gout;
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
  desc3 = handle3;
  $fdisplay(desc3, "%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n", 
		      gin[15:0], gin[31:16], gin[47:32], gin[63:48], gin[79:64], gin[95:80], gin[111:96], gin[127:112], gin[143:128], gin[159:144], gin[175:160], gin[191:176], gin[207:192], gin[223:208], gin[239:224], gin[255:240] );
	#500 $finish;		
     end

   always 
     begin
	
	  #5 $fdisplay(desc3, "%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n", 
		      gout[15:0], gout[31:16], gout[47:32], gout[63:48], gout[79:64], gout[95:80], gout[111:96], gout[127:112], gout[143:128], gout[159:144], gout[175:160], gout[191:176], gout[207:192], gout[223:208], gout[239:224], gout[255:240] );
     end    
   
   initial 
     begin      
     #0   reset = 1'b1;
     #0   gin = 256'hFFFF_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
              //256'h0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0015_e000_0000_0000;
     #20  reset = 1'b0;
     #0    start = 1'b1;
    
     end

endmodule // FSM_tb

