module PG4 (pi, gi, po, go);
  input [3:0] pi, gi;
  output po, go;
  
  assign po = &pi;
  assign go = gi[3] | (gi[2] & pi[3]) | (gi[1] & (&pi[3:2])) |
              gi[0] & (&pi[3:1]);

endmodule