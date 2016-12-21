module Cla16 (a, b, ci, co);

  input[15:0] a, b;
  input ci;
  output [16:0] co;

  wire [15:0] p, g;
  wire [3:0] p4, g4;
  wire p16, g16;

  assign p = a ^ b;
  assign g = a & b;

  PG4 pg10 (p[3:0], g[3:0], p4[0], g4[0]);
  PG4 pg11 (p[7:4], g[7:4], p4[1], g4[1]);
  PG4 pg12 (p[11:8], g[11:8], p4[2], g4[2]);
  PG4 pg13 (p[15:12], g[15:12], p4[3], g4[3]);

  PG4 pg2 (p4, g4, p16, g16);

  assign co[16] = g16 | ci & p16;
  assign co[0] = ci;

  Carry4 c10(ci, p4[2:0], g4[2:0], {co[12], co[8], co[4]});
  
  Carry4 c20(ci, p[2:0], g[2:0], co[3:1]);
  Carry4 c21(co[4], p[6:4], g[6:4], co[7:5]);
  Carry4 c22(co[8], p[10:8], g[10:8], co[11:9]);
  Carry4 c23(co[12], p[14:12], g[14:12], co[15:13]);

endmodule