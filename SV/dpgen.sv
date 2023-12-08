module dpgen(
    input logic [255:0] seed,
    input logic reset, clear, clk, start,
    output logic [255:0] gout,
    output logic [3:0] next,
    output logic [15:0] w_out,
    output logic en
);

logic [255:0]  w2;

flopenrc flop (clk, reset, clear, en, seed, gout, w2);
datapath dp(w2, gout);


assign w_out = seed[239:224];

typedef enum 	logic [3:0] {S0, S1, S2, S3} statetype;
   statetype state, nextstate;

 always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;


always_comb
     case (state)
     // reset state
       S0: begin
          en = 1'b0;
          //once we hit posedge clock the flipflop will send the seed to the datapath then gin will be updated after ??? nanoseconds.
          if(reset) 
               nextstate <= S0;
          else
               nextstate <= S2;
       end
       S1: begin
          en = 1'b1;
          if(start)
               nextstate <= S1;
          else
               nextstate <= S2;
       end
       S2: begin
          en = 1'b0;
          if(start)
               nextstate <= S1;
          else
               nextstate <= S2;
       end
     endcase
 

endmodule
