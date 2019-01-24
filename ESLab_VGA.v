module ESLab_VGA(CLOCK_50,VGA_R,VGA_G,VGA_B,VGA_BLANK_N,VGA_CLK,VGA_HS,VGA_SYNC_N,VGA_VS,	
					  KEY,
					  SW,LEDR,LEDG
					  );

wire start,reset;
input 						CLOCK_50;
//input KEY[0],KEY[1],KEY[2],KEY[3];
output		  [7:0]		VGA_B;
output		        		VGA_BLANK_N;
output 	reg	        	VGA_CLK;
output		  [7:0]		VGA_G;
output	         		VGA_HS;
output  	  [7:0]		VGA_R;
output	         		VGA_SYNC_N;
output		        		VGA_VS;
input [3:0]KEY;
input [1:0] SW;
output [1:0] LEDR;
output [3:0] LEDG;
wire move_clock;
//wire R,G,B;
always @( posedge CLOCK_50 )
		VGA_CLK <= VGA_CLK + 1;
		

wire [11:0] CounterX;
wire [11:0] CounterY;
reg border;
wire head,body;
wire sw0, sw1, sw2, sw3;

assign reset=SW[0];
assign start=SW[1];
assign LEDR=SW;
assign LEDG=KEY;

/*
debouncer deb(.X0(KEY[0]),.X1(KEY[1]),.X2(KEY[2]),.X3(KEY[3]),.VGA_CLK(VGA_CLK),.reset(reset),
				  .X0_deb(sw0),.X1_deb(sw1),.X2_deb(sw2),.X3_deb(sw3)
				  );
*/
tick_clock tick(.CLOCK_50(CLOCK_50),.move_clock(move_clock));

//define start and reset in terms of switch

// FOR VGA DISPLAY
vga_time_generator vga0(
	.pixel_clk(VGA_CLK),
	.h_disp   (640),
	.h_fporch (16),
	.h_sync   (96), 
	.h_bporch (48),
	.v_disp   (480),
	.v_fporch (10),
	.v_sync   (2),
	.v_bporch (33),
	.vga_hs   (VGA_HS),
	.vga_vs   (VGA_VS),
	.vga_blank(VGA_BLANK_N),
	.CounterY(CounterY),
	.CounterX(CounterX) 
);

snakebody snake(.VGA_CLK(VGA_CLK),.move_clock(move_clock),.CounterX(CounterX),.CounterY(CounterY),
					 .start(start),.reset(reset),.head(head),.sw0(KEY[0]), .sw1(KEY[1]), .sw2(KEY[2]), .sw3(KEY[3]),
					 //.body(body),
					 );

assign VGA_SYNC_N = 1;

//MAKING THE BORDER OF THE GAME

always@(VGA_CLK)
begin
	border<= (CounterX>=0) && (CounterX<=20)||(CounterX>=620) && (CounterX<=640) ||(CounterY>=0) && (CounterY<=20) ||(CounterY>=460) && (CounterY<=480);
end

assign VGA_R = VGA_BLANK_N && border? 10'h0FF : 10'h010;
assign VGA_G = VGA_BLANK_N && head? 10'h0FF : 10'h010;
//assign VGA_B = VGA_BLANK_N ? 0 : 0;
//vga_char1 c1 (CounterX, CounterY, 100, 100, VGA_R, VGA_G, VGA_B);

endmodule
