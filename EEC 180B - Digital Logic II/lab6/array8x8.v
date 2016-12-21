module array8x8(a, b, fp);

//inputs
input [7:0]a,b;

//outputs
wire [15:0]p1;
wire [15:0]p2;
output [15:0]fp;

//wires
wire [63:0]w;
wire [65:0]s;
wire [50:0]c;
wire [16:0]co;

//andgate instantiations 
and a1(w[0],a[0],b[0]);
and a2(w[1],a[1],b[0]);
and a3(w[2],a[2],b[0]);
and a4(w[3],a[3],b[0]);
and a5(w[4],a[4],b[0]);
and a6(w[5],a[5],b[0]);
and a7(w[6],a[6],b[0]);
and a8(w[7],a[7],b[0]);

and a9(w[8],a[0],b[1]);
and a10(w[9],a[1],b[1]);
and a11(w[10],a[2],b[1]);
and a12(w[11],a[3],b[1]);
and a13(w[12],a[4],b[1]);
and a14(w[13],a[5],b[1]);
and a15(w[14],a[6],b[1]);
and a16(w[15],a[7],b[1]);

and a17(w[16],a[0],b[2]);
and a18(w[17],a[1],b[2]);
and a19(w[18],a[2],b[2]);
and a20(w[19],a[3],b[2]);
and a21(w[20],a[4],b[2]);
and a22(w[21],a[5],b[2]);
and a23(w[22],a[6],b[2]);
and a24(w[23],a[7],b[2]);

and a25(w[24],a[0],b[3]);
and a26(w[25],a[1],b[3]);
and a27(w[26],a[2],b[3]);
and a28(w[27],a[3],b[3]);
and a29(w[28],a[4],b[3]);
and a30(w[29],a[5],b[3]);
and a31(w[30],a[6],b[3]);
and a32(w[31],a[7],b[3]);

and a33(w[32],a[0],b[4]);
and a34(w[33],a[1],b[4]);
and a35(w[34],a[2],b[4]);
and a36(w[35],a[3],b[4]);
and a37(w[36],a[4],b[4]);
and a38(w[37],a[5],b[4]);
and a39(w[38],a[6],b[4]);
and a40(w[39],a[7],b[4]);


and a41(w[40],a[0],b[5]);
and a42(w[41],a[1],b[5]);
and a43(w[42],a[2],b[5]);
and a44(w[43],a[3],b[5]);
and a45(w[44],a[4],b[5]);
and a46(w[45],a[5],b[5]);
and a47(w[46],a[6],b[5]);
and a48(w[47],a[7],b[5]);

and a49(w[48],a[0],b[6]);
and a50(w[49],a[1],b[6]);
and a51(w[50],a[2],b[6]);
and a52(w[51],a[3],b[6]);
and a53(w[52],a[4],b[6]);
and a54(w[53],a[5],b[6]);
and a55(w[54],a[6],b[6]);
and a56(w[55],a[7],b[6]);

and a57(w[56],a[0],b[7]);
and a58(w[57],a[1],b[7]);
and a59(w[58],a[2],b[7]);
and a60(w[59],a[3],b[7]);
and a61(w[60],a[4],b[7]);
and a62(w[61],a[5],b[7]);
and a63(w[62],a[6],b[7]);
and a64(w[63],a[7],b[7]);


//full adders of the tree

Adder FA1(w[2],w[9],w[16],s[2],c[2]);
Adder FA2(w[3],w[10],w[17],s[3],c[3]);
Adder FA3(w[4],w[11],w[18],s[4],c[4]);
Adder FA4(w[5],w[12],w[19],s[5],c[5]);
Adder FA5(w[6],w[13],w[20],s[6],c[6]);
Adder FA6(w[7],w[14],w[21],s[7],c[7]);
Adder FA7(w[15],w[22],w[29],s[8],c[8]);
Adder FA8(w[23],w[30],w[37],s[9],c[9]);
Adder FA9(w[31],w[38],w[45],s[10],c[10]);
Adder FA10(w[39],w[46],w[53],s[11],c[11]);
Adder FA11(w[47],w[54],w[61],s[12],c[12]);

