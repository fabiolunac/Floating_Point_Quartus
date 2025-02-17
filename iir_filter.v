module iir_filter
#(
	parameter MAN = 23,
	parameter EXP = 8

)
(
	input clk,
	input signed [MAN-1:0] x,
	output [MAN+EXP:0] y_float
);

//Saídas de cada filtro
wire [MAN+EXP:0] y1_float;
wire [MAN+EXP:0] y2_float;
wire [MAN+EXP:0] y3_float;
wire [MAN+EXP:0] y4_float;
wire [MAN+EXP:0] y5_float;
wire [MAN+EXP:0] y6_float;

//Auxiliares
wire [MAN+EXP:0] s1;
wire [MAN+EXP:0] s2;
wire [MAN+EXP:0] s3;
wire [MAN+EXP:0] s4;
wire [MAN+EXP:0] s5;

//Instacia dos modulos
iir1 iir1(clk, x, y1_float);
iir2 iir2(clk, x, y2_float);
iir3 iir3(clk, x, y3_float);
iir4 iir4(clk, x, y4_float);
iir5 iir5(clk, x, y5_float);
iir6 iir6(clk, x, y6_float);

//Soma final
soma soma1(y1_float, y2_float, s1);
soma soma2(y3_float, y4_float, s2);
soma soma3(y5_float, y6_float, s3);
soma soma4(s1, s2, s4);
soma soma5(s3, s4, y_float);

endmodule