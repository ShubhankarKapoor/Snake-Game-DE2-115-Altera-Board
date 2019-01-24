
module vga_char1 (
	counterX,
	counterY,
	baseX,
	baseY,
	vga_r,
	vga_g,
	vga_b);

input [11:0] counterX;
input [11:0] counterY;
input [11:0] baseX;
input [11:0] baseY;

output [9:0] vga_r;
output [9:0] vga_g;
output [9:0] vga_b;

wire inBox;

assign inBox = counterX > baseX &&
					counterX < baseX + 10 &&
					counterY > baseY &&
					counterY < baseY + 200;

assign vga_r = inBox ? 10'h3ff : 10'b0;
assign vga_g = inBox ? 10'h3ff : 10'b0;
assign vga_b = inBox ? 10'h3ff : 10'b0;

endmodule
