module iir3
#(
	parameter MAN = 23,
	parameter EXP = 8,
	
	parameter [MAN+EXP:0] b0     = 32'hf5e7f6fd,
	parameter [MAN+EXP:0] b1     = 32'hf4594af5,
	parameter [MAN+EXP:0] a1     = 32'hf272b021,
	parameter [MAN+EXP:0] a2     = 32'h73d3b646,
	
	parameter [MAN+EXP:0] a1_neg = 32'h7272b021,
	parameter [MAN+EXP:0] a2_neg = 32'hf3d3b646
	
)
(
	input clk, 
	input signed [MAN - 1:0] x,
	output [MAN+EXP:0] y_float
);

//Conversão de x para float
wire [MAN+EXP:0] x_float;
int2float i2f(x, x_float);

//Registradores
reg [MAN+EXP:0] ry1_float = 0; 
reg [MAN+EXP:0] ry2_float = 0; 
reg [MAN+EXP:0] rx_float  = 0;

//Auxiliares
wire [MAN+EXP:0] yz1;
wire [MAN+EXP:0] yz2;
wire [MAN+EXP:0] yp1;
wire [MAN+EXP:0] yp2;
wire [MAN+EXP:0] s1;
wire [MAN+EXP:0] s2;

//Cálculos
mult mult1(x_float  , b0    , yz1);
mult mult2(rx_float , b1    , yz2);
mult mult3(ry1_float, a1_neg, yp1);
mult mult4(ry2_float, a2_neg, yp2);

soma soma1(yz1, yz2, s1);
soma soma2(yp1, yp2, s2);
soma soma3(s1, s2, y_float);

//Realimentacao

always @ (posedge clk) begin
	rx_float  <= x_float;
	ry2_float <= ry1_float;
	ry1_float <= y_float;
end


endmodule