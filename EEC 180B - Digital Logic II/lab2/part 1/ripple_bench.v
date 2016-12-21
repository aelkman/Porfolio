module ripple_bench;
reg [8:0] a;
reg [8:0] b;
reg cin;
wire [7:0] sum;
wire cout;
ripplemod uut (.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout), .overflow(overflow) );
integer i,j;
initial begin

for (i = 0; i < 256; i = i + 1)
	for (j =0; j < 256; j = j+1)
	begin
	 #10;
	 a = i;
	 b = j;
	 if ({cout, sum} != (a[7:0] + b[7:0]) )
	 $display("ERROR: a=%b b=%b sum=%b cout=%b", a[7:0], b[7:0], sum[7:0], cout);
	 end
	 #10 $finish;
	 end	 
endmodule