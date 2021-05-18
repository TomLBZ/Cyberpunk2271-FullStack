module PWM12(
	input [7:0] strength,
	input PWM_CLK,
	output wire PWM_OUT
);

reg [7:0] steps = 0;

always @ (posedge PWM_CLK) begin steps = steps + 1; end

assign PWM_OUT = steps > strength ? 0 : PWM_CLK;

endmodule

module PWM_SD(input [7:0] strength, input clk, output out);
	reg [8:0] accu;
	always @(posedge clk) accu <= accu[7:0] + strength[7:0];
	assign out = accu[8];
endmodule