Adder FA12(w[25],w[32],1'b0,s[13],c[13]);
Adder FA13(w[26],w[33],w[40],s[14],c[14]);
Adder FA14(w[27],w[34],w[41],s[15],c[15]);
Adder FA15(w[28],w[35],w[42],s[16],c[16]);
Adder FA16(w[36],w[43],w[50],s[17],c[17]);
Adder FA17(w[44],w[51],w[58],s[18],c[18]);

Adder FA18(w[52],w[59],1'b0,s[19],c[19]);
Adder FA19(w[49],w[56],1'b0,s[20],c[20]);

//full adders stage 1

Adder FA20(s[3],c[2],w[24],s[21],c[21]);
Adder FA21(s[4],c[3],s[13],s[22],c[22]);
Adder FA22(s[5],c[4],s[14],s[23],c[23]);
Adder FA23(s[6],c[5],s[15],s[24],c[24]);
Adder FA24(s[7],c[6],s[16],s[25],c[25]);
Adder FA25(s[8],c[7],s[17],s[26],c[26]);
Adder FA26(s[9],c[8],s[18],s[27],c[27]);
Adder FA27(s[10],c[9],s[19],s[28],c[28]);
Adder FA28(s[11],c[10],w[60],s[29],c[29]);
Adder FA29(w[55],c[12],w[62],s[30],c[30]);

Adder FA30(c[14],w[48],1'b0,s[31],c[31]);
Adder FA31(c[15],s[20],1'b0,s[32],c[32]);
Adder FA32(c[16],w[57],c[20],s[33],c[33]);

//full adders stage 2

Adder FA33(s[23],c[22],c[13],s[34],c[34]);
Adder FA34(s[24],c[23],s[31],s[35],c[35]);
Adder FA35(s[25],c[24],s[32],s[36],c[36]);
Adder FA36(s[26],c[25],s[33],s[37],c[37]);
Adder FA37(s[27],c[26],c[17],s[38],c[38]);
Adder FA38(s[28],c[27],c[18],s[39],c[39]);
Adder FA39(s[29],c[28],c[19],s[40],c[40]);
Adder FA40(s[12],c[29],c[11],s[41],c[41]);

//full adders stage 3

Adder FA41(s[36],c[35],c[31],s[42],c[42]);
Adder FA42(s[37],c[36],c[32],s[43],c[43]);
Adder FA43(s[38],c[37],c[33],s[44],c[44]);
Adder FA44(s[39],c[38],1'b0,s[45],c[45]);
Adder FA45(s[40],c[39],1'b0,s[46],c[46]);
Adder FA46(s[41],c[40],1'b0,s[47],c[47]);
Adder FA47(s[30],c[41],1'b0,s[48],c[48]);
Adder FA48(w[63],c[30],1'b0,s[49],c[49]);

//output assignments p1
assign p1[0]=w[0];
assign p1[1]=w[1];
assign p1[2]=s[2];
assign p1[3]=s[21];
assign p1[4]=s[22];
assign p1[5]=s[34];
assign p1[6]=s[35];
assign p1[7]=s[42];
assign p1[8]=s[43];
assign p1[9]=s[44];
assign p1[10]=s[45];
assign p1[11]=s[46];
assign p1[12]=s[47];
assign p1[13]=s[48];
assign p1[14]=s[49];
assign p1[15]=1'b0;

//output assignments p2

assign p2[0]=1'b0;
assign p2[1]=w[8];
assign p2[2]=1'b0;
assign p2[3]=1'b0;
assign p2[4]=c[21];
assign p2[5]=1'b0;
assign p2[6]=c[34];
assign p2[7]=1'b0;
assign p2[8]=c[42];
assign p2[9]=c[43];
assign p2[10]=c[44];
assign p2[11]=c[45];
assign p2[12]=c[46];
assign p2[13]=c[47];
assign p2[14]=c[48];
assign p2[15]=c[49];

Cla16 Cla0(p1[15:0], p2[15:0], 1'b0, co[16:0]);

fullAdder FA49(p1[0],p2[0],co[0],s[50]);
fullAdder FA50(p1[1],p2[1],co[1],s[51]);
fullAdder FA51(p1[2],p2[2],co[2],s[52]);
fullAdder FA52(p1[3],p2[3],co[3],s[53]);
fullAdder FA53(p1[4],p2[4],co[4],s[54]);
fullAdder FA54(p1[5],p2[5],co[5],s[55]);
fullAdder FA55(p1[6],p2[6],co[6],s[56]);
fullAdder FA56(p1[7],p2[7],co[7],s[57]);
fullAdder FA57(p1[8],p2[8],co[8],s[58]);
fullAdder FA58(p1[9],p2[9],co[9],s[59]);
fullAdder FA59(p1[10],p2[10],co[10],s[60]);
fullAdder FA60(p1[11],p2[11],co[11],s[61]);
fullAdder FA61(p1[12],p2[12],co[12],s[62]);
fullAdder FA62(p1[13],p2[13],co[13],s[63]);
fullAdder FA63(p1[14],p2[14],co[14],s[64]);
fullAdder FA64(p1[15],p2[15],co[15],s[65]);

assign fp[0] = s[50];
assign fp[1] = s[51];
assign fp[2] = s[52];
assign fp[3] = s[53];
assign fp[4] = s[54];
assign fp[5] = s[55];
assign fp[6] = s[56];
assign fp[7] = s[57];
assign fp[8] = s[58];
assign fp[9] = s[59];
assign fp[10] = s[60];
assign fp[11] = s[61];
assign fp[12] = s[62];
assign fp[13] = s[63];
assign fp[14] = s[64];
assign fp[15] = s[65];



endmodule
