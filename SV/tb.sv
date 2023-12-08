`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  [255:0]gin;
   logic reset;
   logic  [255:0]gout;
   logic clear;
   logic start;
   logic pause;
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   dpgen dut (.seed(gin), .reset(reset), .clear(clear), .clk(clk), .start(start), .pause(pause), .gout(gout));  
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

   always @(negedge clk)
     begin
	    $fdisplay(desc3, "%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n", 
		      gout[15:0], gout[31:16], gout[47:32], gout[63:48], gout[79:64], gout[95:80], gout[111:96], gout[127:112], gout[143:128], gout[159:144], gout[175:160], gout[191:176], gout[207:192], gout[223:208], gout[239:224], gout[255:240] );
     end    
   
   initial 
     begin      
     #0   reset = 1'b0;
     #0   start = 1'b0;
     #0   gin   = 256'h0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_FFFF_FFFF;
     #0   pause = 1'b0;
     //#0   gin = 256'h10d16780be47d13f2a47dbd048379d6963d31d7ab56b0c1d9763a49780b687e3751ec72170140510ceb6dae3a1d471225e51ee3bdf2a1f25d2f1e43a88069263b9f93aa1603f996dba79da46941be72ef351d0f8a05ec1e55b90791df9df77c19033797167a54978d1172b0ac21c65f039a52fefc156f8cee50fc9555f03df31;
     #0   clear = 1'b0;
              //256'h0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0015_e000_0000_0000;

     //#50  reset = 1'b1;

     #50  start = 1'b1;
     #50  pause = 1'b1;
  
     #0   start = 1'b0;

     #50  pause = 1'b0;
     
     #50  pause = 1'b1;
     
     
     /*Note: 
     - If reset and start both on, game is paused
     - If Reset off and Start on we iterate
     - about 30 sec delay on seed being loaded after switch turned on
     - reset needed to load seed it but should not be
     */
    
     end

endmodule // FSM_tb

