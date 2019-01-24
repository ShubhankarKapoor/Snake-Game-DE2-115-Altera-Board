module snakebody(VGA_CLK,move_clock,CounterX,CounterY,start,reset,head,sw0, sw1, sw2, sw3);

input wire start,reset;

//wire a1,a2,a3,a4 and then assign them keys
wire [2:0] direction;
input VGA_CLK,move_clock;
input wire [11:0]CounterX;
input wire [11:0]CounterY;
output reg head;
//body;
reg [11:0]stackbodyX[63:0];//To store all the x coordinates of 63 parts of the snake
reg [11:0]stackbodyY[63:0];//To store all the y coordinates of 63 parts of the snake
reg [4:0] length =1;//ask if it is correct
integer count, count1;
input wire sw0, sw1, sw2, sw3;

/*
debouncer deb(.X0(KEY[0]),.X1(KEY[1]),.X2(KEY[2]),.X3(KEY[3]),.VGA_CLK(VGA_CLK),.reset(reset),
				  .X0_deb(sw0),.X1_deb(sw1),.X2_deb(sw2),.X3_deb(sw3)
				  );
*/
direction dir(.VGA_CLK(VGA_CLK),.sw0(sw0), .sw1(sw1), .sw2(sw2), .sw3(sw3),
			 .direction(direction),.reset(reset));


always @(posedge move_clock)
begin
	if(start && (~reset))
		//if(direction!=3'd0)
		begin
			for(count=63;count>0;count=count-1)
				begin
					if (count<=length-1)
					begin	
						stackbodyX[count]=stackbodyX[count-1];
						stackbodyY[count]=stackbodyY[count-1];
					end
				end		
	case(direction)//change the head only, body will follow from above
		3'd1:stackbodyX[0]=stackbodyX[0]+5;//move right
		3'd2:stackbodyX[0]=stackbodyX[0]-5;//move left
		3'd3:stackbodyY[0]=stackbodyY[0]+5;//move down
		3'd4:stackbodyY[0]=stackbodyY[0]-5;//move up
		default:
		begin
		stackbodyX[0]=stackbodyX[0];
		stackbodyY[0]=stackbodyY[0];
		end
	endcase
	end
	else if(~start || reset)
		begin
			//intial conditions for the head
			stackbodyX[0]<=320;
			stackbodyY[0]<=240;
			for (count1=1;count1<=63;count1=count1+1)
				begin
					stackbodyX[count1]<=510;//values that are not visible on screen but still there
					stackbodyY[count1]<=720;
				end
		end

end


//Defining head
always @(VGA_CLK)
begin
	head<=(CounterX>stackbodyX[0] && CounterX<(stackbodyX[0]+5)) && (CounterY>stackbodyY[0] && CounterY<stackbodyY[0]+5);
end

//Defining body

endmodule