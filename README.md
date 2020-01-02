ABC has a feature to use an external don't-care specification during optimization (in the `mfs`/`mfs2` pass). These sources demonstrate its use through yosys. Confusingly there's both a `exdc_set` and `care_set` command and different abc passes use either one or the other. Another quirk is that when `care` is hardwired to false, the specification is ignored entirely (as if it was hardwired to true). The `exdc` network is serialized in some formats like blif, leading to confusion in some readers (like yosys). It can be cleared beforehand with the `exdc_free` command. The `care` network isn't serialized and can't be freed.

## Combinatorial Logic

Run this example with `yosys -s comb.ys`.

```verilog
module comb_impl (input [2:0] x, output o);
	assign o = x[0] ^ x[1] ^ x[2];
endmodule

module comb_care (input [2:0] x, output care);
	assign care = x[0] == x[2];
endmodule
```

The inputs in both signatures match exactly. The expression `x[0] ^ x[1] ^ x[2]` will be simplified to just `x[1]`.

## Sequential Logic

Run this example with `yosys -s seq.ys`.

```verilog
module seq_impl (..., input [2:0] i, output o);
	reg [2:0] x;
	always @(posedge clk) begin ...  end
	assign o = x[0] ^ x[1] ^ x[2];
endmodule

module seq_care (..., input [2:0] i, input [2:0] x,	output care);
	assign care = x[0] == x[2];
endmodule
```

The inputs of the care module are the inputs as well as the registers of the main module. The expression `x[0] ^ x[1] ^ x[2]` will be simplified to `x[1]`. Except `x` is a register this time.

## Combinatorial logic (single module)

Run this example with `yosys -s single.ys`.

```verilog
module single (input [2:0] x, output o, output care);
	assign o = x[0] ^ x[1] ^ x[2];
	assign care = x[0] == x[2];
endmodule
```

As the first one, except the .ys file differs to extract the two aspects from the same module.

## Combinatorial logic (using $assume)

TODO
