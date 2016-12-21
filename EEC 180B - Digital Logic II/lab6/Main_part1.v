module Main_part1(KEY, LEDR, LEDG, mult,SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 );

//inputs
input [17:0]SW; 	

						// Address in = sw[17:14]
						//Data in KEY= sw[1:0] 00, 01, 10, 11 (unsigned 8x8 for 00)
input [1:0] KEY;	 	// KEY[0] = Clock,

//outputs
output [17:0]LEDR;
output [0:6]HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
output [1:0] LEDG;
output [31:0]mult;      // dummy variable place holder--holds the "answer" and dumps it in the hex to display
reg [31:0]mult;

wire [31:0] a_full;
wire [31:0] b_full;

assign LEDR = SW;
assign LEDG = KEY;

assign CLK = KEY[0];
assign LEDG[0] = CLK;
assign select = SW[16];
assign LEDR[16] = select;

wire [1:0] key_input;	// user picks either 8x8 unsigned multiplier; 8x8 signed; or 16x16 signed
assign  key_input = LEDR[1:0];

wire [31:0]mult1; // dummy place holder variables
wire [31:0]mult2;
wire [31:0]mult3;



// ------------- Design implementation --------


ram0 U199 (.address(LEDR[17:14]),  .clk(CLK), .select(key_input), .data_out1(a_full), .data_out2(b_full) ); // instantiates RAM (16 "words" aka variables 64bit wide each

array8x8 U2 (.a(a_full[7:0]), .b(b_full[7:0]), .fp(mult1));	   												// unsigned multiplier
R4Mult8by8 U3(.a(a_full[7:0]),.b(b_full[7:0]), .s(mult2)); 													// signed multiplier
wall16 U200(.a(a_full[15:0]),.b(b_full[15:0]),.fp(mult3));


hex_7seg h7 (.r(mult[31:28]), .seg(HEX7));  // 
hex_7seg h6 (.r(mult[27:24]), .seg(HEX6));   // 
hex_7seg h5 (.r(mult[23:20]), .seg(HEX5)); 	 // 
hex_7seg h4 (.r(mult[19:16]), .seg(HEX4));   // 

hex_7seg h0 (.r(mult[3:0]), .seg(HEX0));	
hex_7seg h1 (.r(mult[7:4]), .seg(HEX1));
hex_7seg h2 (.r(mult[11:8]), .seg(HEX2));	
hex_7seg h3 (.r(mult[15:12]), .seg(HEX3));

 										
always @ (key_input) begin
if (key_input === 2'b00)			begin
	 mult = mult1;
	     						end
else if (key_input === 2'b01)	 		begin
	 mult = mult2;
	  								end     
else if (key_input === 2'b10)	 		begin
	 mult =  32'b11111111_11111111;
	  								end    	  								
else  begin 
	 mult = mult3;
	 //mult =  32'b11111111_11111111_11111111;
	  end
  end
  
endmodule

//////////////////////////////////////////////////////
// Ram Module0
// 16X64 Random Access Memory
// ///////////////////////////////////////////////////
module ram0
            (
               // Inputs
               address,
               select,
               clk,
               // Outputs
               data_out1,
               data_out2
            );
    // Port definitions
    input   [3:0]       address;
    input	[1:0]		select;
    input				clk;
    
    output  [31:0]   	data_out1;
    output  [31:0]   	data_out2;
    
    reg     [31:0]		data_out1;
    reg     [31:0]		data_out2;
	reg     [31:0]		memory[15:0];
	
    
// ------------- Design implementation --------


initial begin

memory[4'b0000] = 32'b00000000000000000000000000000001; // positive 1

memory[4'b0001] = 32'b00000000000000000000000000010110; // positive 22

memory[4'b0010] = 32'b1111_1111_1111_1111_1111_1111_1111_0111; //'neg9

memory[4'b0011] = 32'b1111_1111_1111_1111_1111_1111_1111_0110; //'neg10

memory[4'b0100] = 32'b00000000000000000000000000001001; // positive 9

memory[4'b0101] = 32'b00000000000000000000000000011000; // positive 24

memory[4'b0110] = 32'b00000000000000000000000000011111; // positive 31

end
	
	always @(posedge clk )
		begin
  		  if ( (select === 2'b00) |(select === 2'b01) |(select === 2'b11) )	begin
    		data_out1 <= memory[address];
    		data_out2 <= memory[address + 1];					end
		 
		end
		
endmodule



//////////////////////////////////////////////////////
// Hex Display Module
// 
// ///////////////////////////////////////////////////
module hex_7seg(r, seg);
    input [3:0]r;
    output [0:6]seg;
	
    assign seg[0] = (~r[3] & ~r[2] & ~r[1] & r[0]) |
		     (~r[3] & r[2] & ~r[1] & ~r[0]) |
		     (r[3] & ~r[2] & r[1] & r[0]) |
		     (r[3] & r[2] & ~r[1] & r[0]);
	
	 assign seg[1] = (~r[3] & r[2] & ~r[1] & r[0]) |
		     (~r[3] & r[2] & r[1] & ~r[0]) |
		     (r[3] & ~r[2] & r[1] & r[0]) |
		     (r[3] & r[2] & ~r[1] & ~r[0]) | 
			  (r[3] & r[2] & r[1] & ~r[0]) |
			  (r[3] & r[2] & r[1] & r[0]);
			  
    assign seg[2] = (~r[3] & ~r[2] & r[1] & ~r[0]) |
		     (r[3] & r[2] & ~r[1] & ~r[0]) |
		     (r[3] & r[2] & r[1] & ~r[0]) |
		     (r[3] & r[2] & r[1] & r[0]);
	
    assign seg[3] = (~r[3] & ~r[2] & ~r[1] & r[0]) |
		     (~r[3] & r[2] & ~r[1] & ~r[0]) |
		     (~r[3] & r[2] & r[1] & r[0]) |
		     (r[3] & ~r[2] & ~r[1] & r[0]) | 
			  (r[3] & ~r[2] & r[1] & ~r[0]) |
			  (r[3] & r[2] & r[1] & r[0]);	
			  
	 assign seg[4] = (~r[3] & ~r[2] & ~r[1] & r[0]) |
		     (~r[3] & ~r[2] & r[1] & r[0]) |
		     (~r[3] & r[2] & ~r[1] & ~r[0]) |
		     (~r[3] & r[2] & ~r[1] & r[0]) | 
			  (~r[3] & r[2] & r[1] & r[0]) |
			  (r[3] & ~r[2] & ~r[1] & r[0]);
			  
	 assign seg[5] = (~r[3] & ~r[2] & ~r[1] & r[0]) |
		     (~r[3] & ~r[2] & r[1] & ~r[0]) |
		     (~r[3] & ~r[2] & r[1] & r[0]) |
		     (~r[3] & r[2] & r[1] & r[0]) | 
			  (r[3] & r[2] & ~r[1] & r[0]);
			  
			  
    assign seg[6] = (~r[3] & ~r[2] & ~r[1] & ~r[0]) |
		     (~r[3] & ~r[2] & ~r[1] & r[0]) |
		     (~r[3] & r[2] & r[1] & r[0]) |
		     (r[3] & r[2] & ~r[1] & ~r[0]);		  
			  
    
  
	endmodule








