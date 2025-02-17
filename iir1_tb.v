module iir1_tb();

reg clk;
reg signed [22:0] x;
wire [31:0] y;

integer iir1_out;

iir1 filter(clk, x, y);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin
	x = 1;
	#10;
	x = 0;
	
	iir1_out = $fopen("iir1_out.txt");
end

always @(posedge clk) begin
	$fdisplay(iir1_out   , "%X", y);
end


endmodule