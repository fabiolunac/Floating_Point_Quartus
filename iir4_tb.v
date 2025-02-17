module iir4_tb();

reg clk;
reg signed [22:0] x;
wire [31:0] y;

integer iir4_out;

iir4 iir4(clk, x, y);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin

	iir4_out = $fopen("iir4_out.txt");
		
	x = 1;
	#10;
	x = 0;
	

end

always @(posedge clk) begin
	$fdisplay(iir4_out   , "%X", y);
end


endmodule