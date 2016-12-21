

module updown (SW, KEY, LEDR, LEDG);
parameter n=16;		// number of bits in updown counter
input [0:0] SW;		// Updown switch 1=up, 0=down
input [1:0] KEY;	// KEY[1] = Clock, KEY[0] = Reset_n
output [n-1:0] LEDR;	// Display binary count (active high) on Red LEDs
output [1:0] LEDG;	// Display Clock on LEDG[1], Reset_n on LEDG[0]
wire Clock, Reset_n, Updown;
reg [n-1:0] Count;

assign Clock = KEY[1];
assign Reset_n = KEY[0];
assign Updown = SW[0];
assign LEDR = Count;
assign LEDG[1:0] = {Clock, Reset_n};

always @(negedge Reset_n, posedge Clock)
	if (Reset_n == 0)		// active-low asynchronous reset
		Count <= 0;
	else if (Updown)		// if Reset_n != 0, Clock rising edge
		Count <= Count + 1;	// count up if Updown=1
	else
		Count <= Count - 1;	// count down in Updown=0
		
endmodule
		
