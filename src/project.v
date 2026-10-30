/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
  
  /* Gate first exercise
  gates u_logic(
    .a(ui_in[0]), .b(ui_in[1]),
    .y_and(uo_out[0]), .y_xor(uo_out[1])
  );
  */

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uo_out[7:3] =0;
  counter counter1(
    .clk(clk), .rst_n(rst_n), .count(uo_out[2:0])
    );
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule

module gates (
  input wire a, b,
  output wire y_and, y_xor
);
  assign y_and = a & b;
  assign y_xor = a ^ b;

endmodule

module counter (
  input wire clk, rst_n,
  output reg [2:0] count
);

always @(posedge clk) begin
  if (~rst_n) begin
    count <= 3'b000;
  end
  else begin
    count <= count+1;
  end  
end

endmodule
