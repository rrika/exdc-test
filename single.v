module single (
	input [2:0] x,
	output o,
	output care
);
	assign o = x[0] ^ x[1] ^ x[2];
	assign care = x[0] == x[2];
endmodule
