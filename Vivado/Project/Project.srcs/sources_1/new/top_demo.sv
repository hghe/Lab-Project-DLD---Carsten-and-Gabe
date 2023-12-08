`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2021 06:40:11 PM
// Design Name: 
// Module Name: top_demo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_demo
(
  // input
  input  logic [7:0] sw,
  input  logic [3:0] btn,
  input  logic       sysclk_125mhz,
  input  logic       rst,
  
  // output  
  output logic [7:0] led,
  output logic       sseg_ca,
  output logic       sseg_cb,
  output logic       sseg_cc,
  output logic       sseg_cd,
  output logic       sseg_ce,
  output logic       sseg_cf,
  output logic       sseg_cg,
  output logic       sseg_dp,
  output logic [3:0] sseg_an,
  output logic [2:0] hdmi_d_p,  
  output logic [2:0] hdmi_d_n,   
  output logic       hdmi_clk_p,   
  output logic	     hdmi_clk_n,
   
  inout logic	     hdmi_cec,  
  inout logic	     hdmi_sda,   
  inout logic	     hdmi_scl,   
  input logic	     hdmi_hpd
);

  logic [16:0] CURRENT_COUNT;
  logic [16:0] NEXT_COUNT;
  logic        smol_clk;
  logic game_clk;
  logic [255:0] n2;
  logic [255:0] seed ;
  logic reset, clear, start;
  
  clk_div c1(sysclk_125mhz, reset,  game_clk);
  
  
  assign clear = btn[0];
  assign reset = btn[1];
  assign start = btn[2];
  assign pause = sw[0];
  assign seed = 256'hFFFF_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
  
  logic [23:0] alive, dead;
  // Place Conway Game of Life instantiation here
  logic [15:0] w2_out;
  dpgen dp(seed, reset, clear, game_clk, start, pause, n2, led[3:0], w2_out, led[7]);
  // HDMI
  // logic hdmi_out_en;
  //assign hdmi_out_en = 1'b0;
  hdmi_top test (n2, sysclk_125mhz, hdmi_d_p, hdmi_d_n, hdmi_clk_p, 
		         hdmi_clk_n, hdmi_cec, hdmi_sda, hdmi_scl, hdmi_hpd, sw[7]);
  
  // 7-segment display
  segment_driver driver(
  .clk(smol_clk),
  .rst(btn[3]),
  .digit0(w2_out[3:0]),
  .digit1(w2_out[7:4]),
  .digit2(w2_out[11:8]),
  .digit3(w2_out[15:12]),
  .decimals({1'b0, btn[2:0]}),
  .segment_cathodes({sseg_dp, sseg_cg, sseg_cf, sseg_ce, sseg_cd, sseg_cc, sseg_cb, sseg_ca}),
  .digit_anodes(sseg_an)
  );

// Register logic storing clock counts
  always@(posedge sysclk_125mhz)
  begin
    if(btn[3])
      CURRENT_COUNT = 17'h00000;
    else
      CURRENT_COUNT = NEXT_COUNT;
  end
  
  // Increment logic
  assign NEXT_COUNT = CURRENT_COUNT == 17'd100000 ? 17'h00000 : CURRENT_COUNT + 1;

  // Creation of smaller clock signal from counters
  assign smol_clk = CURRENT_COUNT == 17'd100000 ? 1'b1 : 1'b0;

endmodule
