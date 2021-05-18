module NTE_CLK(
	input CLK24M,
	input changeCLK,
	input [6:0] note,
	output reg outreg
);
reg [15:0] max;
reg [15:0] counter;
localparam defaultMax = 16'd30;
initial begin
	max = defaultMax;
end
always @ (posedge changeCLK) begin
	case (note)
	7'd127: max = 16'd31;
	7'd126: max = 16'd33;
	7'd125: max = 16'd35;
	7'd124: max = 16'd37;
	7'd123: max = 16'd39;
	7'd122: max = 16'd42;
	7'd121: max = 16'd44;
	7'd120: max = 16'd47;
	7'd119: max = 16'd50;
	7'd118: max = 16'd53;
	7'd117: max = 16'd56;
	7'd116: max = 16'd59;
	7'd115: max = 16'd63;
	7'd114: max = 16'd66;
	7'd113: max = 16'd70;
	7'd112: max = 16'd74;
	7'd111: max = 16'd79;
	7'd110: max = 16'd84;
	7'd109: max = 16'd88;
	7'd108: max = 16'd94;
	7'd107: max = 16'd99;
	7'd106: max = 16'd105;
	7'd105: max = 16'd111;
	7'd104: max = 16'd118;
	7'd103: max = 16'd125;
	7'd102: max = 16'd133;
	7'd101: max = 16'd140;
	7'd100: max = 16'd149;
	7'd99: max = 16'd158;
	7'd98: max = 16'd167;
	7'd97: max = 16'd177;
	7'd96: max = 16'd188;
	7'd95: max = 16'd199;
	7'd94: max = 16'd210;
	7'd93: max = 16'd223;
	7'd92: max = 16'd236;
	7'd91: max = 16'd250;
	7'd90: max = 16'd265;
	7'd89: max = 16'd281;
	7'd88: max = 16'd298;
	7'd87: max = 16'd315;
	7'd86: max = 16'd334;
	7'd85: max = 16'd354;
	7'd84: max = 16'd375;
	7'd83: max = 16'd397;
	7'd82: max = 16'd421;
	7'd81: max = 16'd446;
	7'd80: max = 16'd472;
	7'd79: max = 16'd501;
	7'd78: max = 16'd530;
	7'd77: max = 16'd562;
	7'd76: max = 16'd595;
	7'd75: max = 16'd631;
	7'd74: max = 16'd668;
	7'd73: max = 16'd708;
	7'd72: max = 16'd750;
	7'd71: max = 16'd795;
	7'd70: max = 16'd842;
	7'd69: max = 16'd892;
	7'd68: max = 16'd945;
	7'd67: max = 16'd1001;
	7'd66: max = 16'd1061;
	7'd65: max = 16'd1124;
	7'd64: max = 16'd1191;
	7'd63: max = 16'd1261;
	7'd62: max = 16'd1336;
	7'd61: max = 16'd1416;
	7'd60: max = 16'd1500;
	7'd59: max = 16'd1589;
	7'd58: max = 16'd1684;
	7'd57: max = 16'd1784;
	7'd56: max = 16'd1890;
	7'd55: max = 16'd2002;
	7'd54: max = 16'd2121;
	7'd53: max = 16'd2248;
	7'd52: max = 16'd2381;
	7'd51: max = 16'd2523;
	7'd50: max = 16'd2673;
	7'd49: max = 16'd2832;
	7'd48: max = 16'd3000;
	7'd47: max = 16'd3178;
	7'd46: max = 16'd3367;
	7'd45: max = 16'd3568;
	7'd44: max = 16'd3780;
	7'd43: max = 16'd4004;
	7'd42: max = 16'd4243;
	7'd41: max = 16'd4495;
	7'd40: max = 16'd4762;
	7'd39: max = 16'd5045;
	7'd38: max = 16'd5345;
	7'd37: max = 16'd5663;
	7'd36: max = 16'd6000;
	7'd35: max = 16'd6356;
	7'd34: max = 16'd6735;
	7'd33: max = 16'd7135;
	7'd32: max = 16'd7560;
	7'd31: max = 16'd8009;
	7'd30: max = 16'd8485;
	7'd29: max = 16'd8991;
	7'd28: max = 16'd9525;
	7'd27: max = 16'd10091;
	7'd26: max = 16'd10690;
	7'd25: max = 16'd11326;
	7'd24: max = 16'd12001;
	7'd23: max = 16'd12713;
	7'd22: max = 16'd13467;
	7'd21: max = 16'd14270;
	7'd20: max = 16'd15117;
	7'd19: max = 16'd16018;
	7'd18: max = 16'd16974;
	7'd17: max = 16'd17977;
	7'd16: max = 16'd19050;
	7'd15: max = 16'd20177;
	7'd14: max = 16'd21386;
	7'd13: max = 16'd22658;
	7'd12: max = 16'd24002;
	7'd11: max = 16'd25433;
	7'd10: max = 16'd26935;
	7'd9: max = 16'd28541;
	7'd8: max = 16'd30234;
	7'd7: max = 16'd32036;
	7'd6: max = 16'd33948;
	7'd5: max = 16'd35970;
	7'd4: max = 16'd38101;
	7'd3: max = 16'd40374;
	7'd2: max = 16'd42749;
	7'd1: max = 16'd45316;
	7'd0: max = 16'd47975;
	default: max = defaultMax;
	endcase
end

always @ (posedge CLK24M) begin
	if (counter >= max) begin
		counter = 0;
		outreg = ~outreg;
	end
	else counter = counter + 1;
end

endmodule
