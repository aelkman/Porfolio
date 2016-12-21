// Radix-4 recode block 
// Output is invert, select 2, select 1
module Recode4(b,d);
	input [2:0] b;
	output [2:0] d;
	reg [2:0] d;
	
	always @(*) begin
		case(b)
			0,7: d = 3'b000;     // no select, no invert
			1,2: d = 3'b001;     // select 1
			3:   d = 3'b010;     // select 2
			4:   d = 3'b110;     // select 2, invert
			5,6: d = 3'b101;     // select 1, invert
			default: d = 3'b000; //should never be selected
		endcase
	end
endmodule
