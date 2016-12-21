module fullAdd (co, sum, a, b, ci);
    input a, b, ci;
    output sum, co;
    

    assign sum = a ^ b ^ ci;
    assign co = a&b | a&ci | b&ci |0;
    
endmodule