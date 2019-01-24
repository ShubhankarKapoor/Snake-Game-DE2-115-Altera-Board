module heartbeat(input wire VGA_CLK,
input wire reset,
output wire pulse);

parameter WIDTH=8;
reg [(WIDTH-1):0] count;
assign pulse=&count;

always @(posedge VGA_CLK) begin
	if(reset)
		count<={WIDTH{1'b0}};
	else
		count<=count+1'b1;
	end
endmodule