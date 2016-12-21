module multiply (SW, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input [15:0] SW;
	output [0:6] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	wire [7:0] a, b;
	wire [15:0] p;

	assign a = SW[15:8];
	assign b = SW[7:0];
	
	multip t1 (a, b, p);
	hex_7seg a7 (a[7:4], HEX7[0:6]);
	hex_7seg a6 (a[3:0], HEX6[0:6]);
	hex_7seg b5 (b[7:4], HEX5[0:6]);
	hex_7seg b4 (b[3:0], HEX4[0:6]);
	hex_7seg n3 (p[15:12], HEX3[0:6]);
	hex_7seg n2 (p[11:8], HEX2[0:6]);
	hex_7seg n1 (p[7:4], HEX1[0:6]);
	hex_7seg n0 (p[3:0], HEX0[0:6]);
	
endmodule
