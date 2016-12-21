
module tb_updown;

parameter n=16;		// number of bits in updown counter
wire [0:0] SW;		// Updown switch 1=up, 0=down
wire [1:0] KEY;		// KEY[1] = Clock, KEY[0] = Reset_n
wire [n-1:0] LEDR;	// Display binary count (active high) on Red LEDs
wire [1:0] LEDG;	// Display Clock on LEDG[1], Reset_n on LEDG[0]
reg Clock, Reset_n, Updown;

assign KEY[1:0] = {Clock, Reset_n};
assign SW[0] = Updown;

updown UUT (.SW(SW), .KEY(KEY), .LEDR(LEDR), .LEDG(LEDG));

initial			// Clock generator
 begin
   Clock = 0;
   forever #10 Clock = ~Clock;
 end

initial			// Test stimulus
 begin
   Reset_n = 0;		// reset counter
   #10 Reset_n = 1;
 end

endmodule
