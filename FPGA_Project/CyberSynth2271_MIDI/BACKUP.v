module BACKUP( );



endmodule

module CLK_16K(
	input CLK250M,
	output reg outReg
);

localparam halflimit = 7812;
localparam limit = 15625;

reg [13:0] counter;
always @(posedge CLK250M) begin
	counter = counter + 1;
	if (counter <= halflimit ) outReg = 0;
	else if (counter <= limit) outReg = 1;
	else begin
		counter = 0;
		outReg = 0;
	end
end

endmodule
module ENVELOPE_CTRL12 (
	input CLK,
	input RST,
	input new_sample,
	input new_note_pulse,
	input release_note_pulse,
	input [11:0] sustain_value,
	output reg [11:0] volume_d,
	input [11:0] volume,
	output reg [4:0] state
);

`define ATTACK 3'd1
`define DECAY 3'd2
`define SUSTAIN 3'd3
`define RELEASE 3'd4
`define BLANK 3'd5

`define VOLUME_RESET 12'h000
//`define VOLUME_RESET 18'h00800
//`define VOLUME_MAX 18'h01000
`define VOLUME_MAX 12'h7FF

`define VOLUME_SUSTAIN 12'h030

reg latch_new_note;
reg latch_release_note;

always @(posedge CLK) begin
	if (RST == 1'b1) begin
		latch_new_note <= 1'b0;
		latch_release_note <= 1'b0;
	end
	else begin
		if (new_note_pulse == 1'b1) latch_new_note <= 1'b1;
		if (release_note_pulse== 1'b1) latch_release_note <= 1'b1; 
		if (state[2:0] == `ATTACK && latch_new_note == 1'b1) latch_new_note <= 1'b0;
		if((state[2:0] == `RELEASE || state[2:0] == `BLANK) && latch_release_note == 1'b1) 
			latch_release_note <= 1'b0;
	end
end


always @(posedge CLK) begin
	if (RST== 1'b1) begin
		state <= `BLANK;
		volume_d <= `VOLUME_RESET;
	end
	else begin	
		if (new_sample == 1'b1) begin
			volume_d <= volume;
			case (state[2:0])
			`BLANK: begin
				if (latch_new_note == 1'b1) state[2:0] <= `ATTACK;
				else state[2:0] <= `BLANK;			 
			end
			`ATTACK: begin
				if ( `VOLUME_RESET <= volume && volume < `VOLUME_MAX ) state[2:0] <= `ATTACK;
				else state[2:0] <= `DECAY;
			end
			`DECAY: begin
				if (latch_new_note == 1'b1) state[2:0] <= `ATTACK;
				else if (latch_release_note == 1'b1) state[2:0] <= `RELEASE;
				else if (volume > sustain_value) state[2:0] <= `DECAY;
				else state[2:0] <= `SUSTAIN;
			end
			`SUSTAIN: begin
				if (latch_new_note == 1'b1) state[2:0] <= `ATTACK;
				else if (latch_release_note == 1'b1) state[2:0] <= `RELEASE;
				else state[2:0]<= `SUSTAIN;
			end				
			`RELEASE: begin
				if (latch_new_note == 1'b1) state[2:0] <= `ATTACK;
				else if (volume > `VOLUME_RESET && volume[11] == 1'b0) state[2:0] <= `RELEASE;
				else state[2:0] <= `BLANK;
			end
			endcase
		end
		state[3] <= latch_new_note;
		state[4] <= latch_release_note;
	end
end

endmodule


module MIXER12_MONO(
	input wire [11:0] channel0,
	input wire [11:0] channel1,
	input wire [11:0] channel2,
	input wire [11:0] channel3,
	input wire [11:0] channel4,
	input wire [11:0] channel5,
	input wire [11:0] channel6,
	input wire [11:0] channel7,
	input wire [11:0] channel8,
	input wire [11:0] channel9,
	input wire [11:0] channel10,
	input wire [11:0] channel11,
	input wire [11:0] channel12,
	input wire [11:0] channel13,
	input wire [11:0] channel14,
	input wire [11:0] channel15,
	output wire [11:0] mono_o
);

reg [11:0] mono;
wire [15:0] sum = channel0 + channel1 + channel2 + channel3 + 
	channel4 + channel5 + channel6 + channel7 + channel8 + channel9 + 
	channel10 + channel1 + channel2 + channel3 + channel4 + channel15;
assign mono_o = (sum[15:12] > 0) ? 12'd4095 : sum[11:0];

endmodule