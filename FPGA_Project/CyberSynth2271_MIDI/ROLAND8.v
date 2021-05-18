module ROLAND8( 
	input CLK24M,
	input CLK,
	input [15:0] chanEn,
	input [6:0] instrSet,
	input [15:0] chanSet,
	input [6:0] note,
	input [6:0] velocity,
	input [6:0] keypressure,
	input [6:0] chanpressure,
	output reg [7:0] wavePos 
);

wire [127:0] mask1; wire [127:0] mask2; wire [127:0] mask3; wire [127:0] mask4; wire [127:0] mask5; wire [127:0] mask6; 
wire [127:0] mask7; wire [127:0] mask8; wire [127:0] mask9; wire [127:0] mask10;wire [127:0] mask11;wire [127:0] mask12;
wire [127:0] mask13;wire [127:0] mask14;wire [127:0] mask15;wire [127:0] mask16;wire [7:0] wc1; 	wire [7:0] wc2; 
wire [7:0] wc3; 	wire [7:0] wc4; 	wire [7:0] wc5; 	wire [7:0] wc6; 	wire [7:0] wc7; 	wire [7:0] wc8; 	wire [7:0] wc9; 
wire [7:0] wc10; 	wire [7:0] wc11; 	wire [7:0] wc12; 	wire [7:0] wc13; 	wire [7:0] wc14; 	wire [7:0] wc15; 	wire [7:0] wc16;
wire [7:0] wco1; 	wire [7:0] wco2; 	wire [7:0] wco3; 	wire [7:0] wco4; 	wire [7:0] wco5; 	wire [7:0] wco6; 	wire [7:0] wco7; 
wire [7:0] wco8; 	wire [7:0] wco9; 	wire [7:0] wco10; 	wire [7:0] wco11; 	wire [7:0] wco12; 	wire [7:0] wco13; 	wire [7:0] wco14; 	
wire [7:0] wco15; 	wire [7:0] wco16;
wire clk1;	wire clk2;	wire clk3;	wire clk4;	wire clk5;	wire clk6;	wire clk7;	wire clk8;	wire clk9;
wire clk10;	wire clk11;	wire clk12;	wire clk13;	wire clk14;	wire clk15;	wire clk16;
Instruments inst(mask1, mask2, mask3, mask4, mask5, mask6, mask7, mask8, mask9, mask10, mask11, mask12, mask13, mask14, mask15, mask16, 
	clk1, clk2, clk3, clk4, clk5, clk6, clk7, clk8, clk9, clk10, clk11, clk12, clk13, clk14, clk15, clk16, 
	wc1, wc2, wc3, wc4, wc5, wc6, wc7, wc8, wc9, wc10, wc11, wc12, wc13, wc14, wc15, wc16);
	
CHN  c1(CLK24M, chanSet[0 : 0] , instrSet, note, chanpressure, chanEn[0 : 0], wc1,  mask1,  wco1 , clk1 );
CHN  c2(CLK24M, chanSet[1 : 1] , instrSet, note, chanpressure, chanEn[1 : 1], wc2,  mask2,  wco2 , clk2 );
CHN  c3(CLK24M, chanSet[2 : 2] , instrSet, note, chanpressure, chanEn[2 : 2], wc3,  mask3,  wco3 , clk3 );
CHN  c4(CLK24M, chanSet[3 : 3] , instrSet, note, chanpressure, chanEn[3 : 3], wc4,  mask4,  wco4 , clk4 );
CHN  c5(CLK24M, chanSet[4 : 4] , instrSet, note, chanpressure, chanEn[4 : 4], wc5,  mask5,  wco5 , clk5 );
CHN  c6(CLK24M, chanSet[5 : 5] , instrSet, note, chanpressure, chanEn[5 : 5], wc6,  mask6,  wco6 , clk6 );
CHN  c7(CLK24M, chanSet[6 : 6] , instrSet, note, chanpressure, chanEn[6 : 6], wc7,  mask7,  wco7 , clk7 );
CHN  c8(CLK24M, chanSet[7 : 7] , instrSet, note, chanpressure, chanEn[7 : 7], wc8,  mask8,  wco8 , clk8 );
CHN  c9(CLK24M, chanSet[8 : 8] , instrSet, note, chanpressure, chanEn[8 : 8], wc9,  mask9,  wco9 , clk9 );
CHN c10(CLK24M, chanSet[9 : 9] , instrSet, note, chanpressure, chanEn[9 : 9], wc10, mask10, wco10, clk10);
CHN c11(CLK24M, chanSet[10:10] , instrSet, note, chanpressure, chanEn[10:10], wc11, mask11, wco11, clk11);
CHN c12(CLK24M, chanSet[11:11] , instrSet, note, chanpressure, chanEn[11:11], wc12, mask12, wco12, clk12);
CHN c13(CLK24M, chanSet[12:12] , instrSet, note, chanpressure, chanEn[12:12], wc13, mask13, wco13, clk13);
CHN c14(CLK24M, chanSet[13:13] , instrSet, note, chanpressure, chanEn[13:13], wc14, mask14, wco14, clk14);
CHN c15(CLK24M, chanSet[14:14] , instrSet, note, chanpressure, chanEn[14:14], wc15, mask15, wco15, clk15);
CHN c16(CLK24M, chanSet[15:15] , instrSet, note, chanpressure, chanEn[15:15], wc16, mask16, wco16, clk16);

