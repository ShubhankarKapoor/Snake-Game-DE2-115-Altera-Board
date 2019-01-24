module direction(VGA_CLK,sw0, sw1, sw2, sw3,direction,reset);

input wire sw0,sw1,sw2,sw3;
input wire reset;
input VGA_CLK;
output reg [2:0] direction;

/*
debouncer deb(.X0(KEY[0]),.X1(KEY[1]),.X2(KEY[2]),.X3(KEY[3]),.VGA_CLK(VGA_CLK),.reset(reset),
				  .X0_deb(sw1),.X1_deb(sw2),.X2_deb(sw3),X3_deb(sw4)
				  );
*/
				  
always@(VGA_CLK)//or *?
begin
if (~reset)
	begin
		if (~sw0)
		direction=3'd1;
		else if (~sw1)
		direction=3'd2;
		else if (~sw2)
		direction=(3'd3);
		else if (~sw3)
		direction=3'd4;
		else direction=direction;
	end
else 
		direction=3'd0;
end
endmodule