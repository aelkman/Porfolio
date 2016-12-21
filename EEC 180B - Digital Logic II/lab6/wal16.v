


// 16-bit x 16-bits radix 4 Booth recoding
module wall16(a,b,fp);
	input [15:0] a, b;
	wire[17:0] ps0, ps1, ps2, ps3, ps4, ps5, ps6, ps7; // partial products

//for wallace tree
  	wire [300:1] s;
  	wire [300:1] c;
	wire [32:0] co;

	wire [31:0] p1;
	wire [31:0] p2;
  output [31:0] fp;
////////////////////////////
	wire [2:0] d7, d6, d5, d4, d3, d2, d1, d0;  // recoded digits
	
	
	// Recoders
	Recode4 r0({b[1:0],1'b0}, d0);
	Recode4 r1(b[3:1], d1);
	Recode4 r2(b[5:3], d2);
	Recode4 r3(b[7:5], d3);
	Recode4 r4(b[9:7], d4);
	Recode4 r5(b[11:9], d5);
	Recode4 r6(b[13:11], d6);
	Recode4 r7(b[15:13], d7);
	
	
	// Selectors - in equation form - sign extend on select 1 
	wire [16:0] pp0 = {17{d0[2]}} ^ (({17{d0[1]}} & {a, 1'b 0}) | ({17{d0[0]}} & {a[15],a}));
	wire [16:0] pp1 = {17{d1[2]}} ^ (({17{d1[1]}} & {a, 1'b 0}) | ({17{d1[0]}} & {a[15],a}));
	wire [16:0] pp2 = {17{d2[2]}} ^ (({17{d2[1]}} & {a, 1'b 0}) | ({17{d2[0]}} & {a[15],a}));
	wire [16:0] pp3 = {17{d3[2]}} ^ (({17{d3[1]}} & {a, 1'b 0}) | ({17{d3[0]}} & {a[15],a}));
	wire [16:0] pp4 = {17{d4[2]}} ^ (({17{d4[1]}} & {a, 1'b 0}) | ({17{d4[0]}} & {a[15],a}));
	wire [16:0] pp5 = {17{d5[2]}} ^ (({17{d5[1]}} & {a, 1'b 0}) | ({17{d5[0]}} & {a[15],a}));
	wire [16:0] pp6 = {17{d6[2]}} ^ (({17{d6[1]}} & {a, 1'b 0}) | ({17{d6[0]}} & {a[15],a}));
	wire [16:0] pp7 = {17{d7[2]}} ^ (({17{d7[1]}} & {a, 1'b 0}) | ({17{d7[0]}} & {a[15],a}));
	
	
	// Adders - bwhavioral - sign extend partial sums
	// 1st row of half adders
	assign ps0 = {pp0[16], pp0} + d0[2];
	// 2nd row of half adders
	assign ps1 = {pp1[16], pp1} + d1[2];
	// 3rd row of half adders
	assign ps2 = {pp2[16], pp2} + d2[2];
	// 4th row of half adders
	assign ps3 = {pp3[16], pp3} + d3[2];
	// 5th row of half adders
	assign ps4 = {pp4[16], pp4} + d4[2];
	// 6th row of half adders
	assign ps5 = {pp5[16], pp5} + d5[2];
	// 7th row of half adders
	assign ps6 = {pp6[16], pp6} + d6[2];
	// 8th row of half adders
	assign ps7 = {pp7[16], pp7} + d7[2];

//Wallace tree

//full adders of the tree

Adder FA1(ps0[4],ps1[2],ps2[0],s[1],c[1]); // green
Adder FA2(ps0[5],ps1[3],ps2[1],s[2],c[2]);
Adder FA3(ps0[6],ps1[4],ps2[2],s[3],c[3]);
Adder FA4(ps0[7],ps1[5],ps2[3],s[4],c[4]);
Adder FA5(ps0[8],ps1[6],ps2[4],s[5],c[5]);
Adder FA6(ps0[9],ps1[7],ps2[5],s[6],c[6]);
Adder FA7(ps0[10],ps1[8],ps2[6],s[7],c[7]);
Adder FA8(ps0[11],ps1[9],ps2[7],s[8],c[8]);
Adder FA9(ps0[12],ps1[10],ps2[8],s[9],c[9]);
Adder FA10(ps0[13],ps1[11],ps2[9],s[10],c[10]);
Adder FA11(ps0[14],ps1[12],ps2[10],s[11],c[11]);
Adder FA12(ps0[15],ps1[13],ps2[11],s[12],c[12]);
Adder FA13(ps0[16],ps1[14],ps2[12],s[13],c[13]);
Adder FA14(ps0[17],ps1[15],ps2[13],s[14],c[14]);
Adder FA15(ps0[17],ps1[16],ps2[14],s[15],c[15]); // green top block
Adder FA16(ps0[17],ps1[17],ps2[15],s[16],c[16]);
Adder FA17(ps0[17],ps1[17],ps2[16],s[17],c[17]);
Adder FA18(ps0[17],ps1[17],ps2[17],s[18],c[18]);
Adder FA19(ps0[17],ps1[17],ps2[17],s[19],c[19]);
Adder FA20(ps0[17],ps1[17],ps2[17],s[20],c[20]);
Adder FA21(ps0[17],ps1[17],ps2[17],s[21],c[21]);
Adder FA22(ps0[17],ps1[17],ps2[17],s[22],c[22]);
Adder FA23(ps0[17],ps1[17],ps2[17],s[23],c[23]);
Adder FA24(ps0[17],ps1[17],ps2[17],s[24],c[24]);
Adder FA25(ps0[17],ps1[17],ps2[17],s[25],c[25]); 
Adder FA26(ps0[17],ps1[17],ps2[17],s[26],c[26]);
Adder FA27(ps0[17],ps1[17],ps2[17],s[27],c[27]);
Adder FA28(ps0[17],ps1[17],ps2[17],s[28],c[28]);


Adder FA29(ps3[2],ps4[0],1'b0,s[29],c[29]);
Adder FA30(ps3[3],ps4[1],1'b0,s[30],c[30]);
Adder FA31(ps3[4],ps4[2],ps5[0],s[31],c[31]);
Adder FA32(ps3[5],ps4[3],ps5[1],s[32],c[32]);
Adder FA33(ps3[6],ps4[4],ps5[2],s[33],c[33]);
Adder FA34(ps3[7],ps4[5],ps5[3],s[34],c[34]);
Adder FA35(ps3[8],ps4[6],ps5[4],s[35],c[35]);
Adder FA36(ps3[9],ps4[7],ps5[5],s[36],c[36]);
Adder FA37(ps3[10],ps4[8],ps5[6],s[37],c[37]);
Adder FA38(ps3[11],ps4[9],ps5[7],s[38],c[38]);
Adder FA39(ps3[12],ps4[10],ps5[8],s[39],c[39]); // green top block
Adder FA40(ps3[13],ps4[11],ps5[9],s[40],c[40]);
Adder FA41(ps3[14],ps4[12],ps5[10],s[41],c[41]);
Adder FA42(ps3[15],ps4[13],ps5[11],s[42],c[42]);
Adder FA43(ps3[16],ps4[14],ps5[12],s[43],c[43]);
Adder FA44(ps3[17],ps4[15],ps5[13],s[44],c[44]);
Adder FA45(ps3[17],ps4[16],ps5[14],s[45],c[45]);
Adder FA46(ps3[17],ps4[17],ps5[15],s[46],c[46]);
Adder FA47(ps3[17],ps4[17],ps5[16],s[47],c[47]);
Adder FA48(ps3[17],ps4[17],ps5[17],s[48],c[48]); 
Adder FA49(ps3[17],ps4[17],ps5[17],s[49],c[49]);
Adder FA50(ps3[17],ps4[17],ps5[17],s[50],c[50]);
Adder FA51(ps3[17],ps4[17],ps5[17],s[51],c[51]);
Adder FA52(ps3[17],ps4[17],ps5[17],s[52],c[52]);


Adder FA53(ps6[2],ps7[0],1'b0,s[53],c[53]);
Adder FA54(ps6[3],ps7[1],1'b0,s[54],c[54]);
Adder FA55(ps6[4],ps7[2],1'b0,s[55],c[55]);
Adder FA56(ps6[5],ps7[3],1'b0,s[56],c[56]);
Adder FA57(ps6[6],ps7[4],1'b0,s[57],c[57]);
Adder FA58(ps6[7],ps7[5],1'b0,s[58],c[58]);
Adder FA59(ps6[8],ps7[6],1'b0,s[59],c[59]);
Adder FA60(ps6[9],ps7[7],1'b0,s[60],c[60]);
Adder FA61(ps6[10],ps7[8],1'b0,s[61],c[61]);
Adder FA62(ps6[11],ps7[9],1'b0,s[62],c[62]);
Adder FA63(ps6[12],ps7[10],1'b0,s[63],c[63]);
Adder FA64(ps6[13],ps7[11],1'b0,s[64],c[64]);
Adder FA65(ps6[14],ps7[12],1'b0,s[65],c[65]);
Adder FA66(ps6[15],ps7[13],1'b0,s[66],c[66]);
Adder FA67(ps6[16],ps7[14],1'b0,s[67],c[67]);
Adder FA68(ps6[17],ps7[15],1'b0,s[68],c[68]);
Adder FA69(ps6[17],ps7[16],1'b0,s[69],c[69]);
Adder FA70(ps6[17],ps7[17],1'b0,s[70],c[70]); // end of yellow block




Adder FA71(s[3],c[2],ps3[0],s[71],c[71]); //nuetral (orange type)
Adder FA72(s[4],c[3],ps3[1],s[72],c[72]);
Adder FA73(s[5],c[4],s[29],s[73],c[73]);
Adder FA74(s[6],c[5],s[30],s[74],c[74]);
Adder FA75(s[7],c[6],s[31],s[75],c[75]);
Adder FA76(s[8],c[7],s[32],s[76],c[76]);
Adder FA77(s[9],c[8],s[33],s[77],c[77]);
Adder FA78(s[10],c[9],s[34],s[78],c[78]);
Adder FA79(s[11],c[10],s[35],s[79],c[79]);
Adder FA80(s[12],c[11],s[36],s[80],c[80]);
Adder FA81(s[13],c[12],s[37],s[81],c[81]);
Adder FA82(s[14],c[13],s[38],s[82],c[82]);
Adder FA83(s[15],c[14],s[39],s[83],c[83]);
Adder FA84(s[16],c[15],s[40],s[84],c[84]);
Adder FA85(s[17],c[16],s[41],s[85],c[85]);
Adder FA86(s[18],c[17],s[42],s[86],c[86]);
Adder FA87(s[19],c[18],s[43],s[87],c[87]);
Adder FA88(s[20],c[19],s[44],s[88],c[88]);
Adder FA89(s[21],c[20],s[45],s[89],c[89]);
Adder FA90(s[22],c[21],s[46],s[90],c[90]);
Adder FA91(s[23],c[22],s[47],s[91],c[91]);
Adder FA92(s[24],c[23],s[48],s[92],c[92]);
Adder FA93(s[25],c[24],s[49],s[93],c[93]);
Adder FA94(s[26],c[25],s[50],s[94],c[94]);
Adder FA95(s[27],c[26],s[51],s[95],c[95]);
Adder FA96(s[28],c[27],s[52],s[96],c[96]);// coded up to row 13-15




Adder FA97(c[32],ps6[0],1'b0,s[97],c[97]); //ORANGE
Adder FA98(c[33],ps6[1],1'b0,s[98],c[98]);
Adder FA99(c[34],s[53],1'b0,s[99],c[99]);
Adder FA100(c[35],s[54],c[53],s[100],c[100]);
Adder FA101(c[36],s[55],c[54],s[101],c[101]);
Adder FA102(c[37],s[56],c[55],s[102],c[102]);
Adder FA103(c[38],s[57],c[56],s[103],c[103]);
Adder FA104(c[39],s[58],c[57],s[104],c[104]);
Adder FA105(c[40],s[59],c[58],s[105],c[105]);
Adder FA106(c[41],s[60],c[59],s[106],c[106]);
Adder FA107(c[42],s[61],c[60],s[107],c[107]);
Adder FA108(c[43],s[62],c[61],s[108],c[108]);
Adder FA109(c[44],s[63],c[62],s[109],c[109]);
Adder FA110(c[45],s[64],c[63],s[110],c[110]);
Adder FA111(c[46],s[65],c[64],s[111],c[111]);
Adder FA112(c[47],s[66],c[65],s[112],c[112]);
Adder FA113(c[48],s[67],c[66],s[113],c[113]);
Adder FA114(c[49],s[68],c[67],s[114],c[114]);
Adder FA115(c[50],s[69],c[68],s[115],c[115]);
Adder FA116(c[51],s[70],c[69],s[116],c[116]); //row 18




Adder FA117(s[74],c[73],c[29],s[117],c[117]);
Adder FA118(s[75],c[74],c[30],s[118],c[118]);
Adder FA119(s[76],c[75],c[31],s[119],c[119]);
Adder FA120(s[77],c[76],s[97],s[120],c[120]);
Adder FA121(s[78],c[77],s[98],s[121],c[121]);
Adder FA122(s[79],c[78],s[99],s[122],c[122]);
Adder FA123(s[80],c[79],s[100],s[123],c[123]);
Adder FA124(s[81],c[80],s[101],s[124],c[124]);
Adder FA125(s[82],c[81],s[102],s[125],c[125]);
Adder FA126(s[83],c[82],s[103],s[126],c[126]);
Adder FA127(s[84],c[83],s[104],s[127],c[127]);
Adder FA128(s[85],c[84],s[105],s[128],c[128]);
Adder FA129(s[86],c[85],s[106],s[129],c[129]);
Adder FA130(s[87],c[86],s[107],s[130],c[130]);
Adder FA131(s[88],c[87],s[108],s[131],c[131]);
Adder FA132(s[89],c[88],s[109],s[132],c[132]);
Adder FA133(s[90],c[89],s[110],s[133],c[133]);
Adder FA134(s[91],c[90],s[111],s[134],c[134]);
Adder FA135(s[92],c[91],s[112],s[135],c[135]);
Adder FA136(s[93],c[92],s[113],s[136],c[136]);
Adder FA137(s[94],c[93],s[114],s[137],c[137]);
Adder FA138(s[95],c[94],s[115],s[138],c[138]);
Adder FA139(s[96],c[95],s[116],s[139],c[139]); //end row 23



Adder FA140(s[118],c[117],1'b0,s[140],c[140]);
Adder FA141(s[119],c[118],1'b0,s[141],c[141]);
Adder FA142(s[120],c[119],1'b0,s[142],c[142]);
Adder FA143(s[121],c[120],c[97],s[143],c[143]);
Adder FA144(s[122],c[121],c[98],s[144],c[144]);
Adder FA145(s[123],c[122],c[99],s[145],c[145]);
Adder FA146(s[124],c[123],c[100],s[146],c[146]);
Adder FA147(s[125],c[124],c[101],s[147],c[147]);
Adder FA148(s[126],c[125],c[102],s[148],c[148]);
Adder FA149(s[127],c[126],c[103],s[149],c[149]);
Adder FA150(s[128],c[127],c[104],s[150],c[150]);
Adder FA151(s[129],c[128],c[105],s[151],c[151]);
Adder FA152(s[130],c[129],c[106],s[152],c[152]);
Adder FA153(s[131],c[130],c[107],s[153],c[153]);
Adder FA154(s[132],c[131],c[108],s[154],c[154]);
Adder FA155(s[133],c[132],c[109],s[155],c[155]);
Adder FA156(s[134],c[133],c[110],s[156],c[156]);
Adder FA157(s[135],c[134],c[111],s[157],c[157]);
Adder FA158(s[136],c[135],c[112],s[158],c[158]);
Adder FA159(s[137],c[136],c[113],s[159],c[159]);
Adder FA160(s[138],c[137],c[114],s[160],c[160]);
Adder FA161(s[139],c[138],c[115],s[161],c[161]);


//output assignments p1
assign p1[0]=ps0[0];
assign p1[1]=ps0[1];
assign p1[2]=ps0[2];
assign p1[3]=ps0[3];
assign p1[4]=s[1];
assign p1[5]=s[2];
assign p1[6]=s[71];
assign p1[7]=s[72];
assign p1[8]=s[73];
assign p1[9]=s[117];
assign p1[10]=s[140];
assign p1[11]=s[141];
assign p1[12]=s[142];
assign p1[13]=s[143];
assign p1[14]=s[144];
assign p1[15]=s[145];
assign p1[16]=s[146];
assign p1[17]=s[147];
assign p1[18]=s[148];
assign p1[19]=s[149];
assign p1[20]=s[150];
assign p1[21]=s[151];
assign p1[22]=s[152];
assign p1[23]=s[153];
assign p1[24]=s[154];
assign p1[25]=s[155];
assign p1[26]=s[156];
assign p1[27]=s[157];
assign p1[28]=s[158];
assign p1[29]=s[159];
assign p1[30]=s[160];
assign p1[31]=s[161];

//output assignments p2

assign p2[0]=1'b0;
assign p2[1]=1'b0;
assign p2[2]=ps1[0];
assign p2[3]=ps1[1];
assign p2[4]=1'b0;
assign p2[5]=c[1];
assign p2[6]=1'b0;
assign p2[7]=c[71];
assign p2[8]=c[72];
assign p2[9]=1'b0;
assign p2[10]=1'b0;
assign p2[11]=c[140];
assign p2[12]=c[141];
assign p2[13]=c[142];
assign p2[14]=c[143];
assign p2[15]=c[144];
assign p2[16]=c[145];
assign p2[17]=c[146];
assign p2[18]=c[147];
assign p2[19]=c[148];
assign p2[20]=c[149];
assign p2[21]=c[150];
assign p2[22]=c[151];
assign p2[23]=c[152];
assign p2[24]=c[153];
assign p2[25]=c[154];
assign p2[26]=c[155];
assign p2[27]=c[156];
assign p2[28]=c[157];
assign p2[29]=c[158];
assign p2[30]=c[159];
assign p2[31]=c[160];


Cla32 UUT(p1[31:0], p2[31:0], 1'b0, co[32:0]);

fullAdder A98(p1[0],p2[0],co[0],s[162]);
fullAdder A99(p1[1],p2[1],co[1],s[163]);
fullAdder A100(p1[2],p2[2],co[2],s[164]);
fullAdder A101(p1[3],p2[3],co[3],s[165]);
fullAdder A102(p1[4],p2[4],co[4],s[166]);
fullAdder A103(p1[5],p2[5],co[5],s[167]);
fullAdder A10(p1[6],p2[6],co[6],s[168]);
fullAdder A104(p1[7],p2[7],co[7],s[169]);
fullAdder A105(p1[8],p2[8],co[8],s[170]);
fullAdder A106(p1[9],p2[9],co[9],s[171]);
fullAdder A107(p1[10],p2[10],co[10],s[172]);
fullAdder A108(p1[11],p2[11],co[11],s[173]);
fullAdder A109(p1[12],p2[12],co[12],s[174]);
fullAdder A110(p1[13],p2[13],co[13],s[175]);
fullAdder A111(p1[14],p2[14],co[14],s[176]);

fullAdder A112(p1[15],p2[15],co[15],s[177]);
fullAdder A113(p1[16],p2[16],co[16],s[178]);
fullAdder A114(p1[17],p2[17],co[17],s[179]);
fullAdder A115(p1[18],p2[18],co[18],s[180]);
fullAdder A116(p1[19],p2[19],co[19],s[181]);
fullAdder A117(p1[20],p2[20],co[20],s[182]);
fullAdder A118(p1[21],p2[21],co[21],s[183]);
fullAdder A119(p1[22],p2[22],co[22],s[184]);
fullAdder A120(p1[23],p2[23],co[23],s[185]);
fullAdder A121(p1[24],p2[24],co[24],s[186]);
fullAdder A122(p1[25],p2[25],co[25],s[187]);
fullAdder A123(p1[26],p2[26],co[26],s[188]);
fullAdder A124(p1[27],p2[27],co[27],s[189]);
fullAdder A125(p1[28],p2[28],co[28],s[190]);
fullAdder A126(p1[29],p2[29],co[29],s[191]);
fullAdder A127(p1[30],p2[30],co[30],s[192]);
fullAdder A128(p1[31],p2[31],co[31],s[193]);

assign fp[0] = s[162];
assign fp[1] = s[163];
assign fp[2] = s[164];
assign fp[3] = s[165];
assign fp[4] = s[166];
assign fp[5] = s[167];
assign fp[6] = s[168];
assign fp[7] = s[169];
assign fp[8] = s[170];
assign fp[9] = s[171];
assign fp[10] = s[172];
assign fp[11] = s[173];
assign fp[12] = s[174];
assign fp[13] = s[175];
assign fp[14] = s[176];
assign fp[15] = s[177];
assign fp[16] = s[178];
assign fp[17] = s[179];
assign fp[18] = s[180];
assign fp[19] = s[181];
assign fp[20] = s[182];
assign fp[21] = s[183];
assign fp[22] = s[184];
assign fp[23] = s[185];
assign fp[24] = s[186];
assign fp[25] = s[187];
assign fp[26] = s[188];
assign fp[27] = s[189];
assign fp[28] = s[190];
assign fp[29] = s[191];
assign fp[30] = s[192];
assign fp[31] = s[193];


endmodule
/////////////////////////////////////////////////////////////////////////////////////////////////
