module MIDI8( 
	input EXT_CLK,
	input CLK_24MHZ,
	input SampleCLK,
	input [7:0] midi_i, // 8 bit input
	output wire [7:0] midi_wavepos_o
);
wire note_press, note_release, note_keypress, note_channelpress, rst_cmd, read;
wire [6:0] note;
wire [6:0] velocity;
wire [3:0] channel;
wire [6:0] instrument;
reg [16:0] ptr;
wire [7:0] value;

wire [15:0] currentChan = 1 << channel;
reg [15:0] chanEn;
reg [15:0] chanSet;
reg [6:0] keypress;
reg [6:0] chanpress;
reg [6:0] realvelocity;
wire sampleClk;
NTE_CLK noteclk(CLK24M, EXT_CLK, note, sampleClk);

MIDI_CTRL ctrl(EXT_CLK, rst_cmd, midi_i, 
	note_press, note_release, note_keypress, note_channelpress,
	note, velocity, channel, instrument, rst_cmd, read);

always @ (posedge EXT_CLK) begin
	if (note_press) begin chanEn = chanEn | currentChan; realvelocity = velocity; end
	else if (note_release) begin chanEn = chanEn & ~currentChan; realvelocity = velocity; end
	if (note_keypress) keypress = velocity;
	else keypress = 7'd64;
	if (note_channelpress) chanpress = velocity;
	else chanpress = 7'd64;
	if (chanSet == 0) chanSet = 1 << channel;
	else chanSet = 0;
end

ROLAND8 roland(CLK24M, SampleCLK, chanEn, instrument, chanSet, realvelocity, keypress, chanpress, midi_wavepos_o);

endmodule

module MIDI_CTRL( 
    input EXT_CLK,
    input RST,
    input [7:0] data,
    output reg note_press,
    output reg note_release,
	output reg note_keypress,
	output reg note_channelpress,
    output reg [6:0] note,
    output reg [6:0] velocity,
	output reg [3:0] channel,
	output reg [6:0] instrument,
	output reg rst_cmd,
	output reg read
);

reg [2:0] state;
reg [2:0] cmd;
reg valid;

always @(posedge EXT_CLK) begin
	if (RST == 1) begin
		state <= 3'b100;
		cmd <= 3'b000;
		channel <= 4'b0000;
		note_press <= 1'b0;
		note_release <= 1'b0;
		note_keypress <= 1'b0;
		note_channelpress <= 1'b0;
		note <= 7'b0000000;
		velocity <= 7'b0000000;
		valid <= 1'b0;
		rst_cmd <= 1'b0;
		read <= 1'b0;
	end
	else begin
		case (state)
		3'b000: begin	// wait for ctrl
			if (data[7] == 1'b1) begin
				state <= 3'b001;
				cmd <= data[6:4];
				channel <= data[3:0];
				valid <= data[7];
				if (data == 8'd255) rst_cmd <= 1'b1;
			end
		end
		3'b001: begin	// wait for data1
			if (cmd == 3'b101) begin // "Dx"
				state <= 3'b100; // received all data (single)
				velocity <= data[6:0];	// receive velocity
				note_channelpress <= 1'b1;
			end
			else if (cmd == 3'b100) begin // "Cx"
				state <= 3'b100; // received all data (single)
				instrument <= data[6:0];
			end
			else begin
				state <= 3'b010; // wait for data2
				note <= data[6:0];	// receive notes for "8x", "9x", "Ax"
			end
		end
		3'b010: begin
			state <= 3'b011; // received both data
			velocity <= data[6:0]; // receive velocities for "8x", "9x", "Ax"
		end
		3'b011: begin
			if (cmd == 3'b001 && valid == 1'b1) note_press <= 1'b1; // "9x"
			else if (cmd == 3'b000 && valid == 1'b1) note_release <= 1'b1; // "8x"
			else if (cmd == 3'b010 && valid == 1'b1) note_keypress <= 1'b1; // "Ax"
			else if (cmd == 3'b110 && valid == 1'b1) begin
				read <= 1'b1; // "Ex"
				state <= 3'b100; // finished loading data
			end
		end
		3'b100: begin
			valid <= 1'b0;
			state <= 3'b000;
			note_release <= 1'b0;
			note_press <= 1'b0;
			note_keypress <= 1'b0;
			note_channelpress <= 1'b0;
			read <=1'b0;
		end
		endcase
	end
end

endmodule
