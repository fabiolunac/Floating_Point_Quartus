module iir_full_tb();

reg clk;
reg signed [22:0] x;
wire [31:0] y;

integer iir_full_out;

iir_full iir_full(clk, x, y);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin

	iir_full_out = $fopen("iir_full.txt");
		
	x = 1;
	#10;
	x = 0;
	

end

always @(posedge clk) begin
	$fdisplay(iir_full_out   , "%X", y);
end


endmodule