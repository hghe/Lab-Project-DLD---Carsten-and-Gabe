module dpgen(
    input logic [63:0] gin, seed
    input logic reset, clear, clk, start,
    output logic [63:0] gout
);

logic en;
//logic [63:0] w1, w2;

flopenrc flop (clk, reset, clear, en, gout, gin);
datapath dp(w1, w2);

typedef enum 	logic [3:0] {S0, S1, S2, S3} statetype;
   statetype state, nextstate;

 always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;


always_comb
     case (state)
       S0: begin
	     gout = seed;
          en = 1;
          //once we hit posedge clock the flipflop will send the seed to the datapath then gin will be updated after ??? nanoseconds.
          if(start) 
               nextstate <= S1;
          else
               nextstate <= S0;
       end
       S1: begin
          gout = gin;
          en = 1;
          if(start)
               nextstate <= S1;
          else
               nextstate <= S2;
       end
       S2: begin
          en = 0;
          if(start)
               nextstate <= S1;
          else
               nextstate <= S2;
       end
     endcase
 

endmodule


module FSM(




) endmodule;