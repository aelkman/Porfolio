// Full adder

module fullAdder(a,b,ci,s);
input a,b,ci; // inputs: a, b, cin
output s; // output: sum

assign s = a ^ b ^ ci;

endmodule