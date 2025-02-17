module iir5_tb();

reg clk;
reg signed [22:0] x;
wire [31:0] y;

integer iir5_out;

iir5 iir5(clk, x, y);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin

	iir5_out = $fopen("iir5_out.txt");
		
	x = 1;
	#10;
	x = 0;
	

end

always @(posedge clk) begin
	$fdisplay(iir5_out   , "%X", y);
end


endmodule