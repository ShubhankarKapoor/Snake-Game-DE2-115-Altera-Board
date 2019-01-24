module debouncer (X0,X1,X2,X3,VGA_CLK,reset,X0_deb,X1_deb,X2_deb,X3_deb);
input wire X0;
input wire X1;
input wire X2;
input wire X3;
input wire VGA_CLK;
input wire reset;
output wire X0_deb;
output wire X1_deb;	//X0 represents the input for the "0" key, X1 for the "1" key
output wire X2_deb;
output wire X3_deb;


wire pulse;

// heartbeat generator instantiation
heartbeat #(21) hb(.VGA_CLK(VGA_CLK),.reset(reset),.pulse(pulse));

//debouncer variables
reg [2:0] ff0, ff1,ff2,ff3;   // debouncer flipflop chains for signal 0 and 1
reg ff0_out, ff1_out, ff2_out, ff3_out; // flipflops for single pulse on transition


always @(posedge VGA_CLK) begin    //events which happen at every clock cycle	
  	ff0_out<=ff0[0]&ff0[1]&ff0[2]; 
	ff1_out<=ff1[0]&ff1[1]&ff1[2];
	ff2_out<=ff2[0]&ff2[1]&ff2[2];
	ff3_out<=ff3[0]&ff3[1]&ff3[2];
	if(reset) begin
	   ff0<=3'b0;
	   ff1<=3'b0;
		ff2<=3'b0;
	   ff3<=3'b0;
	end
	else if(pulse) begin //debouncer section transitions are enabled by pulse
	     ff0[0]<=X0&(~X1)&(~X2)&(~X3);
	     ff0[1]<=ff0[0];
	     ff0[2]<=ff0[1];

	     ff1[0]<=X1&(~X0)&(~X2)&(~X3);
	     ff1[1]<=ff1[0];
	     ff1[2]<=ff1[1];
		  
		  ff2[0]<=X2&(~X1)&(~X2)&(~X0);
	     ff2[1]<=ff2[0];
	     ff2[2]<=ff2[1];

	     ff3[0]<=X3&(~X0)&(~X2)&(~X1);
	     ff3[1]<=ff3[0];
	     ff3[2]<=ff3[1];
	   end
end


//output logic
assign	X0_deb=(ff0[0]&ff0[1]&ff0[2])&(~ff0_out);
assign	X1_deb=(ff1[0]&ff1[1]&ff1[2])&(~ff1_out);
assign	X2_deb=(ff2[0]&ff2[1]&ff2[2])&(~ff2_out);
assign	X3_deb=(ff3[0]&ff3[1]&ff3[2])&(~ff3_out);

endmodule
