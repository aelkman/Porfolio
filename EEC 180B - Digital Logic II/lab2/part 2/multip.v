module multip (a, b, P);
	input [7:0] a, b;
	wire [15:0] E;	output [15:0] P;
	wire [7:0] A, B;
	wire [7:0] D2,D3,D4,D5,D6,D7;
	wire [8:1] seg1,seg2,seg3,seg4,seg5,seg6,seg7,r1,r2,r3,r4,r5,r6,r7;

	assign x = 0;	assign y = 1;
	assign A = a; assign B = b;

	// row 1

	and A1(E[0],A[0],B[0]);
	and A2(E[1],A[1],B[0]);
	and A3(E[2],A[0],B[1]);
	fullAdd add1(r1[1],seg1[1],E[1],E[2],x);
	and A4(E[3],A[2],B[0]);
	and A5(E[4],A[1],B[1]);
	fullAdd add2(r1[2],seg1[2],E[3],E[4],r1[1]);
	and A6(E[5],A[3],B[0]);
	and A7(E[6],A[2],B[1]);
	fullAdd add3(r1[3],seg1[3],E[5],E[6],r1[2]);
	and A8(E[7],A[4],B[0]);
	and A9(E[8],A[3],B[1]);
	fullAdd add4(r1[4],seg1[4],E[7],E[8],r1[3]);
	and A10(E[9],A[5],B[0]);
	and A11(E[10],A[4],B[1]);
	fullAdd add5(r1[5],seg1[5],E[9],E[10],r1[4]);
	and A12(E[11],A[6],B[0]);
	and A13(E[12],A[5],B[1]);
	fullAdd add6(r1[6],seg1[6],E[11],E[12],r1[5]);
	and A14(E[13],A[7],B[0]);
	and A15(E[14],A[6],B[1]);
	fullAdd add7(r1[7],seg1[7],E[13],E[14],r1[6]);
	and A16(E[15],A[7],B[1]);
	fullAdd add8(r1[8],seg1[8],E[15],y,r1[7]);

	// row 2

	and A17(D2[0],A[0],B[2]);
	fullAdd add9(r2[1],seg2[1],D2[0],seg1[2],x);
	and A18(D2[1],A[1],B[2]);
	fullAdd add10(r2[2],seg2[2],D2[1],seg1[3],r2[1]);
	and A19(D2[2],A[2],B[2]);
	fullAdd add11(r2[3],seg2[3],D2[2],seg1[4],r2[2]);
	and A20(D2[3],A[3],B[2]);
	fullAdd add12(r2[4],seg2[4],D2[3],seg1[5],r2[3]);
	and A21(D2[4],A[4],B[2]);
	fullAdd add13(r2[5],seg2[5],D2[4],seg1[6],r2[4]);
	and A22(D2[5],A[5],B[2]);
	fullAdd add14(r2[6],seg2[6],D2[5],seg1[7],r2[5]);
	and A23(D2[6],A[6],B[2]);
	fullAdd add15(r2[7],seg2[7],D2[6],seg1[8],r2[6]);
	and A24(D2[7],A[7],B[2]);
	fullAdd add16(r2[8],seg2[8],D2[7],r1[8],r2[7]);

	// row 3

	and A25(D3[0],A[0],B[3]);
	fullAdd add17(r3[1],seg3[1],D3[0],seg2[2],x);
	and A26(D3[1],A[1],B[3]);
	fullAdd add18(r3[2],seg3[2],D3[1],seg2[3],r3[1]);
	and A27(D3[2],A[2],B[3]);
	fullAdd add19(r3[3],seg3[3],D3[2],seg2[4],r3[2]);
	and A28(D3[3],A[3],B[3]);
	fullAdd add20(r3[4],seg3[4],D3[3],seg2[5],r3[3]);
	and A29(D3[4],A[4],B[3]);
	fullAdd add21(r3[5],seg3[5],D3[4],seg2[6],r3[4]);
	and A30(D3[5],A[5],B[3]);
	fullAdd add22(r3[6],seg3[6],D3[5],seg2[7],r3[5]);
	and A31(D3[6],A[6],B[3]);
	fullAdd add23(r3[7],seg3[7],D3[6],seg2[8],r3[6]);
	and A32(D3[7],A[7],B[3]);
	fullAdd add24(r3[8],seg3[8],D3[7],r2[8],r3[7]);

	//row 4

	and A33(D4[0],A[0],B[4]);
	fullAdd add25(r4[1],seg4[1],D4[0],seg3[2],x);
	and A34(D4[1],A[1],B[4]);
	fullAdd add26(r4[2],seg4[2],D4[1],seg3[3],r4[1]);
	and A35(D4[2],A[2],B[4]);
	fullAdd add27(r4[3],seg4[3],D4[2],seg3[4],r4[2]);
	and A36(D4[3],A[3],B[4]);
	fullAdd add28(r4[4],seg4[4],D4[3],seg3[5],r4[3]);
	and A37(D4[4],A[4],B[4]);
	fullAdd add29(r4[5],seg4[5],D4[4],seg3[6],r4[4]);
	and A38(D4[5],A[5],B[4]);
	fullAdd add30(r4[6],seg4[6],D4[5],seg3[7],r4[5]);
	and A39(D4[6],A[6],B[4]);
	fullAdd add31(r4[7],seg4[7],D4[6],seg3[8],r4[6]);
	and A40(D4[7],A[7],B[4]);
	fullAdd add32(r4[8],seg4[8],D4[7],r3[8],r4[7]);

	// row 5

	and A41(D5[0],A[0],B[5]);
	fullAdd add33(r5[1],seg5[1],D5[0],seg4[2],x);
	and A42(D5[1],A[1],B[5]);
	fullAdd add34(r5[2],seg5[2],D5[1],seg4[3],r5[1]);
	and A43(D5[2],A[2],B[5]);
	fullAdd add35(r5[3],seg5[3],D5[2],seg4[4],r5[2]);
	and A44(D5[3],A[3] ,B[5]);
	fullAdd add36(r5[4],seg5[4],D5[3],seg4[5],r5[3]);
	and A45(D5[4],A[4],B[5]);
	fullAdd add37(r5[5],seg5[5],D5[4],seg4[6],r5[4]);
	and A46(D5[5],A[ 5],B[5]);
	fullAdd add38(r5[6],seg5[6],D5[5],seg4[7],r5[5]);
	and A47(D5[6],A[6],B[5]);
	fullAdd add39(r5[7],seg5[7],D5[6],seg4[8],r5[6]);
	and A48(D5[7],A[7],B[5]);
	fullAdd add40(r5[8],seg5[8],D5[7],r4[8],r5[7]);

	// row 6

	and A49(D6[0],A[0],B[6]);
	fullAdd add41(r6[1],seg6[1],D6[0],seg5[2],x);
	and A50(D6[1],A[1],B[6]);
	fullAdd add42(r6[2],seg6[2],D6[1],seg5[3],r6[1]);
	and A51(D6[2],A[2],B[6]);
	fullAdd add43(r6[3],seg6[3],D6[2],seg5[4],r6[2]);
	and A52(D6[3],A[3],B[6]);
	fullAdd add44(r6[4],seg6[4],D6[3],seg5[5],r6[3]);
	and A53(D6[4],A[4],B[6]);
	fullAdd add45(r6[5],seg6[5],D6[4],seg5[6],r6[4]);
	and A54(D6[5],A[5],B[6]);
	fullAdd add46(r6[6],seg6[6],D6[5],seg5[7],r6[5]);
	and A55(D6[6],A[6],B[6]);
	fullAdd add47(r6[7],seg6[7],D6[6],seg5[8],r6[6]);
	and A56(D6[7],A[7],B[6]);
	fullAdd add48(r6[8],seg6[8],D6[7],r5[8],r6[7]);

	// row 7

	and A57(D7[0],A[0],B[7]);
	fullAdd add49(r7[1],seg7[1],D7[0],seg6[2],x);
	and A58(D7[1],A[1],B[7]);
	fullAdd add50(r7[2],seg7[2],D7[1],seg6[3],r7[1]);
	and A59(D7[2],A[2],B[7]);
	fullAdd add51(r7[3],seg7[3],D7[2],seg6[4],r7[2]);
	and A60(D7[3],A[3],B[7]);
	fullAdd add52(r7[4],seg7[4],D7[3],seg6[5],r7[3]);
	and A61(D7[4],A[4],B[7]);
	fullAdd add53(r7[5],seg7[5],D7[4],seg6[6],r7[4]);
	and A62(D7[5],A[5],B[7]);
	fullAdd add54(r7[6],seg7[6],D7[5],seg6[7],r7[5]);
	and A63(D7[6],A[6],B[7]);
	fullAdd add55(r7[7],seg7[7],D7[6],seg6[8],r7[6]);
	and A64(D7[7],A[7],B[7]);
	fullAdd add56(r7[8],seg7[8],D7[7],r6[8],r7[7]);
	
	//final assignment for output
	
	assign P[0] = E[0];	assign P[1] = seg1[1];
	assign P[2] = seg2[1];	assign P[3] = seg3[1];
	assign P[4] = seg4[1];	assign P[5] = seg5[1];
	assign P[6] = seg6[1];	assign P[7] = seg7[1];
	assign P[8] = seg7[2];	assign P[9] = seg7[3];
	assign P[10] = seg7[4];	assign P[11] = seg7[5];
	assign P[12] = seg7[6];	assign P[13] = seg7[7];
	assign P[14] = seg7[8];	assign P[15] = r7[8];
		
endmodule