wire [11:0] temp_wave = wco1 + wco2 + wco3 + wco4 + wco5 + wco6 + wco7 + wco8 + wco9 + wco10 + wco11 + wco12 + wco13 + wco14 + wco15 + wco16; 
reg [23:0] waves;
always @ (posedge CLK) begin
	waves = (temp_wave * velocity * keypressure) >> 6;
	while (waves > 255) begin waves = (waves >> 1); end
	if (waves[7:0] < 16) begin waves = (waves + 8'd16); end
	wavePos = waves[7:0];
end

endmodule

module CHN (
	input CLK24M,
	input SET,
	input [6:0] instr,
	input [6:0] note,
	input [6:0] pressure,
	input ENABLE,
	input [7:0] wc,
	output wire [127:0] mask,
	output reg [7:0] wco,
	output wire dClk
);

reg [6:0] instrument;
assign mask = (ENABLE & 1'b1) << instrument;

reg [6:0] _note;
NTE_CLK cc(CLK24M, SET, _note, dClk);

reg [6:0] pres;
always @ (posedge dClk) begin
	if (ENABLE) wco = (wc * pres) >> 7;
	else wco = 0;
	if (SET) begin
		instrument = instr;
		pres = pressure;
		_note = note;
	end
end 

endmodule

module Instruments(
	input [127:0] mask1,
	input [127:0] mask2,
	input [127:0] mask3,
	input [127:0] mask4,
	input [127:0] mask5,
	input [127:0] mask6,
	input [127:0] mask7,
	input [127:0] mask8,
	input [127:0] mask9,
	input [127:0] mask10,
	input [127:0] mask11,
	input [127:0] mask12,
	input [127:0] mask13,
	input [127:0] mask14,
	input [127:0] mask15,
	input [127:0] mask16,
	input CLK1,
	input CLK2,
	input CLK3,
	input CLK4,
	input CLK5,
	input CLK6,
	input CLK7,
	input CLK8,
	input CLK9,
	input CLK10,
	input CLK11,
	input CLK12,
	input CLK13,
	input CLK14,
	input CLK15,
	input CLK16,
	output wire [7:0] wc1,
	output wire [7:0] wc2,
	output wire [7:0] wc3,
	output wire [7:0] wc4,
	output wire [7:0] wc5,
	output wire [7:0] wc6,
	output wire [7:0] wc7,
	output wire [7:0] wc8,
	output wire [7:0] wc9,
	output wire [7:0] wc10,
	output wire [7:0] wc11,
	output wire [7:0] wc12,
	output wire [7:0] wc13,
	output wire [7:0] wc14,
	output wire [7:0] wc15,
	output wire [7:0] wc16
);
wire [127:0] mask = mask1 | mask2 | mask3 | mask4 | mask5 | mask6 | mask7 | mask8 | 
	mask9 | mask10 | mask11 | mask12 | mask13 | mask14 | mask15 | mask16;
wire [7:0] w1;	wire [7:0] w22;	wire [7:0] w43;	wire [7:0] w64;	wire [7:0] w85;	wire [7:0] w109;
wire [7:0] w2;	wire [7:0] w23;	wire [7:0] w44;	wire [7:0] w65;	wire [7:0] w86;	wire [7:0] w110;
wire [7:0] w3;	wire [7:0] w24;	wire [7:0] w45;	wire [7:0] w66;	wire [7:0] w87;	wire [7:0] w111;
wire [7:0] w4;	wire [7:0] w25;	wire [7:0] w46;	wire [7:0] w67;	wire [7:0] w88;	wire [7:0] w112;
wire [7:0] w5;	wire [7:0] w26;	wire [7:0] w47;	wire [7:0] w68;	wire [7:0] w89;	wire [7:0] w113;
wire [7:0] w6;	wire [7:0] w27;	wire [7:0] w48;	wire [7:0] w69;	wire [7:0] w91;	wire [7:0] w114;
wire [7:0] w7;	wire [7:0] w28;	wire [7:0] w49;	wire [7:0] w70;	wire [7:0] w92;	wire [7:0] w115;
wire [7:0] w8;	wire [7:0] w29;	wire [7:0] w50;	wire [7:0] w71;	wire [7:0] w93;	wire [7:0] w116;
wire [7:0] w9;	wire [7:0] w30;	wire [7:0] w51;	wire [7:0] w72;	wire [7:0] w95;	wire [7:0] w117;
wire [7:0] w11;	wire [7:0] w31;	wire [7:0] w52;	wire [7:0] w73;	wire [7:0] w96;	wire [7:0] w118;
wire [7:0] w12;	wire [7:0] w32;	wire [7:0] w53;	wire [7:0] w75;	wire [7:0] w97;	wire [7:0] w119;
wire [7:0] w13;	wire [7:0] w33;	wire [7:0] w54;	wire [7:0] w76;	wire [7:0] w98;	wire [7:0] w120;
wire [7:0] w14;	wire [7:0] w34;	wire [7:0] w55;	wire [7:0] w77;	wire [7:0] w99;	wire [7:0] w121;
wire [7:0] w15;	wire [7:0] w35;	wire [7:0] w56;	wire [7:0] w78;	wire [7:0] w100;wire [7:0] w123;
wire [7:0] w16;	wire [7:0] w36;	wire [7:0] w57;	wire [7:0] w79;	wire [7:0] w101;wire [7:0] w124;
wire [7:0] w17;	wire [7:0] w37;	wire [7:0] w59;	wire [7:0] w80;	wire [7:0] w103;wire [7:0] w125;
wire [7:0] w18;	wire [7:0] w38;	wire [7:0] w60;	wire [7:0] w81;	wire [7:0] w104;wire [7:0] w126;
wire [7:0] w19;	wire [7:0] w39;	wire [7:0] w61;	wire [7:0] w82;	wire [7:0] w105;wire [7:0] w127;
wire [7:0] w20;	wire [7:0] w40;	wire [7:0] w62;	wire [7:0] w83;	wire [7:0] w107;wire [7:0] w128;
wire [7:0] w21;	wire [7:0] w41;	wire [7:0] w63;	wire [7:0] w84;	wire [7:0] w108;wire [7:0] dummy = 8'd64;

wire [127:0] CLK = (mask1 * CLK1) | (mask2 * CLK2) | (mask3 * CLK3) | (mask4 * CLK4) | (mask5 * CLK5) | (mask6 * CLK6) | 
	(mask7 * CLK7) | (mask8 * CLK8) | (mask9 * CLK9) | (mask10 * CLK10) | (mask11 * CLK11) | (mask12 * CLK12) | 
	(mask13 * CLK13) | (mask14 * CLK14) | (mask15 * CLK15) | (mask16 * CLK16);
	
R1 r1(CLK[0:0], mask[0:0], w1);
R2 r2(CLK[1:1], mask[1:1], w2);
R3 r3(CLK[2:2], mask[2:2], w3);
R4 r4(CLK[3:3], mask[3:3], w4);
R5 r5(CLK[4:4], mask[4:4], w5);
R6 r6(CLK[5:5], mask[5:5], w6);
R7 r7(CLK[6:6], mask[6:6], w7);
R8 r8(CLK[7:7], mask[7:7], w8);
R9 r9(CLK[8:8], mask[8:8], w9);

R11 r11(CLK[10:10], mask[10:10], w11);
R12 r12(CLK[11:11], mask[11:11], w12);
R13 r13(CLK[12:12], mask[12:12], w13);
R14 r14(CLK[13:13], mask[13:13], w14);
R15 r15(CLK[14:14], mask[14:14], w15);
R16 r16(CLK[15:15], mask[15:15], w16);
R17 r17(CLK[16:16], mask[16:16], w17);
R18 r18(CLK[17:17], mask[17:17], w18);
R19 r19(CLK[18:18], mask[18:18], w19);
R20 r20(CLK[19:19], mask[19:19], w20);
R21 r21(CLK[20:20], mask[20:20], w21);
R22 r22(CLK[21:21], mask[21:21], w22);
R23 r23(CLK[22:22], mask[22:22], w23);
R24 r24(CLK[23:23], mask[23:23], w24);
R25 r25(CLK[24:24], mask[24:24], w25);
R26 r26(CLK[25:25], mask[25:25], w26);
R27 r27(CLK[26:26], mask[26:26], w27);
R28 r28(CLK[27:27], mask[27:27], w28);
R29 r29(CLK[28:28], mask[28:28], w29);
R30 r30(CLK[29:29], mask[29:29], w30);
R31 r31(CLK[30:30], mask[30:30], w31);
R32 r32(CLK[31:31], mask[31:31], w32);
R33 r33(CLK[32:32], mask[32:32], w33);
R34 r34(CLK[33:33], mask[33:33], w34);
R35 r35(CLK[34:34], mask[34:34], w35);
R36 r36(CLK[35:35], mask[35:35], w36);
R37 r37(CLK[36:36], mask[36:36], w37);
R38 r38(CLK[37:37], mask[37:37], w38);
R39 r39(CLK[38:38], mask[38:38], w39);
R40 r40(CLK[39:39], mask[39:39], w40);
R41 r41(CLK[40:40], mask[40:40], w41);

R43 r43(CLK[42:42], mask[42:42], w43);
R44 r44(CLK[43:43], mask[43:43], w44);
R45 r45(CLK[44:44], mask[44:44], w45);
R46 r46(CLK[45:45], mask[45:45], w46);
R47 r47(CLK[46:46], mask[46:46], w47);
R48 r48(CLK[47:47], mask[47:47], w48);
R49 r49(CLK[48:48], mask[48:48], w49);
R50 r50(CLK[49:49], mask[49:49], w50);
R51 r51(CLK[50:50], mask[50:50], w51);
R52 r52(CLK[51:51], mask[51:51], w52);
R53 r53(CLK[52:52], mask[52:52], w53);
R54 r54(CLK[53:53], mask[53:53], w54);
R55 r55(CLK[54:54], mask[54:54], w55);
R56 r56(CLK[55:55], mask[55:55], w56);
R57 r57(CLK[56:56], mask[56:56], w57);

R59 r59(CLK[58:58], mask[58:58], w59);
R60 r60(CLK[59:59], mask[59:59], w60);
R61 r61(CLK[60:60], mask[60:60], w61);
R62 r62(CLK[61:61], mask[61:61], w62);
R63 r63(CLK[62:62], mask[62:62], w63);
R64 r64(CLK[63:63], mask[63:63], w64);
R65 r65(CLK[64:64], mask[64:64], w65);
R66 r66(CLK[65:65], mask[65:65], w66);
R67 r67(CLK[66:66], mask[66:66], w67);
R68 r68(CLK[67:67], mask[67:67], w68);
R69 r69(CLK[68:68], mask[68:68], w69);
R70 r70(CLK[69:69], mask[69:69], w70);
R71 r71(CLK[70:70], mask[70:70], w71);
R72 r72(CLK[71:71], mask[71:71], w72);
R73 r73(CLK[72:72], mask[72:72], w73);

R75 r75(CLK[74:74], mask[74:74], w75);
R76 r76(CLK[75:75], mask[75:75], w76);
R77 r77(CLK[76:76], mask[76:76], w77);
R78 r78(CLK[77:77], mask[77:77], w78);
R79 r79(CLK[78:78], mask[78:78], w79);
R80 r80(CLK[79:79], mask[79:79], w80);
R81 r81(CLK[80:80], mask[80:80], w81);
R82 r82(CLK[81:81], mask[81:81], w82);
R83 r83(CLK[82:82], mask[82:82], w83);
R84 r84(CLK[83:83], mask[83:83], w84);
R85 r85(CLK[84:84], mask[84:84], w85);
R86 r86(CLK[85:85], mask[85:85], w86);
R87 r87(CLK[86:86], mask[86:86], w87);
R88 r88(CLK[87:87], mask[87:87], w88);
R89 r89(CLK[88:88], mask[88:88], w89);

R91 r91(CLK[90:90], mask[90:90], w91);
R92 r92(CLK[91:91], mask[91:91], w92);
R93 r93(CLK[92:92], mask[92:92], w93);

R95 r95(CLK[94:94], mask[94:94], w95);
R96 r96(CLK[95:95], mask[95:95], w96);
R97 r97(CLK[96:96], mask[96:96], w97);
R98 r98(CLK[97:97], mask[97:97], w98);
R99 r99(CLK[98:98], mask[98:98], w99);
R100 r100(CLK[99:99], mask[99:99], w100);
R101 r101(CLK[100:100], mask[100:100], w101);

R103 r103(CLK[101:101], mask[102:102], w103);
R104 r104(CLK[102:102], mask[103:103], w104);
R105 r105(CLK[103:103], mask[104:104], w105);

R107 r107(CLK[106:106], mask[106:106], w107);
R108 r108(CLK[107:107], mask[107:107], w108);
R109 r109(CLK[108:108], mask[108:108], w109);
R110 r110(CLK[109:109], mask[109:109], w110);
R111 r111(CLK[110:110], mask[110:110], w111);
R112 r112(CLK[111:111], mask[111:111], w112);
R113 r113(CLK[112:112], mask[112:112], w113);
R114 r114(CLK[113:113], mask[113:113], w114);
R115 r115(CLK[114:114], mask[114:114], w115);
R116 r116(CLK[115:115], mask[115:115], w116);
R117 r117(CLK[116:116], mask[116:116], w117);
R118 r118(CLK[117:117], mask[117:117], w118);
R119 r119(CLK[118:118], mask[118:118], w119);
R120 r120(CLK[119:119], mask[119:119], w120);
R121 r121(CLK[120:120], mask[120:120], w121);

R123 r123(CLK[122:122], mask[122:122], w123);
R124 r124(CLK[123:123], mask[123:123], w124);
R125 r125(CLK[124:124], mask[124:124], w125);
R126 r126(CLK[125:125], mask[125:125], w126);
R127 r127(CLK[126:126], mask[126:126], w127);
R128 r128(CLK[127:127], mask[127:127], w128);

RMUX crm1(mask1, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc1);

RMUX crm2(mask2, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc2);

RMUX crm3(mask3, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc3);

RMUX crm4(mask4, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc4);

RMUX crm5(mask5, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc5);

RMUX crm6(mask6, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc6);

RMUX crm7(mask7, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc7);

RMUX crm8(mask8, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc8);

RMUX crm9(mask9, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc9);

RMUX crm10(mask10, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc10);

RMUX crm11(mask11, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc11);

RMUX crm12(mask12, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc12);

RMUX crm13(mask13, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc13);

RMUX crm14(mask14, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc14);

RMUX crm15(mask15, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc15);

RMUX crm16(mask16, w30, w46, w62, w78, w95, w112, w1, w16, w31, w47, w63, w79, w96, w113, w2, w17, w32, w48, w64, w80, w97, w114, 
	w3, w18, w33, w49, w65, w81, w98, w115, w4, w19, w34, w50, w66, w82, w99, w116, w5, w20, w35, w51, w67, w83, w100, w117, 
	w6, w21, w36, w52, w68, w84, w101, w118, w7, w22, w37, w53, w69, w85, w103, w119, w8, w23, w38, w54, w70, w86, w104, w120, 
	w9, w24, w39, w55, w71, w87, w105, w121, w11, w25, w40, w56, w72, w88, w107, w123, w12, w26, w41, w57, w73, w89, w108, w124, 
	w13, w27, w43, w59, w75, w91, w109, w125, w14, w28, w44, w60, w76, w92, w110, w126, w15, w29, w45, w61, w77, w93, w111, w127, 
	w128, dummy, wc16);


endmodule

module RMUX(input [127:0] mask, 		input [7:0] w30, input [7:0] w46, input [7:0] w62, input [7:0] w78, input [7:0] w95, input [7:0] w112, 
	input [7:0] w1,   input [7:0] w16, input [7:0] w31, input [7:0] w47, input [7:0] w63, input [7:0] w79, input [7:0] w96,  input [7:0] w113, 
	input [7:0] w2,   input [7:0] w17, input [7:0] w32, input [7:0] w48, input [7:0] w64, input [7:0] w80, input [7:0] w97,  input [7:0] w114, 
	input [7:0] w3,   input [7:0] w18, input [7:0] w33, input [7:0] w49, input [7:0] w65, input [7:0] w81, input [7:0] w98,  input [7:0] w115, 
	input [7:0] w4,   input [7:0] w19, input [7:0] w34, input [7:0] w50, input [7:0] w66, input [7:0] w82, input [7:0] w99,  input [7:0] w116, 
	input [7:0] w5,   input [7:0] w20, input [7:0] w35, input [7:0] w51, input [7:0] w67, input [7:0] w83, input [7:0] w100, input [7:0] w117, 
	input [7:0] w6,   input [7:0] w21, input [7:0] w36, input [7:0] w52, input [7:0] w68, input [7:0] w84, input [7:0] w101, input [7:0] w118, 
	input [7:0] w7,   input [7:0] w22, input [7:0] w37, input [7:0] w53, input [7:0] w69, input [7:0] w85, input [7:0] w103, input [7:0] w119, 
	input [7:0] w8,   input [7:0] w23, input [7:0] w38, input [7:0] w54, input [7:0] w70, input [7:0] w86, input [7:0] w104, input [7:0] w120, 
	input [7:0] w9,   input [7:0] w24, input [7:0] w39, input [7:0] w55, input [7:0] w71, input [7:0] w87, input [7:0] w105, input [7:0] w121, 
	input [7:0] w11,  input [7:0] w25, input [7:0] w40, input [7:0] w56, input [7:0] w72, input [7:0] w88, input [7:0] w107, input [7:0] w123, 
	input [7:0] w12,  input [7:0] w26, input [7:0] w41, input [7:0] w57, input [7:0] w73, input [7:0] w89, input [7:0] w108, input [7:0] w124, 
	input [7:0] w13,  input [7:0] w27, input [7:0] w43, input [7:0] w59, input [7:0] w75, input [7:0] w91, input [7:0] w109, input [7:0] w125, 
	input [7:0] w14,  input [7:0] w28, input [7:0] w44, input [7:0] w60, input [7:0] w76, input [7:0] w92, input [7:0] w110, input [7:0] w126, 
	input [7:0] w15,  input [7:0] w29, input [7:0] w45, input [7:0] w61, input [7:0] w77, input [7:0] w93, input [7:0] w111, input [7:0] w127, 
	input [7:0] w128, input [7:0] dummy, output wire [7:0] wave);

assign wave = mask[0:0] ? w1 : mask[1:1] ? w2 : mask[2:2] ? w3 : mask[3:3] ? w4 : mask[4:4] ? w5 : mask[5:5] ? w6 : mask[6:6] ? w7 : mask[7:7] ? w8 : 
	mask[8:8] ? w9 : mask[10:10] ? w11 : mask[11:11] ? w12 : mask[12:12] ? w13 : mask[13:13] ? w14 : mask[14:14] ? w15 : mask[15:15] ? w16 : 
	mask[16:16] ? w17 : mask[17:17] ? w18 : mask[18:18] ? w19 : mask[19:19] ? w20 : mask[20:20] ? w21 : mask[21:21] ? w22 : mask[22:22] ? w23 : 
	mask[23:23] ? w24 : mask[24:24] ? w25 : mask[25:25] ? w26 : mask[26:26] ? w27 : mask[27:27] ? w28 : mask[28:28] ? w29 : mask[29:29] ? w30 : 
	mask[30:30] ? w31 : mask[31:31] ? w32 : mask[32:32] ? w33 : mask[33:33] ? w34 : mask[34:34] ? w35 : mask[35:35] ? w36 : mask[36:36] ? w37 : 
	mask[37:37] ? w38 : mask[38:38] ? w39 : mask[39:39] ? w40 : mask[40:40] ? w41 : mask[42:42] ? w43 : mask[43:43] ? w44 : mask[44:44] ? w45 : 
	mask[45:45] ? w46 : mask[46:46] ? w47 : mask[47:47] ? w48 : mask[48:48] ? w49 : mask[49:49] ? w50 : mask[50:50] ? w51 : mask[51:51] ? w52 : 
	mask[52:52] ? w53 : mask[53:53] ? w54 : mask[54:54] ? w55 : mask[55:55] ? w56 : mask[56:56] ? w57 : mask[58:58] ? w59 : mask[59:59] ? w60 : 
	mask[60:60] ? w61 : mask[61:61] ? w62 : mask[62:62] ? w63 : mask[63:63] ? w64 : mask[64:64] ? w65 : mask[65:65] ? w66 : mask[66:66] ? w67 : 
	mask[67:67] ? w68 : mask[68:68] ? w69 : mask[69:69] ? w70 : mask[70:70] ? w71 : mask[71:71] ? w72 : mask[72:72] ? w73 : mask[74:74] ? w75 : 
	mask[75:75] ? w76 : mask[76:76] ? w77 : mask[77:77] ? w78 : mask[78:78] ? w79 : mask[79:79] ? w80 : mask[80:80] ? w81 : mask[81:81] ? w82 : 
	mask[82:82] ? w83 : mask[83:83] ? w84 : mask[84:84] ? w85 : mask[85:85] ? w86 : mask[86:86] ? w87 : mask[87:87] ? w88 : mask[88:88] ? w89 : 
	mask[90:90] ? w91 : mask[91:91] ? w92 : mask[92:92] ? w93 : mask[94:94] ? w95 : mask[95:95] ? w96 : mask[96:96] ? w97 : mask[97:97] ? w98 : 
	mask[98:98] ? w99 : mask[99:99] ? w100 : mask[100:100] ? w101 : mask[102:102] ? w103 : mask[103:103] ? w104 : mask[104:104] ? w105 : 
	mask[106:106] ? w107 : mask[107:107] ? w108 : mask[108:108] ? w109 : mask[109:109] ? w110 : mask[110:110] ? w111 : mask[111:111] ? w112 : 
	mask[112:112] ? w113 : mask[113:113] ? w114 : mask[114:114] ? w115 : mask[115:115] ? w116 : mask[116:116] ? w117 : mask[117:117] ? w118 : 
	mask[118:118] ? w119 : mask[119:119] ? w120 : mask[120:120] ? w121 : mask[122:122] ? w123 : mask[123:123] ? w124 : mask[124:124] ? w125 : 
	mask[125:125] ? w126 : mask[126:126] ? w127 : mask[127:127] ? w128 : dummy;

endmodule

module R1(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h7F766D5F5451565E616365666463676F7476767A848B8D92999D9C979394999C9C98949190929799958B807E8286878684807B74707681888C8D8B888481;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R2(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h818E9A9B9799A2A8A8A9A7A09B99999EA0A09F9D978F8F918D898685837D7C848C897B71747C83888A867A695A534F4946494E5456585E65696965636D7D;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R3(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h8D9DA5AFB4B8B3ACA6A6ACAAA9A8A19693989A9C9683634F5E6E7575614B43455D76757373707882837E7E848077808C8777706C5F565458626D73757D;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R4(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h8394A1A09CA2AAB1B8AFA9A7A2A0A4ACAEADA79D9D9C96999D998C878B8A868485868176757F888A82786C584943434546464E5355575F65676766687282;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R5(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h81878B8C9195979DA0A1A7A9ABAFB0B0B3B1B0B0ABA8A59E989389837D746F6A63615F5C5B5B5A5A5B5A5C5C5D5E5F5F6161626466676B6D7075777B8081;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R6(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h85858086939A968D8D969997919094949492908E878688867D727177797065656F756F65667079767376808A8D8F939495918C86786A636568635F6577;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R7(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h85908EA5B1A699939D8F8982888F988E8D8B98958D8781888B867885826F6072787F83786D6D6D625F8385756E757D7E7E76717A66556B70706871747F81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R8(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h81817E7F7E7C7D7C7C7D7C7D7D7C7E7C7C7B797A7978767876747C7472788897A7A5848077666146374A657E929A9A9B9D9996999691918E8B89878582;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R9(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h84878C949A9B9D9FA1A3A7ACADABA9A8A8A9A9A8A5A09B959595918C86807A7575736F69635E5D5C5B5A5956515256585A5B5C5D5D62696E737475797F81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R11(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h7F87909293928F8C8A87878C919CA9B5BBC1C1BBB5ABA2989189898C8F969D9F9D9A91887D72675E554F51535961676868665F59524B4544434A5864737F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R12(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h828A94A3B2B8B8B4AEA8A5A5A19993969DA6AEB2AFA9A5A29A8C80766C67676968686D73716A635B524D4C4841404855616C747471747978726D6E7077;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R13(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h817C7A8C9E9A87756F7F8F8F81726E80929385746E7C88877968657786877A6A6A7B898A7A68687786887C6C6D7E91958777768290938574738293978B;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R14(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 527;
reg [9:0] ptr;
localparam [lenmax:0] data = 528'h7E797C7B7F88949B998E80757070747D88919490867C726B676A727D848785827A6F65646D79848B8D8A857D75706E737C858B909491897E77767D88929798958F87;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R15(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 511;
reg [8:0] ptr;
localparam [lenmax:0] data = 512'h8178635042372C2D32384A5F728699AAADB0B1ACA7A199928B86817D7C7A7B80848584847D736A635C575C656D747C828486888D92979CA2A6AAAEADA39C8D7E;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R16(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h8A959B9792908D898383848A8C8786888788898D908C8A8E969D9B9B9D9F9D968E87848481808085867D7A787775706E6C6359514B48444751555A606D7D81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R17(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 975;
reg [9:0] ptr;
localparam [lenmax:0] data = 976'h8D979A9895908E8E9092919294989FA5A7A59E968C8785848382808083898F9596928C8682828485868685878B929798958C837C78787A7E80848A95A1ACB4B7B3ADA7A3A1A09F9B9897979A9C9D9991857A726D6A6865615E5E60656A6B67605853504F50504F4E50565F6567655E554D49484C5053585F6977;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R18(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 983;
reg [9:0] ptr;
localparam [lenmax:0] data = 984'h7C787676777672695D5041322824262E3C4D5E6C767D7D7A746E6A686B717A838B90918B8175685D5553565E687480888B8C8B86817F80848C96A1ABB1B4B4AEA49A90888484889098A1A8ACAAA7A29C9897999CA1A7ABADAAA3998D7E6F635B57585D63696E70706E6A6766696E788694A2AEB6B8B4ACA2968B82;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R19(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 983;
reg [9:0] ptr;
localparam [lenmax:0] data = 984'h7F8390969DA1A09E9A938C87827E7F80848C969EA6AEB1B1B2B4B7B9BABBBBBAB9B8B8B7B6B3B4BAC1C7CCD1D2D0CEC8C1B9B1A8A0978F88817A7977787E848B909695928E84796E63574F4B4643424040404145484C4F525353524D4642403F404245484B4E54595F676F75767975706A60564E4B474B555F6A77;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R20(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 511;
reg [8:0] ptr;
localparam [lenmax:0] data = 512'h7F706761625F5C5F617A87867F6E74817F7E80959B8C8A878A969D9A8285968778716C6D6465646D858987796B7A7F7B797F938C80807D8691968B75898A7D81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R21(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h7F8598A7A898878492988A736C6E78898F887668728E9E9A8A78737783959D999393989B9081776F6A6464737D85898376635A677B8382786E6A64636872;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R22(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h7D7062554D4A4850616D695E585658616C777F87929E9D897572767A7F868E94948E8888878384919C9D9B978C7E78808A8E8D94A7B3AB9F98938F8C86;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R23(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h7F88959EABB2ADA9AAA59B938C7D6C625B52536A898D89887F86A3A693908E817F87887F7B8892918E8F8E85808C928A7C69595B5B53575A4D495A666A717D;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R24(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h8E9DA8AFBBC9CECEC6B79D85766551484C4943556B6C6973797F8C9A9E9D9A8C827B6A5F60646364605F6F818684868D93929590867D6B5E6B76726A7A827F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R25(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 519;
reg [9:0] ptr;
localparam [lenmax:0] data = 520'h858C919BAEBBBCC7CCCBD0CFD3D3D2CDC4BFB7A9A7A198938A8682818077766F676D707373727469686C6C6D6863564E4839343936302F393D4B5A60687175767E;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R26(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 215;
reg [7:0] ptr;
localparam [lenmax:0] data = 216'h817F92A7A2AEBBCAD2D2D0CFBF94757B8584604E5F302C34517781;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R27(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 511;
reg [8:0] ptr;
localparam [lenmax:0] data = 512'h817F87A0B6CCDFEFF4E9D4BEAFA49790959FA29989776D6B6F757B7F7E79726D6D6F7070707071716F6C6B6C6A645E5D5F615D54494444454B596A7474717884;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R28(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 519;
reg [9:0] ptr;
localparam [lenmax:0] data = 520'h817F82705161655A636373988192A5808D998B847E7C928B87827A9D7F536C6D66766C72908A8B827C877B6F7E7E68859C878C9F959E97667E988684738EA7877F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R29(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h81765D493A34353D475564707A7F838585848382818080807F80808081818282838383848485858585848485858687898A8D9094999EA3A9AFB1AFA89C897F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R30(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h81683122384D5C69747A7C7B75737A919B807DAAC2904F465E81B8D9CAB2A090847E82888B8C89848181796E7C8A857B83908E837D818989817778838B877F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R31(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 511;
reg [8:0] ptr;
localparam [lenmax:0] data = 512'h8BAEC3A98F8E887061605B555B6367728BA2A99B87796E666466676A6E7071737A8EA2B2B7B0AAA49D9896918D8A898789866139486A6E6D797F7A7A7C80817F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R32(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 135;
reg [7:0] ptr;
localparam [lenmax:0] data = 136'h818695A7ADB2AE937A7669564E4A527083;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R33(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 511;
reg [8:0] ptr;
localparam [lenmax:0] data = 512'h818A98A5B0B7B5B0ACABADB2BBC6CAC6C0BCB6AFACACB1BBC7CED1D0C7B9ACA49B90867D746C6765625D554A3E32271C15101015202D3840474D56626D747B81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R34(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 471;
reg [8:0] ptr;
localparam [lenmax:0] data = 472'h83878D92979C9FA3A7ACB0B0B0AFAFB0B1B2B0ACA297908B8A8782796F6863615E5956535358595957555556595C6063666A6E6E6E7073777A7D7F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R35(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h868D949DA3AAADB2B6B7B8B5B3B2ADABA6A19D9490908A86817D82867E7C8284878A939B927F7E8C8C806D5F5F5B4E474E56514A4B556063636A73797E;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R36(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 279;
reg [8:0] ptr;
localparam [lenmax:0] data = 280'h7F826745332A2D343F49535B62686D7175777A7B7C7D7E7E7E7E7D7D7D7E7E7E7E7F7F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R37(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 199;
reg [7:0] ptr;
localparam [lenmax:0] data = 200'h818284878B8F94989DA1A3A2A19E9D9DA0A6AFB9C2C2B79A7F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R38(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 1719;
reg [10:0] ptr;
localparam [lenmax:0] data = 1720'h7F848D92969A9B989B9993918E8B89878281817E7D7D7D7C828385888C8E8E8D8984807B7776767D7E8E8E9E98A89A9584796A5853454A4E555A6270777F847E827F817F817F817F817F817F8CA3ADAAAEA99F9995837D78717377747A82878C9192999997939288837C7376737A747C7A79726E6A675B67666567726E757E7A756F66666363656C77857D837D837C857A896D80D8B1C1B3B9B1B3ADAEAAA9A6A5A2A09D9C99989594918F8D8B89878583817E7D7A79767572716E6D6A69666562615E5D5A59565652524E4F494C4264867D827F817F81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R39(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 527;
reg [9:0] ptr;
localparam [lenmax:0] data = 528'h817B777F5932312B18243D403F4C565A646E6F6E72747576797B7C7C7F82828183848283878785878A898A888E8E8C92999F9EABB7C9C4CCD9CAB5B8B08E8E8C7F81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R40(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h95A3A3A1A4A7A39D9EA7ADAFB0B1B1ACA7A1958C858183888A8D8F84776B666A6D6B63636A68696861565A6D746D696D695D626D70686C7B786555546A81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R41(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h828D96A0A2928685878C90999B939AA4AAB4B3A69278676571879FADB0A5937F6B605C627284949F9E95877460514B4743454E555C5F626367737E83838484;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R43(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h7F858B8F9BA5AFABA188737888857A7781979EA4AFC2CBC2B59E908E84736C757B8496A49D846D5E55494249525D6C736E6361615A5C5E66717476746C737F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R44(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h7F848F959A9A99989899999A9A98949292969B9E9C958F847668616063696F73726F6C6B6A6D72787A7C7D8081827E746B676A6D727578787A7B797270777F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R45(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h8D9EABB2AEA8A5A8AFB5B9BDC6D2DDE3E5DFD0BBA79B9B9FA3A6A9A79A8A7B726D675E5349413C3D3F3F3B3B3E464A463C373A45515B60615D5858606B77;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R46(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h7F8A9EB3C9D8E1E8EFF5F9F6ECDECFC2B6ADA59C938E8F949DA8B2B7B3A7988776635447392A1F19161312121418202C373E444A525A61686E706E6E717B81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R47(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 591;
reg [9:0] ptr;
localparam [lenmax:0] data = 592'h818C898E9798A2C7CFC2BEB5ADA4A69D9A8E868FA89D938C83807558433A2A2B3F556A969E988B7F75737A817D726E747B817A6A708087949581756C6D7A6E758387817672696779817F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R48(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h6E5F5D5F646D7579766F645A56565C67737F84827B74716F6F6F737A8083817D7B7C7D848C92939595918A888B8E91979C9E9B958F8E91969B9FA2A08F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R49(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h8186898B8987858483828383838281807F7F80807F7E7F80807F82868A8C8A8784827F7E80838584827E797371727376797D7F7F7D7C7B7A7A7A7B7C7D;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R50(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h7F78777A7D7E7C78716A6664615C59595C5E6061636567696B6D6F71727477797B7D80828587898B8D909295989A9C9EA0A2A4A5A7A8A8A8A6A29B92867F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R51(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h7D797A7C7F7F7C78716C6A6864615F6062646667696A6C6D6F7172747577797B7C7E80828486888A8C8E9092949698999B9D9FA0A2A2A2A19F9B948C82;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R52(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 511;
reg [8:0] ptr;
localparam [lenmax:0] data = 512'h8191A3B0B9BDBBB5B0A69F9A938F8B8886898D93999996938D867C71675B54505050535C66758595A4B0BABEBDB3A597867562503D2E2422283343546579837F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R53(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h848C929595979DA4A7A9ABAFB2B4B0ADAEAEAEA8A2A0A09C96908B88857E787674716D6863625E5B565352514F4C4E55585958575E63656870757D807F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R54(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h858D949A9FA4AAAEB2B7BABDBFC0C2C2C2C2C0BDB9B5B0ACA7A19C96918D87817C76716C67615B544C45413D393633313031353A3F454B515A626B727B;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R55(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 927;
reg [9:0] ptr;
localparam [lenmax:0] data = 928'h8A9DA9A7A3A5ADB6C7D8E2E5E6EAE7DDD8D5C6B09D9BA2A7A6A3A09C998D7B71737567564F504E4C52606664584D4C5358545457575557606E7981837F73727F817D828B9096A7B9C0CDD5CDBDAEA19486898F8B8382827B7C898F8C878185888983776E716D6668767C79736E695F5450596E81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R56(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 479;
reg [8:0] ptr;
localparam [lenmax:0] data = 480'h82878F98A3B0C0D2E0DDBB83523A3439465667747A7B7A7878797B7D7D7C7B7B7B7C7D7E7F80818182828382807C787573716F6D6C6C6D7074797F81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R57(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h817B63585554565A6068717981878B8C8B8987837F7B79777777787A7B7D7E7E7E7D7B7876747373747577797C7E8082838486898F97A4BDE3ECCD9A7F817F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R59(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h7D88956B658092A180759A9C858E927675AAB58B817D969E8A81909E8489A08868819791807583867C77777F78717E7E6A626C786D656A69696459606E787F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R60(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h88949EA7AEB3B5B6B5B3B0ABA39A8F857C76716E6E6F706F6F6F6F717275787D838C96A1A9ACA59786756A656464605B5757595B5C5C5E6063676C727A81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R61(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h82817E7B7976737174787C7D8499B3BF8A706A68706B6C7779777978787D97A3B194707077847C7776797C7E83878E98A3A98E756E6A737575787D7F818581;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R62(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 567;
reg [9:0] ptr;
localparam [lenmax:0] data = 568'h817F817F82795D5E5D5D5D5E5F60626366676F746F69655E5A54514A494143375C9C929490928F908F9191939496979A9B9EA0A2A4A6A8AAACACAEAEAFAEAFACAE967D817F817F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R63(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h7E72665C534C4745434345474B4F53585D62676B6F73777A7C7F808283848585858585858585858585858585888F98A2ACB5BDC4C9CCCDCAC2B7AA9C8D81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R64(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h7F8C9B9E9C9B98918A84807C7876726C686A6F74797E838585827D7A7A7C81868F9BA3A6A9A9A8A9ABACA9A19586746458514D4D50555C63666562656C7982;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R65(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h7F879BA182461B376C736D69786F718C988F827A786C697069636A74787B7E7E7A7A8899A3A1998F8C94A2ACB1ADA1979291908C847F7D7C7979797B797F81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R66(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 519;
reg [9:0] ptr;
localparam [lenmax:0] data = 520'h82A8906A8584878C8E9E877F9EB6B3A8968B908C8073665F646167707777727A807F828A919A9D9C9C978D878281818182837C797A75706B604F49504E66817F81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R67(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h81765B587A978C715F667C887B5B4E607B8A8674686D7E857A6B6367757E74635C6269747C858C8B91989C9793989EA5A7A49C97958D847D89A5B8A7867F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R68(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h7F85A3C2DBE2CEAF9A9CAEB1A38C7A75674A3A456187A6B7B7A588674A3732406088A8B8B8AF9E88726055545D6F838E918F8C87837D7164574B41404963;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R69(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h7A66524448648FB9D2D8CAAC9186837B7785908A847C78888F807D7D70625B5A61707D85898D8F887E7A7A77716C6A6A6A6D7179858C8D8D8B8C9091897F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R70(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h7F7A6D5A45373D5A85B3D6E3D8BC9E8881807D7368594B403A373943546C8597A2A7AAAEB1B2AEA8A099938E89837E7A797B7E7F7E7C77726F6F72777D7F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R71(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 511;
reg [8:0] ptr;
localparam [lenmax:0] data = 512'h8298A3A8ADA89D917E737885949C927B707A8CA2AEACADB8C7CFCFCAC3B59F846856545B69787F7D7B78737377787A7D7A726A625B514537261E23345075817F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R72(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h7F776D645A524B45434244494F575F666D727576767572706F6F7073777D848C939CA3AAB0B3B6B7B5B3AEA9A39D98928E8B8888888B8E91949493908982;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R73(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 527;
reg [9:0] ptr;
localparam [lenmax:0] data = 528'h7F848C91979A9FA3A8ACB0B2B4B5B7B8B8B8B6B3B0ADAAA7A4A3A29F988E867F79746F6A6662605C58534E4A4746454545474B4E5254555659606870777C84847F81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R75(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 527;
reg [9:0] ptr;
localparam [lenmax:0] data = 528'h817F84949C9F9FA4AAADB1B3B2B5B9BCBBB8B5B4B2B0ABA7A4A5A4A09994918C847B6B605C5A5856504C4A4B4B46444345494B4B4F54595E6061666C73787D83827F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R76(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 967;
reg [9:0] ptr;
localparam [lenmax:0] data = 968'h7F849BB0C0C4C7C2B4B0AFAFA9A29C9B968D88817D7C8EA4AAA399978D81776D635A59595C656E736E645A5755565C636C71675C5658616A7072767E808181858A8E898C949EA2A2A1A5AAA8A19B98908881858B8F8F8A84828385817C7263564E4E4944403C3B404855626969676B6F716D6156545E6C7981;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R77(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h81898C8B8A8C949C9F9E9D9E978D85807C797675777B80827E7C7C7C80868C8F8F8D8881828B94948E877F7771727573737066615F5D5E626B747876747A;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R78(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h848F98A1AAB2BAC1C8CED3D7DADCDEDEDDDCD9D5D1CCC6BFB7AFA69D948A81776D635950484039332E2925232120202224272B30363C444B545D666F7981;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R79(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h7F8797A3AFBAC5CED7DFE6EBF0F4F6F7F7F6F3EFEAE4DDD6CEC5BBB0A4978A7C6F63584D43393027201914100D0B0A0A0B0E131920272F38424C5763707D;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R80(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 479;
reg [8:0] ptr;
localparam [lenmax:0] data = 480'h89A9C3C8BFB5B0B1A285757376797A7A7A7A7A7A7A7A7A7A7A7A7B7B7B7B7B725338323A48657F86827D7C7D7E7E7E7E7E7E7E7E7E7E7E7F7F7F7F7F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R81(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h8286898D9094979A9CA0A2A5A7AAACAFB1B4B5B8B9BCBCC0BFC4A46C717375787A7E7E8382854B253232393B4043484B5053585B6063686B7073777B7E;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R82(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h83919A9FA1A8B6C8D5D7DCE1E4ECF1F0E8DFD5CBBAAAA0989189837D797E807C74675D58554F423A35333738362F2E302D2B2C343A3F444C5663727D817E7F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R83(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 815;
reg [9:0] ptr;
localparam [lenmax:0] data = 816'h755F4C3C3129252324272B2E32363A3F464B51565E65686A6B6F737575747273777E84898D91939596959496989997918C89888B8F959A989188807B76716C67656466696E73777C7F8282838586868586888B9095999FA8B2BBC2C8CCCFD0CFC8BCAC9B877F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R84(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h8176574D5A626A77818B9AAAA08C80706C706E818C796D737E89867E8892887974716E8299897E8D8881867460676A6A7071717B8A91989E9AA6BAAC988C;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R85(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h7E8889868C9698909DA29599A29B91928C8088857673797F7F8383889C9D9CA2A1A3A5A1948F917F7573665C59564F53574C515F5F5F65656876796F75;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R86(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 655;
reg [9:0] ptr;
localparam [lenmax:0] data = 656'h6F503D32292E363E474F575F64676969696B6C6F73777C80817C7A797A7A7A797876787A7C7F8182838586888B8E8B827C7A797C83888B8E8F908F8B88878687888B949DA8B4BFC4CACCCECDCAC6BAAD9B83;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R87(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 479;
reg [8:0] ptr;
localparam [lenmax:0] data = 480'h848A91969CA1A7ABB0B3B8B9BEBEC2C0C69E5D707374777B7E83868B8F949AAAA6A09C999391583B4A444544454447474A4C4F52565A5F64696E747A;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R88(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h82888C8F94949A9896938E8C8A8E8F929494989AA2A5A9A9A39F96928C888681817F81848789888782807C79756F685D554C46454345464C5158646D79;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R89(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h879BAEB7B8B6B5B6B8BBBDBDB9AC9B8F87817F8081828485858584838281817D75685C544F505254575A5D5F61636567696B6D6F71737576787A7B7D7E;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R91(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h8189929CA6B0BAC1C9CDD0D1CFCCC3BAADA192827464594F48444145495058616B747D848A8E8F908E8C86807A746E68625E5A595858585B5E62666B727A;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R92(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h7B746B64605A5857565658595B5E606366686B6D6E7071727374757778787B7D7D8182838787898E8F93989A9EA4A6AAAEAEB0B1AEAEABA5A29B938D84;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R93(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h7764523F3128272D38465767798D9EB1BDC5C7C2BBB4A7A099928E8A87878B8F969997938E867D7164594C454242434A5562748699A9B7C1C4C2B5A797857F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R95(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 479;
reg [8:0] ptr;
localparam [lenmax:0] data = 480'h7C76706C69676667696A6B6C6D6E6E6F7071727374757678797B7C7D7F808183848687898A8B8C8E8F919293959697989898989693908D8B8A898783;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R96(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h8392A09F9B97959EA4B2C1BFBDBCBAC1C9D6E3DED2BC9A8274717778797B74757E838987817B6D645F52463B2F2A2325323D4C5B60615D5A626876817F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R97(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 999;
reg [9:0] ptr;
localparam [lenmax:0] data = 1000'h81838587898B8C8E90919394928F8E908F8781838A8F8F8F8F8C8886858583817F7E7D7C7D7E7F80807F7D7B787573717171727375777775757879746D6D73797A7B7C7B7A797B7E8081838587898B8D9092939597989A9A9A9A99989795928F89848283827B726E70716F6A67635F5D5D606265676B6E727477797C7E;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R98(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 967;
reg [9:0] ptr;
localparam [lenmax:0] data = 968'h7F8596A7B6BCC3CACECFD0D0CAC3BCB5ADA69D99989797979899999794918D8A8884745F49352B25201F211F20262E36405161717B7F848788898A8A8B8C8D909395979FA7AFB7C1CEDADEDAD4CCC3BEC0BCAD9C897B71675F5E5D5C5C5C5C5D6064686B6965625C534B4340403D3C3D42464F5C63686D7885;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R99(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h818489949BA4AFB2ADA9A9A9A9AEB0ACA4968A828081818384858B8F91929598999A94887E797473797D797572695B524A46474843444A515B687377797B7E;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R100(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 527;
reg [9:0] ptr;
localparam [lenmax:0] data = 528'h817F81746C654F483B2C273931273F42435460676777797C948B889090A3A69C9AADBDACADAE9DA5AD977F8989767B7E777A828C909A9FA0ACB0B7B59D98A4917F81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R101(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 503;
reg [8:0] ptr;
localparam [lenmax:0] data = 504'h828B9198A2A9ADB3B6B7B5B0AAA29B9289817A76716C6A6C717478797676746F6C6A67615D575456585D636B717881878B8D8C8A89857E7876767778787C81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R103(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 303;
reg [8:0] ptr;
localparam [lenmax:0] data = 304'h7F634E493736444E5D696C7678767C7E78797B7A8288838998A19D969AABACA4AAACA5AA9D87;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R104(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 511;
reg [8:0] ptr;
localparam [lenmax:0] data = 512'h817F86929CA7AFC1BFAB9984695B5B6A75879CA0ACA18C7C777869676D747F84859EB1A8AB98807E634E4D506D7D81837E949F8A8B7D605F564D57534F5C6C7E;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R105(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h868B8D92999C9B9A97928F8D8F939186756457555B667280858990949289837F7A726A696E757A879CABB2B0AB9F8E7F7167676C6A5F57575B62676F7C83;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R107(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 511;
reg [8:0] ptr;
localparam [lenmax:0] data = 512'h817F827236318CCBD3D3C18A776F38215386736B736A6976514A7CBEDAC7A0696DA8BB9472624E5A7961577D94726C808099B4A5858782686485907B8A91938E;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R108(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 463;
reg [8:0] ptr;
localparam [lenmax:0] data = 464'h819098999DA0ACBECCCEC7CAD6DEDDDBD8DADAC7B3AEAFAAA5A2998D867E736F6E61504A49413F3A322F35352D292D323E444856666F72778082;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R109(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 487;
reg [8:0] ptr;
localparam [lenmax:0] data = 488'h642F1A1D1B2B507DB7DCE1DBC096684A3F42546F98B4C4C5B49B80716B6A708298A7ACAAA08C7869625D5D656F787C81888A847870727D90A4ACA5A294;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R110(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 511;
reg [8:0] ptr;
localparam [lenmax:0] data = 512'h829CAFAFACAFB4AEA7A7B2BBBDBEBFBFBAB4AC9D918882838A8D91958876675E6366665C59636262625A4B4B62716A6266655555646B63627579644C445A7C81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R111(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h8EA8C8D2CCBBA287766A60626A7176787E87939B9E9D968A7B6D615E666F7C8A9AA6ABA5967C62554D4B4C51565F6B849CAEB2A88F70504A51637179787A;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R112(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 927;
reg [9:0] ptr;
localparam [lenmax:0] data = 928'h82898E959BA19D968F88827B746E6763686C71757A7F83888D8E8C8A8887858482807F7E7D7D7C7C7B7A7A797A7D8083878A8D909396928D87827D78726D67666B71777C82888E939998928E89847F7B76716D6F71737577787A7C7E80828587898B8D8F92938F8A86817C77726D68676E737A7F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R113(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 583;
reg [9:0] ptr;
localparam [lenmax:0] data = 584'h817F817E899784839AA58B7588A1906E87D3D892739BAE753D5C917E484E888F553A66876A485F88886D7FBED4AE99B0C2A279757F8285878A877A6D635955514F4D5A77817171817F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R114(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 495;
reg [8:0] ptr;
localparam [lenmax:0] data = 496'h7D6F62534636364049545E676A6C727F8C98A1ABB1B3B6B3AEA9A096929BA4A9A6A6998572675F585A5E626A717D8B999D9A988F857C7B79797878787A7C;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R115(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 263;
reg [8:0] ptr;
localparam [lenmax:0] data = 264'h7F837B50221127465C492D2E354A767C6455658FBACCC9C4CADBE9DEC2B1AFA284;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R116(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 1399;
reg [10:0] ptr;
localparam [lenmax:0] data = 1400'h7F8695A4B0B4B7B5B2AFB3BBC2C6CAD0CEC7BCB6B2B0B1B4B8BEC1C1C0C3C8CCCFD1D4D4D5D6D2CBC5C4C8CFD3CCBEB3ABA9AAB3B6B1ADABACA8A49E95897E767273767A7A7777746F6C6A6A68635D5A544F5058616663605F6064686A66615E5D61686A6A6A6D6D6A64605E5C5B5E63686C6D6C6C737F8C94948F8984848991979DA2AAADABA7A29E9A948D857F7A7777756E655B534E4944403E3C3A393C4244474C51575D6166696D7073777B7D;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R117(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 1575;
reg [10:0] ptr;
localparam [lenmax:0] data = 1576'h81858C939395989C9EA0A0A1A5A7A8A9ACABAAA9AAAAAAA8A9A8A8A6A6A7A8A8A6A7A9AAA8A5A4A2A19C9D9B9B99918B89888782817C797C7B787373737576737374737172716B6B6A6A68696E6F6E6C6B6B6E70727476777A7A787A7D8183828385888B8D8F8D90929396959596999A9A9997999A9A9894979694939393909091908E8B8B8A87828486807B797B7B79736F6C6866656462605F5E5C5A55545250524F4F5051514F4D4E4D4B4C4F4E4F53555858585D5E6063686E7070707177797A7C8081;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R118(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 631;
reg [9:0] ptr;
localparam [lenmax:0] data = 632'h7F817D9C8B4669A59769A09999A9B0B9A8B1CBBEBCB2CCB3AFA6A2C3BC968DA38CA28484A9785470556D603E3B67373A3E3C3959353E30492D28382D343E5632455E5A7554487EA3867768837E817F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R119(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 1295;
reg [10:0] ptr;
localparam [lenmax:0] data = 1296'h7F7D7F7C7F7E7C7D807C807E7C817D7F7D7D7F7E7D807D7F807E7F7E80827E7D817F807D817F827E82808082807F80828082837D82857F808480808281827E8482808082838182808386807F848381888080858284828181858281828186807F848382817F8185837D828183837E85818182828080827F837F8082827E7E83817D7F857E7F807F817C7F807E80807E7F7F7F7E7D7D817E7E7E7E7D807E7D7F7E7E7F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R120(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 663;
reg [9:0] ptr;
localparam [lenmax:0] data = 664'h7F7770708079858A8B968D7E766F687A77898E8C9491867D6E6273718B968E8B89858779616C6E8C9991898A878F836B6F6B83949185878693876D706B7E8B8B858B87928A74736C78828282918E91887E817F;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R121(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 783;
reg [9:0] ptr;
localparam [lenmax:0] data = 784'h7C7A7A7B7E8286878582807F80828585837F7B7A7B7C7F7F7F7F7F80818385858280807F828383817E7B797A7C7D8080818181828484817F7E7E7E7F8283838585827E7C7C7B7D7F7F80817F7F808181818181807F7F83848482817F7D7C7B7C7D7E;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R123(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 975;
reg [9:0] ptr;
localparam [lenmax:0] data = 976'h7F817F826F5B819495866064949B88755F78A595736A698CA984626D7D99A06D5B7D929C8D5E6290998E785975A19680817F817F817F827E898D99909B8E7E77577366727E8C949891938280607C787981798C8A897D797E7A7B7F758C6F87817C7377858E8C8B88A2898478657969777A827F817F817F817F81;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R124(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 751;
reg [9:0] ptr;
localparam [lenmax:0] data = 752'h7F7E7E7D7D7E7E7D7E7F81808181828282807F7F7F7F80807F7E7F81828584848789898785858784807D7D7E7B77767778787878797B7B7D8081828282838484838382818182828180818282838486868583848786858483828384848381;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R125(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 407;
reg [8:0] ptr;
localparam [lenmax:0] data = 408'h7F807F7F7E7E7F808182818284848383848381807F7F7E7D7C7B7B7A7A7A7A7A7A7B7C7B7C7C7B7B7B7B7B7C7C7C7C7D7D7D7E;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R126(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 1263;
reg [10:0] ptr;
localparam [lenmax:0] data = 1264'h8687868584827B7371757A7D828C908C87827F808084817E7775747273767E888C868483858787888C8C82797370717273767C7F7F828585878C918E8984807C7775777B7D77717174797B7E858D949892887F7B7B7B7C7F81807C7471757A7A7A81888B8B8786828481818483827A7471707075808B8D8985838283828384838385827D7775767578818B8A84838686817B78787C828283827F7F7D7D7E;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R127(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 295;
reg [8:0] ptr;
localparam [lenmax:0] data = 296'h82807E80807D7A7B828A8C857C78777A8085857F7E808485827C77797D7C7B7C7E80828481;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule

module R128(input CLK, input ENABLE, output reg [7:0] wave);
localparam lenmax = 855;
reg [9:0] ptr;
localparam [lenmax:0] data = 856'h685342393B38323239486990D3FDFFF7CFA5714741414F617E9AA8B3BABFB9AEA4998B7B7677797B79736753453B332D2C3239434F5F6E7A8590999EA1A6ABAFB4C0CDDDEFF7F9C9806B687796A6B3A789642C0E01041D3B6B90AFBBA68C603D2F2213114887BEEEE5CFA6;
always @(posedge CLK) begin
	if (ENABLE) begin
		wave = data[ptr+7 -:8];
		ptr = ptr + 8;
		if (ptr >= lenmax) ptr = 0;
	end
	else wave = 0;
end
endmodule
