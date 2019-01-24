module generate_apple(VGA_CLK,posX,posY);
input VGA_CLK;
output reg posX,posY;
reg X=90;//Initial position of apple in x
reg Y=90;//Initial position of apple in y

always@(posedge VGA_CLK)//for x position of apple
begin
	X<=X+5;
	if (X<20)
		posX<=X*64;
	else if(X>=20 && X<=91) 
		posX<=X*7;
	else
		posX<=580;
end

always@(posedge VGA_CLK)//for y position of apple
begin
	Y<=Y+3;
	if (Y<20)
		posY=Y*42;
	else if(Y>=20 && Y<=91) 
		posY=Y*5;
	else
		posX=440;
end

endmodule
