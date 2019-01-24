module tick_clock(CLOCK_50,move_clock);
input wire CLOCK_50;
output reg move_clock;
reg [21:0]count;
always @( posedge CLOCK_50 )
	begin
		count <= count + 1;
		if(count == 1777777)
		begin
			move_clock <= ~move_clock;
			count <= 0;
		end	
	end
	endmodule
