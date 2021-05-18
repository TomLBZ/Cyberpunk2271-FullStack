// Verilog testbench created by TD v4.6.18154
// 2021-04-23 02:36:37

`timescale 1ns / 1ps

module IO_tb();

reg CLK_24MHZ;
reg EXT_CLK;
reg [7:0] data_pins_i;
wire SPEAKER;

//Clock process
parameter PERIOD = 1000;
always #(PERIOD/2) EXT_CLK = ~EXT_CLK;

//glbl Instantiate
glbl glbl();

//Unit Instantiate
IO uut(
	.CLK_24MHZ(CLK_24MHZ),
	.EXT_CLK(EXT_CLK),
	.data_pins_i(data_pins_i),
	.SPEAKER(SPEAKER));

//Stimulus process
initial begin
data_pins_i = 8'h9C;
//To be inserted
end

always @(posedge EXT_CLK) begin
	if (data_pins_i == 8'h00) data_pins_i = 8'h9c;
	else if (data_pins_i == 8'h9c) data_pins_i = 8'h50;
	else if (data_pins_i == 8'h50) data_pins_i = 8'h7F;
	else if (data_pins_i == 8'h7F) data_pins_i = 8'h00;
end

endmodule