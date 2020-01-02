module comb_impl (
	input [2:0] x,
	output o
);
	assign o = x[0] ^ x[1] ^ x[2];
endmodule

module comb_care (
	input [2:0] x,
	output care
);
	assign care = x[0] == x[2];
endmodule
