module DATA( 
	input CLK,
	input [6:0] instrument1,
	input [6:0] instrument2,
	input [6:0] instrument3,
	input [6:0] instrument4,
	input [6:0] instrument5,
	input [6:0] instrument6,
	input [6:0] instrument7,
	input [6:0] instrument8,
	input [6:0] instrument9,
	input [6:0] instrument10,
	input [6:0] instrument11,
	input [6:0] instrument12,
	input [6:0] instrument13,
	input [6:0] instrument14,
	input [6:0] instrument15,
	input [6:0] instrument16,
	input [9:0] pointer1,
	input [9:0] pointer2,
	input [9:0] pointer3,
	input [9:0] pointer4,
	input [9:0] pointer5,
	input [9:0] pointer6,
	input [9:0] pointer7,
	input [9:0] pointer8,
	input [9:0] pointer9,
	input [9:0] pointer10,
	input [9:0] pointer11,
	input [9:0] pointer12,
	input [9:0] pointer13,
	input [9:0] pointer14,
	input [9:0] pointer15,
	input [9:0] pointer16,
	output reg [11:0] value1,
	output reg [11:0] value2,
	output reg [11:0] value3,
	output reg [11:0] value4,
	output reg [11:0] value5,
	output reg [11:0] value6,
	output reg [11:0] value7,
	output reg [11:0] value8,
	output reg [11:0] value9,
	output reg [11:0] value10,
	output reg [11:0] value11,
	output reg [11:0] value12,
	output reg [11:0] value13,
	output reg [11:0] value14,
	output reg [11:0] value15,
	output reg [11:0] value16
);

reg [7:0] wavetable [68391:0];
reg [16:0] offset1;
reg [16:0] offset2;
reg [16:0] offset3;
reg [16:0] offset4;
reg [16:0] offset5;
reg [16:0] offset6;
reg [16:0] offset7;
reg [16:0] offset8;
reg [16:0] offset9;
reg [16:0] offset10;
reg [16:0] offset11;
reg [16:0] offset12;
reg [16:0] offset13;
reg [16:0] offset14;
reg [16:0] offset15;
reg [16:0] offset16;

initial begin
	$readmemh("Roland_Waves_mem.txt", wavetable);
end

OFFSET_MUX om1(CLK, instrument1, offset1);
OFFSET_MUX om2(CLK, instrument2, offset2);
OFFSET_MUX om3(CLK, instrument3, offset3);
OFFSET_MUX om4(CLK, instrument4, offset4);
OFFSET_MUX om5(CLK, instrument5, offset5);
OFFSET_MUX om6(CLK, instrument6, offset6);
OFFSET_MUX om7(CLK, instrument7, offset7);
OFFSET_MUX om8(CLK, instrument8, offset8);
OFFSET_MUX om9(CLK, instrument9, offset9);
OFFSET_MUX om10(CLK, instrument10, offset10);
OFFSET_MUX om11(CLK, instrument11, offset11);
OFFSET_MUX om12(CLK, instrument12, offset12);
OFFSET_MUX om13(CLK, instrument13, offset13);
OFFSET_MUX om14(CLK, instrument14, offset14);
OFFSET_MUX om15(CLK, instrument15, offset15);
OFFSET_MUX om16(CLK, instrument16, offset16);

always @(posedge CLK) begin
	value1 <= wavetable[offset1 + pointer1];
	value2 <= wavetable[offset2 + pointer2];
	value3 <= wavetable[offset3 + pointer3];
	value4 <= wavetable[offset4 + pointer4];
	value5 <= wavetable[offset5 + pointer5];
	value6 <= wavetable[offset6 + pointer6];
	value7 <= wavetable[offset7 + pointer7];
	value8 <= wavetable[offset8 + pointer8];
	value9 <= wavetable[offset9 + pointer9];
	value10 <= wavetable[offset10 + pointer10];
	value11 <= wavetable[offset11 + pointer11];
	value12 <= wavetable[offset12 + pointer12];
	value13 <= wavetable[offset13 + pointer13];
	value14 <= wavetable[offset14 + pointer14];
	value15 <= wavetable[offset15 + pointer15];
	value16 <= wavetable[offset16 + pointer16];
