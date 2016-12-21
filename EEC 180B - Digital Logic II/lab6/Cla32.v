// 32-bit radix-4 carry look ahead
module Cla32 (a, b, ci, co);

  input[31:0] a, b;
  input ci;
  output [32:0] co;

  wire [31:0] p, g;
  wire [7:0] p4, g4;
  wire p16, g16, p32, g32;
  
  //input stage of PG cells
  assign p = a ^ b;
  assign g = a & b;
  
  // input PG stage
  PG4 pg10 (p[3:0], g[3:0], p4[0], g4[0]);
  PG4 pg11 (p[7:4], g[7:4], p4[1], g4[1]);
  PG4 pg12 (p[11:8], g[11:8], p4[2], g4[2]);
  PG4 pg13 (p[15:12], g[15:12], p4[3], g4[3]);
  PG4 pg14 (p[19:16], g[19:16], p4[4], g4[4]);
  PG4 pg15 (p[23:20], g[23:20], p4[5], g4[5]);
  PG4 pg16 (p[27:24], g[27:24], p4[6], g4[6]);
  PG4 pg17 (p[31:28], g[31:28], p4[7], g4[7]);
  
  // p and g cross the first 16-bit
  PG4 pg21 (p4[3:0], g4[3:0], p16, g16);
  // p and g cross the second 16-bit
  PG4 pg22 (p4[7:4], g4[7:4], p32, g32);

  // MSB and LSB of carry
  assign co[0] = ci;
  assign co[16] = g16 | ci & p16;
  assign co[32] = g32 | co[16] & p32;
  
  // first level of carry
  Carry4 c10(ci, p4[2:0], g4[2:0], {co[12], co[8], co[4]});
  Carry4 c11(co[16], p4[6:4], g4[6:4], {co[28], co[24], co[20]});
   
  // second level of carry
  Carry4 c20(ci, p[2:0], g[2:0], co[3:1]);
  Carry4 c21(co[4], p[6:4], g[6:4], co[7:5]);
  Carry4 c22(co[8], p[10:8], g[10:8], co[11:9]);
  Carry4 c23(co[12], p[14:12], g[14:12], co[15:13]);
  Carry4 c24(co[16], p[18:16], g[18:16], co[19:17]);
  Carry4 c25(co[20], p[22:20], g[22:20], co[23:21]);
  Carry4 c26(co[24], p[26:24], g[26:24], co[27:25]);
  Carry4 c27(co[28], p[30:28], g[30:28], co[31:29]);

endmodule