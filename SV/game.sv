module game(input logic clk, reset, 
            input logic [63:0] gin,
            output logic [63:0] gout);

logic [63:0] w1;

flopr fp (clk,reset, gin, w1);

   datapath dut (w1, gout); 

endmodule