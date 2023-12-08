

module dpgen(
    input logic [255:0] seed,
    input logic reset, clear, clk, 
    input logic start, pause,
    output logic [255:0] gout,
    output logic [3:0] next,
    output logic [15:0] w_out,
    output logic en
);

  logic [255:0] w1, w2;

  assign w1 = start? seed : w2;


  flopenrc flop (clk, reset, clear, en, w1, gout, w2);
  datapath dp(w2, gout);

  assign w_out = seed[239:224];

  typedef enum logic [3:0] { S0, S1 ,S2 ,S3} statetype;

  statetype state, nextstate;

  always_ff @(posedge clk, posedge reset)
    if (reset)
      state <= S0;
    else
      state <= nextstate;

  always_comb
    case (state)
      // reset state
      S0: begin
        en = 1'b0;
        if(start)
        nextstate <= S1;
        else 
        nextstate <= S0;
      end
      S1: begin
        en = 1'b1;
        if(pause) 
        nextstate <= S2;
        else 
        nextstate <= S1;
      end
     S2: begin
        en = 1'b0;
        if(pause) 
        nextstate <= S2;
        else 
        nextstate <= S1;
     end
     default: begin
      // Handle other cases if needed
      en = 1'b0; // Set a default value for 'en' if necessary
      nextstate = S0; // Set a default next state if necessary
    end
    endcase

endmodule
