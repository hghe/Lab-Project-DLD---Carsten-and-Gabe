module dpgen(
    input logic [63:0] grid,
    input logic reset, clear, clk,
    output logic [63:0] 
);

logic [63:0] w1, w2;

flopenrc flop (clk, reset, clear, en, d, w1);
datapath dp(w1, w2);

endmodule