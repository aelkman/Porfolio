module	signdiv	(CLK,	St,	Dbus,	Quotient,	Remainder,	V,	Rdy, DivisorFull, state, Count, Dividenda, Divisora, a, comp2);
output reg [15:0] Quotient;
output reg [15:0] Remainder;
output reg [31:0] DivisorFull;
output [1:0]state;
input St;
output comp2 [1:0];
output [1:0]a;
output V;	//	asserted	when	there	is	an	overflow,	(Extra	Credit)
output [15:0] Divisora;
output [31:0] Dividenda;
//input [31:0] Dividend;
//input [15:0] Divisor;
input [15:0] Dbus;
input CLK;
output Rdy;
output [4:0] Count;

reg [2:0] a=0;
reg Rdy=0;
reg [1:0] comp2=0, comp2out;
reg[31:0] Dividenda;
reg [15:0] QuotientIn, Divisora;
reg [4:0] Count, CountIn;
reg [1:0] state=0, next;
reg [31:0] DividendIn;
reg done;

localparam load = 2'b01;
localparam divide = 2'b10;

always @(posedge CLK) begin
	
	if(state==0) begin
		Rdy = 0;
		if(a==0) begin
		a<=a+1;
		end
		if(a==1)
		a<=a+1;
		if(a==2) begin
		Dividenda[31:16] <= Dbus;
		a<=a+1;
		end
		if(a==3) begin
		Dividenda[15:0] <= Dbus;
		a<=a+1;
		end
		if(a==4) begin
		Divisora <= Dbus;
		state=1;
		end
	end
	else if(state==3) begin
		Rdy = 0;
		if(a==0) begin
		a<=a+1;
		end
		if(a==1) begin
		Dividenda[31:16] <= Dbus;
		a<=a+1;
		end
		if(a==2) begin
		Dividenda[15:0] <= Dbus;
		a<=a+1;
		end
		if(a==3) begin
		Divisora <= Dbus;
		state=1;
		end
	end
	else begin 
		state <= next;
		Dividenda <= DividendIn;
		Quotient <= QuotientIn;
		Count<= CountIn;
		comp2out <= comp2;
	end
	end
	
	
always @* begin	
		case(state)
		
			load: begin
				Rdy = 0;
				DivisorFull = 0;
				QuotientIn = 0;
				CountIn = 0;
				DividendIn = Dividenda;
				
				if(DividendIn[31]==0 && Divisora[15]==0) begin 
				comp2 = 0;
				end
				
				else if(DividendIn[31]==1 && Divisora[15]==1) begin 
				comp2 = 3;
				DividendIn = ~DividendIn + 1;
				Divisora = ~Divisora + 1;
				end
				
				else if(DividendIn[31]==1 && Divisora[15]==0) begin 
				comp2 = 2;
				DividendIn = ~DividendIn + 1;
				end
				
				else if(DividendIn[31]==0 && Divisora[15]==1) begin 
				comp2 = 1;
				Divisora = ~Divisora + 1;
				end
				
				DivisorFull[15:0] = Divisora;
				DivisorFull = DivisorFull << 15;
				
				next = divide;
			end
			
			divide: begin
				comp2 = comp2out;
				DividendIn = Dividenda;
				QuotientIn = Quotient;
				CountIn = Count;
				
				
				if(DivisorIn ==0) begin
				QuotientIn = 0;
				Remainder = 0;
				RdyIn = 1;
				$display ("Cannot divide by 0");
				next = 3;
				aIn=0;
				end
				
				if(CountIn == 16) begin
					if(comp2 == 1) begin
						Quotient = ~Quotient + 1;
						Remainder = DividendIn[31:16];
					end
					else if(comp2 == 2 ) begin 
						Quotient = ~Quotient + 1;
						Remainder = ~DividendIn[31:16]+1;
					end
					else if(comp2 == 3 ) begin 
						Remainder = ~DividendIn[31:16]+1;
					end
					else Remainder = DividendIn[31:16];
					Rdy = 1;
					state=3;
					a=0;
				end
				
				if((DividendIn - DivisorFull) <= DividendIn) begin
					DividendIn = DividendIn - DivisorFull;
					CountIn = CountIn + 1;
					QuotientIn [16-CountIn] = 1;
					next = divide;
					DividendIn = DividendIn << 1;
				end
				
				else begin
					DividendIn = DividendIn << 1;
					CountIn = CountIn + 1;
					next = divide;
				end
					
				
			end
			default: begin
			Rdy = 0;
			end
		endcase
				
	end			
				
			
					

endmodule
