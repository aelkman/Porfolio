`timescale 1ns / 1ps

module tBench;
    
  reg [7:0] a, b;
  wire [15:0] P;
  multip UUT (.a(a), .b(b), .P(P));
  integer i,j;

	initial begin
	for (i = 0; i < 256; i = i + 1)
		begin
		for (j =0; j < 256; j = j+1)
			begin
			a = i;
			b = j;
			#35;
			if (P != (a * b) )
				$display("ERROR: a=%b b=%b Euct=%b", a, b, P);
				end 
			#35;
	end
		
		
		
	end   
endmodule