end

endmodule


module OFFSET_MUX(
	input CLK,
	input [6:0] instr,
	output reg [16:0] offset
);

localparam [16:0] addrOffset_1 = 0;
localparam [16:0] addrOffset_2 = 496;
localparam [16:0] addrOffset_3 = 984;
localparam [16:0] addrOffset_4 = 1480;
localparam [16:0] addrOffset_5 = 1976;
localparam [16:0] addrOffset_6 = 2464;
localparam [16:0] addrOffset_7 = 2960;
localparam [16:0] addrOffset_8 = 3448;
localparam [16:0] addrOffset_9 = 3944;
localparam [16:0] addrOffset_11 = 4440;
localparam [16:0] addrOffset_12 = 4928;
localparam [16:0] addrOffset_13 = 5416;
localparam [16:0] addrOffset_14 = 5944;
localparam [16:0] addrOffset_15 = 6456;
localparam [16:0] addrOffset_16 = 6960;
localparam [16:0] addrOffset_17 = 7936;
localparam [16:0] addrOffset_18 = 8920;
localparam [16:0] addrOffset_19 = 9904;
localparam [16:0] addrOffset_20 = 10416;
localparam [16:0] addrOffset_21 = 10912;
localparam [16:0] addrOffset_22 = 11400;
localparam [16:0] addrOffset_23 = 11904;
localparam [16:0] addrOffset_24 = 12408;
localparam [16:0] addrOffset_25 = 12928;
localparam [16:0] addrOffset_26 = 13144;
localparam [16:0] addrOffset_27 = 13656;
localparam [16:0] addrOffset_28 = 14176;
localparam [16:0] addrOffset_29 = 14680;
localparam [16:0] addrOffset_30 = 15184;
localparam [16:0] addrOffset_31 = 15696;
localparam [16:0] addrOffset_32 = 15832;
localparam [16:0] addrOffset_33 = 16344;
localparam [16:0] addrOffset_34 = 16816;
localparam [16:0] addrOffset_35 = 17304;
localparam [16:0] addrOffset_36 = 17584;
localparam [16:0] addrOffset_37 = 17784;
localparam [16:0] addrOffset_38 = 19504;
localparam [16:0] addrOffset_39 = 20032;
localparam [16:0] addrOffset_40 = 20528;
localparam [16:0] addrOffset_41 = 21032;
localparam [16:0] addrOffset_43 = 21536;
localparam [16:0] addrOffset_44 = 22040;
localparam [16:0] addrOffset_45 = 22536;
localparam [16:0] addrOffset_46 = 23040;
localparam [16:0] addrOffset_47 = 23632;
localparam [16:0] addrOffset_48 = 24120;
localparam [16:0] addrOffset_49 = 24608;
localparam [16:0] addrOffset_50 = 25104;
localparam [16:0] addrOffset_51 = 25592;
localparam [16:0] addrOffset_52 = 26104;
localparam [16:0] addrOffset_53 = 26592;
localparam [16:0] addrOffset_54 = 27080;
localparam [16:0] addrOffset_55 = 28008;
localparam [16:0] addrOffset_56 = 28488;
localparam [16:0] addrOffset_57 = 28992;
localparam [16:0] addrOffset_59 = 29496;
localparam [16:0] addrOffset_60 = 29992;
localparam [16:0] addrOffset_61 = 30496;
localparam [16:0] addrOffset_62 = 31064;
localparam [16:0] addrOffset_63 = 31560;
localparam [16:0] addrOffset_64 = 32064;
localparam [16:0] addrOffset_65 = 32568;
localparam [16:0] addrOffset_66 = 33088;
localparam [16:0] addrOffset_67 = 33584;
localparam [16:0] addrOffset_68 = 34080;
localparam [16:0] addrOffset_69 = 34576;
localparam [16:0] addrOffset_70 = 35072;
localparam [16:0] addrOffset_71 = 35584;
localparam [16:0] addrOffset_72 = 36080;
localparam [16:0] addrOffset_73 = 36608;
localparam [16:0] addrOffset_75 = 37136;
localparam [16:0] addrOffset_76 = 38104;
localparam [16:0] addrOffset_77 = 38600;
localparam [16:0] addrOffset_78 = 39096;
localparam [16:0] addrOffset_79 = 39592;
localparam [16:0] addrOffset_80 = 40072;
localparam [16:0] addrOffset_81 = 40560;
localparam [16:0] addrOffset_82 = 41064;
localparam [16:0] addrOffset_83 = 41880;
localparam [16:0] addrOffset_84 = 42376;
localparam [16:0] addrOffset_85 = 42864;
localparam [16:0] addrOffset_86 = 43520;
localparam [16:0] addrOffset_87 = 44000;
localparam [16:0] addrOffset_88 = 44488;
localparam [16:0] addrOffset_89 = 44976;
localparam [16:0] addrOffset_91 = 45472;
localparam [16:0] addrOffset_92 = 45960;
localparam [16:0] addrOffset_93 = 46464;
localparam [16:0] addrOffset_95 = 46944;
localparam [16:0] addrOffset_96 = 47432;
localparam [16:0] addrOffset_97 = 48432;
localparam [16:0] addrOffset_98 = 49400;
localparam [16:0] addrOffset_99 = 49904;
localparam [16:0] addrOffset_100 = 50432;
localparam [16:0] addrOffset_101 = 50936;
localparam [16:0] addrOffset_103 = 51240;
localparam [16:0] addrOffset_104 = 51752;
localparam [16:0] addrOffset_105 = 52248;
localparam [16:0] addrOffset_107 = 52760;
localparam [16:0] addrOffset_108 = 53224;
localparam [16:0] addrOffset_109 = 53712;
localparam [16:0] addrOffset_110 = 54224;
localparam [16:0] addrOffset_111 = 54720;
localparam [16:0] addrOffset_112 = 55648;
localparam [16:0] addrOffset_113 = 56232;
localparam [16:0] addrOffset_114 = 56728;
localparam [16:0] addrOffset_115 = 56992;
localparam [16:0] addrOffset_116 = 58392;
localparam [16:0] addrOffset_117 = 59968;
localparam [16:0] addrOffset_118 = 60600;
localparam [16:0] addrOffset_119 = 61896;
localparam [16:0] addrOffset_120 = 62560;
localparam [16:0] addrOffset_121 = 63344;
localparam [16:0] addrOffset_123 = 64320;
localparam [16:0] addrOffset_124 = 65072;
localparam [16:0] addrOffset_125 = 65480;
localparam [16:0] addrOffset_126 = 66744;
localparam [16:0] addrOffset_127 = 67040;
localparam [16:0] addrOffset_128 = 67896;

