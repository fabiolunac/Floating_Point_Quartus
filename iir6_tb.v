module iir6_tb();

reg clk;
reg signed [22:0] x;
wire [31:0] y;

integer iir6_out;

iir6 iir6(clk, x, y);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin

	iir6_out = $fopen("iir6_out.txt");
		
	x = 1;
	#10;
	x = 0;
	

end

always @(posedge clk) begin
	$fdisplay(iir6_out   , "%X", y);
end


endmodule