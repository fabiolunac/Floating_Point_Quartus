module iir2_tb();

reg clk;
reg signed [22:0] x;
wire [31:0] y;

integer iir2_out;

iir2 iir2(clk, x, y);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin

	iir2_out = $fopen("iir2_out.txt");
		
	x = 1;
	#10;
	x = 0;
	

end

always @(posedge clk) begin
	$fdisplay(iir2_out   , "%X", y);
end


endmodule