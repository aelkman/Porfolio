// test bench for ripple carry adder

`timescale 1 ns/1 ps

module tbpart2;
reg signed[15:0] a,b;
integer i,j;
  wire signed[31:0] s;

// design under test
wallace16 UUT(a,b,s);

// stimulus and verification that the ouput is correct
    initial begin  // Create all possible combinations of a and b
      for (i = -10; i < 10; i = i + 1)
			 begin
			 a=i; 
          #10;
               for (j= -10; j < 10 ; j = j+1)
				  begin
				      b = j;
                  //display all possible outputs
						#50;		
                  $display("a=%d b=%d sum=%d", a,b,s);
				  end	
          end
			 #10;
    end		 
endmodule




