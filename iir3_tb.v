module iir3_tb();

reg clk;
reg signed [22:0] x;
wire [31:0] y;

integer iir3_out;

iir3 iir3(clk, x, y);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin

	iir3_out = $fopen("iir3_out.txt");
		
	x = 1;
	#10;
	x = 0;
	

end

always @(posedge clk) begin
	$fdisplay(iir3_out   , "%X", y);
end


endmodule