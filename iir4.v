module iir4
#(
	parameter MAN = 23,
	parameter EXP = 8,
	
	parameter [MAN + EXP:0] b0 = 32'h75d2d845,
	parameter [MAN + EXP:0] a1 = 32'hf45d4952,
	parameter [MAN + EXP:0] a1_neg = 32'h745d4952

)
(
	input clk, 
	input signed [MAN - 1:0] x,
	output [MAN+EXP:0] y_float
);

wire [MAN+EXP:0] x_float;
wire [MAN+EXP:0] y_gained;

reg [MAN+EXP:0] ry_float = 0;

int2float i2f(x, x_float);

wire [MAN+EXP:0] yz;
wire [MAN+EXP:0] yp;

mult mult1 (b0, x_float, yz);
mult mult2 (a1_neg, ry_float, yp);

soma soma1 (yz, yp, y_float);

always @(posedge clk) ry_float <= y_float;

endmodule