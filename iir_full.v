module iir_full
#(
	parameter MAN = 23,
	parameter EXP = 8,
	
	parameter [MAN+EXP:0] b0 = 32'h5ceb1dfb,
	parameter [MAN+EXP:0] b1 = 32'h73d56fe4,
	parameter [MAN+EXP:0] b2 = 32'h74f8b00b,
	parameter [MAN+EXP:0] b3 = 32'hf44907f1,
	parameter [MAN+EXP:0] b4 = 32'hf4d8850a,
	parameter [MAN+EXP:0] b5 = 32'hf3c392b5,
	parameter [MAN+EXP:0] b6 = 32'heffd5ebe,
	parameter [MAN+EXP:0] b7 = 32'he679cde1,
	
	parameter [MAN+EXP:0] a1 = 32'hf457a43a,
	parameter [MAN+EXP:0] a2 = 32'hf4cd4f08,
	parameter [MAN+EXP:0] a3 = 32'hf2d33543,
	parameter [MAN+EXP:0] a4 = 32'hf2589799,
	parameter [MAN+EXP:0] a5 = 32'hf14f50e5,
	parameter [MAN+EXP:0] a6 = 32'h72464913,
	parameter [MAN+EXP:0] a7 = 32'hed46d7d6,
	parameter [MAN+EXP:0] a8 = 32'h5869b246,
	
	parameter [MAN+EXP:0] a1_neg = 32'h7457a43a,
	parameter [MAN+EXP:0] a2_neg = 32'h74cd4f08,
	parameter [MAN+EXP:0] a3_neg = 32'h72d33543,
	parameter [MAN+EXP:0] a4_neg = 32'h72589799,
	parameter [MAN+EXP:0] a5_neg = 32'h714f50e5,
	parameter [MAN+EXP:0] a6_neg = 32'hf2464913,
	parameter [MAN+EXP:0] a7_neg = 32'h6d46d7d6,
	parameter [MAN+EXP:0] a8_neg = 32'hd869b246
)
(
	input clk,
	input signed [MAN-1:0] x,
	output [MAN+EXP:0] y_float
);

//Conversão de x para float
wire [MAN+EXP:0] x_float;
int2float i2f(x, x_float);

//Registradores
reg [MAN+EXP:0] ry1_float = 0; 
reg [MAN+EXP:0] ry2_float = 0;
reg [MAN+EXP:0] ry3_float = 0;
reg [MAN+EXP:0] ry4_float = 0;
reg [MAN+EXP:0] ry5_float = 0;
reg [MAN+EXP:0] ry6_float = 0;
reg [MAN+EXP:0] ry7_float = 0;
reg [MAN+EXP:0] ry8_float = 0;
 
reg [MAN+EXP:0] rx1_float  = 0;
reg [MAN+EXP:0] rx2_float  = 0;
reg [MAN+EXP:0] rx3_float  = 0;
reg [MAN+EXP:0] rx4_float  = 0;
reg [MAN+EXP:0] rx5_float  = 0;
reg [MAN+EXP:0] rx6_float  = 0;
reg [MAN+EXP:0] rx7_float  = 0;

//Auxiliares
wire [MAN+EXP:0] yz0, yz1, yz2, yz3, yz4, yz5, yz6, yz7;
wire [MAN+EXP:0] yp1, yp2, yp3, yp4, yp5, yp6, yp7, yp8;
wire [MAN+EXP:0] s1, s2, s3, s4, s5, s6, s7, s8;
wire [MAN+EXP:0] s9, s10, s11, s12, s13, s14;


//Cálculos
mult m1(b0, x_float  , yz0);
mult m2(b1, rx1_float, yz1);
mult m3(b2, rx2_float, yz2);
mult m4(b3, rx3_float, yz3);
mult m5(b4, rx4_float, yz4);
mult m6(b5, rx5_float, yz5);
mult m7(b6, rx6_float, yz6);
mult m8(b7, rx7_float, yz7);

mult m9(a1_neg,  ry1_float, yp1);
mult m10(a2_neg, ry2_float, yp2);
mult m11(a3_neg, ry3_float, yp3);
mult m12(a4_neg, ry4_float, yp4);
mult m13(a5_neg, ry5_float, yp5);
mult m14(a6_neg, ry6_float, yp6);
mult m15(a7_neg, ry7_float, yp7);
mult m16(a8_neg, ry8_float, yp8);

soma soma1(yz0, yz1, s1);
soma soma2(yz2, yz3, s2);
soma soma3(yz4, yz5, s3);
soma soma4(yz6, yz7, s4);

soma soma5(yp1, yp2, s5);
soma soma6(yp3, yp4, s6);
soma soma7(yp5, yp6, s7);
soma soma8(yp7, yp8, s8);

soma soma9(s1 , s2, s9);
soma soma10(s3, s4, s10);
soma soma11(s5, s6, s11);
soma soma12(s7, s8, s12);

soma soma13(s9, s10, s13);
soma soma14(s11, s12, s14);

soma soma15(s13, s14, y_float);




always @(posedge clk) begin
	ry8_float <= ry7_float;
	ry7_float <= ry6_float;
	ry6_float <= ry5_float;
	ry5_float <= ry4_float;
	ry4_float <= ry3_float;
	ry3_float <= ry2_float;
	ry2_float <= ry1_float;
	ry1_float <= y_float;
	
	rx7_float <= rx6_float;
	rx6_float <= rx5_float;
	rx5_float <= rx4_float;
	rx4_float <= rx3_float;
	rx3_float <= rx2_float;
	rx2_float <= rx1_float;
	rx1_float <= x_float;
end



endmodule