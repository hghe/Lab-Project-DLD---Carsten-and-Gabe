module dpgen(input logic [63:0] gridin, input logic reset, enable, clear, clk, output logic [63:0] gridout
);

logic [63:0] w1, w2;

flopenrc flop (clk, reset, clear, en, w1, w2);
datapath dp(w2, gridout);

endmodule


module FSM (clk, reset, start, gridin, gridout, en)
input logic clk, reset, start;
input logic [63:0] gridin;
output logic [63:0] gridout;
output logic en;
logic clear;
assign clear = 0;

dpgen gen(gin, reset, en, clear, clk, gout);


typedef enum 	logic [1:0] {S0, S1, S2, S3} statetype;
   statetype state, nextstate;

  always_ff @(posedge clk, posedge reset)
     if (reset) state = S0;
     else       state = nextstate;
   
   // next state logic
   always_comb
     case (state)
       S0: begin
        en = start;
        if (start) nextstate = S1;
        else nextstate = S0;
       end
       S1: begin 
         	
	  if (start) nextstate = S1;
      else nexstate = S2;
       end
       S2: begin  

	  if (start) nextstate = S1;
      else nexstate = S2;
       end
       endcase



endmodule