always @ (posedge CLK) begin
	case (instr)
	1: offset = addrOffset_1;
	2: offset = addrOffset_2;
	3: offset = addrOffset_3;
	4: offset = addrOffset_4;
	5: offset = addrOffset_5;
	6: offset = addrOffset_6;
	7: offset = addrOffset_7;
	8: offset = addrOffset_8;
	9: offset = addrOffset_9;
	11: offset = addrOffset_11;
	12: offset = addrOffset_12;
	13: offset = addrOffset_13;
	14: offset = addrOffset_14;
	15: offset = addrOffset_15;
	16: offset = addrOffset_16;
	17: offset = addrOffset_17;
	18: offset = addrOffset_18;
	19: offset = addrOffset_19;
	20: offset = addrOffset_20;
	21: offset = addrOffset_21;
	22: offset = addrOffset_22;
	23: offset = addrOffset_23;
	24: offset = addrOffset_24;
	25: offset = addrOffset_25;
	26: offset = addrOffset_26;
	27: offset = addrOffset_27;
	28: offset = addrOffset_28;
	29: offset = addrOffset_29;
	30: offset = addrOffset_30;
	31: offset = addrOffset_31;
	32: offset = addrOffset_32;
	33: offset = addrOffset_33;
	34: offset = addrOffset_34;
	35: offset = addrOffset_35;
	36: offset = addrOffset_36;
	37: offset = addrOffset_37;
	38: offset = addrOffset_38;
	39: offset = addrOffset_39;
	40: offset = addrOffset_40;
	41: offset = addrOffset_41;
	43: offset = addrOffset_43;
	44: offset = addrOffset_44;
	45: offset = addrOffset_45;
	46: offset = addrOffset_46;
	47: offset = addrOffset_47;
	48: offset = addrOffset_48;
	49: offset = addrOffset_49;
	50: offset = addrOffset_50;
	51: offset = addrOffset_51;
	52: offset = addrOffset_52;
	53: offset = addrOffset_53;
	54: offset = addrOffset_54;
	55: offset = addrOffset_55;
	56: offset = addrOffset_56;
	57: offset = addrOffset_57;
	59: offset = addrOffset_59;
	60: offset = addrOffset_60;
	61: offset = addrOffset_61;
	62: offset = addrOffset_62;
	63: offset = addrOffset_63;
	64: offset = addrOffset_64;
	65: offset = addrOffset_65;
	66: offset = addrOffset_66;
	67: offset = addrOffset_67;
	68: offset = addrOffset_68;
	69: offset = addrOffset_69;
	70: offset = addrOffset_70;
	71: offset = addrOffset_71;
	72: offset = addrOffset_72;
	73: offset = addrOffset_73;
	75: offset = addrOffset_75;
	76: offset = addrOffset_76;
	77: offset = addrOffset_77;
	78: offset = addrOffset_78;
	79: offset = addrOffset_79;
	80: offset = addrOffset_80;
	81: offset = addrOffset_81;
	82: offset = addrOffset_82;
	83: offset = addrOffset_83;
	84: offset = addrOffset_84;
	85: offset = addrOffset_85;
	86: offset = addrOffset_86;
	87: offset = addrOffset_87;
	88: offset = addrOffset_88;
	89: offset = addrOffset_89;
	91: offset = addrOffset_91;
	92: offset = addrOffset_92;
	93: offset = addrOffset_93;
	95: offset = addrOffset_95;
	96: offset = addrOffset_96;
	97: offset = addrOffset_97;
	98: offset = addrOffset_98;
	99: offset = addrOffset_99;
	100: offset = addrOffset_100;
	101: offset = addrOffset_101;
	103: offset = addrOffset_103;
	104: offset = addrOffset_104;
	105: offset = addrOffset_105;
	107: offset = addrOffset_107;
	108: offset = addrOffset_108;
	109: offset = addrOffset_109;
	110: offset = addrOffset_110;
	111: offset = addrOffset_111;
	112: offset = addrOffset_112;
	113: offset = addrOffset_113;
	114: offset = addrOffset_114;
	115: offset = addrOffset_115;
	116: offset = addrOffset_116;
	117: offset = addrOffset_117;
	118: offset = addrOffset_118;
	119: offset = addrOffset_119;
	120: offset = addrOffset_120;
	121: offset = addrOffset_121;
	123: offset = addrOffset_123;
	124: offset = addrOffset_124;
	125: offset = addrOffset_125;
	126: offset = addrOffset_126;
	127: offset = addrOffset_127;
	128: offset = addrOffset_128;
	endcase
end

endmodule