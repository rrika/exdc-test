module seq_impl (
	input clk,
	input rst,
	input [2:0] i,
	output o
);
	reg [2:0] x;
	always @(posedge clk) begin
		if (rst) begin
			x <= 0;
		end else begin
			x <= i;
		end
	end
	assign o = x[0] ^ x[1] ^ x[2];
endmodule

module seq_care (
	input clk,
	input rst,
	input [2:0] i,
	input [2:0] x,
	output care
);
	assign care = x[0] == x[2];
endmodule
