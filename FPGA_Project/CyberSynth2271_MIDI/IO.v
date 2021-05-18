module IO( 
	//input CLK_250MHZ,
	//input EXT_CLK,
	input CLK_24MHZ,
	input [7:0] data_pins_i,
	output SPEAKER1
);
//wire [7:0] wavepos_current;
//PWM12 pwm1(wavepos_current, CLK_24MHZ, SPEAKER1);
PWM_SD pwm(data_pins_i, CLK_24MHZ, SPEAKER1);
/*
localparam [10:0] val = 11'd1500;
reg [10:0] c;
reg clk16k;
always @(posedge CLK_24MHZ) begin
	if (c < val / 2) clk16k = 1;
	else if (c < val) clk16k = 0;
	else c = 0;
	c = c + 1;
end
*/
//MIDI8 midi(EXT_CLK, CLK_24MHZ, clk16k, data_pins_i, wavepos_current1, wavepos_current2);
/*
wire [6:0] note = data_pins_i[1:1] ? 7'd72 : 7'd69;
localparam [6:0] velocity = 7'd127;
localparam [6:0] keypressure = 7'd127;
localparam [6:0] chanpressure = 7'd127;
wire [15:0] channelEn = 16'b0 | data_pins_i[7:5];
wire [15:0] channelSet = 16'b0 | data_pins_i[4:2];
wire [6:0] instrSet = 7'b0 | data_pins_i[0:0];
ROLAND8 r(CLK_24MHZ, clk16k, channelEn, instrSet, channelSet, note, velocity, keypressure, chanpressure, wavepos_current);
*/
endmodule
