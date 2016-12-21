module Carry4(ci, p, g, co);

  input ci;
  input [2:0] p, g;
  output [2:0] co;

  wire [3:0] gg = {g, ci};
  assign co = (gg>>1) | (gg & p) | ((gg<<1) & p & (p<<1)) |
              ((gg<<2) & p & (p<<1) & (p<<2));

endmodule