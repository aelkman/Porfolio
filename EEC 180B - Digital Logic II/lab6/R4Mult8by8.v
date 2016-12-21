// 8-bit x 8-bits radix 4 Booth multiplier
module R4Mult8by8(a,b,s);
	input [7:0] a, b;
	output [15:0] s;
	
	wire [2:0] d3, d2, d1, d0;  // recoded digits
	
	// Recoders
	Recode4 r0({b[1:0],1'b0}, d0);
	Recode4 r1(b[3:1], d1);
	Recode4 r2(b[5:3], d2);
	Recode4 r3(b[7:5], d3);
	
	// Selectors - in equation form - sign extend on select 1 
	wire [8:0] pp0 = {9{d0[2]}} ^ (({9{d0[1]}} & {a, 1'b 0}) | ({9{d0[0]}} & {a[7],a}));
	wire [8:0] pp1 = {9{d1[2]}} ^ (({9{d1[1]}} & {a, 1'b 0}) | ({9{d1[0]}} & {a[7],a}));
	wire [8:0] pp2 = {9{d2[2]}} ^ (({9{d2[1]}} & {a, 1'b 0}) | ({9{d2[0]}} & {a[7],a}));
	wire [8:0] pp3 = {9{d3[2]}} ^ (({9{d3[1]}} & {a, 1'b 0}) | ({9{d3[0]}} & {a[7],a}));
	
	
	// Adders - behavioral - sign extend partial sums
	// first row of half adders
	wire [9:0] ps0 = {pp0[8], pp0} + d0[2];
	// second row of full adders
	wire [9:0] ps1 = {pp1[8], pp1} + {{3{ps0[9]}},ps0[8:2]} + d1[2];
	// third row of full adders
	wire [9:0] ps2 = {pp2[8], pp2} + {{3{ps1[9]}},ps1[8:2]} + d2[2];
	// forth row of full adders
	wire [9:0] ps3 = {pp3[8], pp3} + {{3{ps2[9]}},ps2[8:2]} + d3[2];
	
	// output 
	assign s = {ps3, ps2[1:0], ps1[1:0], ps0[1:0]};

endmodule
